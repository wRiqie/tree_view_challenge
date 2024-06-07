// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view_challenge/app/data/models/args/assets_args.dart';
import 'package:tree_view_challenge/app/data/models/asset_model.dart';
import 'package:tree_view_challenge/app/data/repository/asset_repository.dart';
import 'package:tree_view_challenge/app/data/repository/location_repository.dart';

import '../../data/models/location_model.dart';
import '../../data/models/tree_node_model.dart';

class AssetsController extends GetxController {
  List<AssetModel> assets = [];
  List<LocationModel> locations = [];
  final nodes = RxList<TreeNodeModel>();

  final isLoading = RxBool(false);

  final AssetRepository _assetRepository;
  final LocationRepository _locationRepository;

  final args = Get.arguments as AssetsArgs;

  Timer? _debounceTimer;
  final searchCtrl = TextEditingController();

  AssetsController(this._assetRepository, this._locationRepository);

  @override
  void onInit() {
    super.onInit();
    searchCtrl.addListener(_searchListener);
    scheduleMicrotask(loadData);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    searchCtrl.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    isLoading.value = true;
    await _loadAssets();
    await _loadLocations();
    isLoading.value = false;
    _buildTree();
  }

  Future<void> _loadAssets() async {
    var response = await _assetRepository.getAll(args.companyId);
    if (response.isSuccess) {
      assets = response.data ?? [];
    }
  }

  Future<void> _loadLocations() async {
    var response = await _locationRepository.getAll(args.companyId);
    if (response.isSuccess) {
      locations = response.data ?? [];
    }
  }

  void _buildTree() {
    Map<String, TreeNodeModel> nodeMap = {};

    // Create map of all items [Locations e assets]
    for (var location in locations) {
      nodeMap[location.id] =
          TreeNodeModel<LocationModel>(node: location, title: location.name);
    }
    for (var asset in assets) {
      nodeMap[asset.id] =
          TreeNodeModel<AssetModel>(node: asset, title: asset.name);
    }

    // Organize items with their children
    List<TreeNodeModel> roots = [];

    for (var treeNode in nodeMap.values) {
      var node = treeNode.node;
      if (node is AssetModel) {
        String? parentId = node.parentId ?? node.locationId;
        addNodeToParentOrRoot(treeNode, parentId, nodeMap, roots);
      } else if (node is LocationModel) {
        addNodeToParentOrRoot(treeNode, node.parentId, nodeMap, roots);
      }
    }

    // Add to list
    nodes.clear();
    nodes.value = roots;
  }

  void addNodeToParentOrRoot(TreeNodeModel treeNode, String? parentId,
      Map<String, TreeNodeModel> nodeMap, List<TreeNodeModel> roots) {
    if (parentId != null) {
      var parentNode = nodeMap[parentId];
      if (parentNode != null) {
        parentNode.children.add(treeNode);
      }
    } else {
      roots.add(treeNode);
    }
  }

  List<TreeNodeModel> _search(String searchTerm) {
    Set<TreeNodeModel> results = {};

    void searchTree(TreeNodeModel node, Set<TreeNodeModel> currentPath) {
      if (node.title.toLowerCase().contains(searchTerm.toLowerCase())) {
        results.addAll(currentPath);
        results.add(node);
      }
      for (var child in node.children) {
        var newPath = {...currentPath, node};
        searchTree(child, newPath);
      }
    }

    // Add root nodes and search
    for (var root in nodes) {
      searchTree(root, {});
    }

    // Remove redundant nodes and construct the final tree
    List<TreeNodeModel> filterNodes(TreeNodeModel node) {
      if (results.contains(node)) {
        return [
          TreeNodeModel(
            node: node,
            title: node.title,
          )..children = node.children.expand(filterNodes).toList(),
        ];
      }
      var relevantChildren = node.children.expand(filterNodes).toList();
      if (relevantChildren.isNotEmpty) {
        return [
          TreeNodeModel(
            node: node,
            title: node.title,
          )..children = relevantChildren
        ];
      }
      return [];
    }

    nodes.value = nodes.expand(filterNodes).toList();
    return nodes.expand(filterNodes).toList();
  }

  void _searchListener() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 1500), () {
      if (searchCtrl.text.trim().isNotEmpty) {
        _search(searchCtrl.text);
      } else {
        _buildTree();
      }
    });
  }
}
