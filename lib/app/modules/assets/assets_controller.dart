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
    _buildTree();
    isLoading.value = false;
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
    List<TreeNodeModel> treeNodes = [];
    Map<String, TreeNodeModel> nodeMap = {};

    locations.sort((a, b) => b.name.compareTo(a.name));
    assets.sort((a, b) => b.name.compareTo(a.name));

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

    // Transform model list in widget list
    nodes.clear();
    // for (var node in roots) {
    //   treeNodes.add(_buildNode(node));
    // }
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

  // TreeNode _buildNode(TreeNodeModel treeNode) {
  //   var node = treeNode.node;
  //   if (node is AssetModel) {
  //     return TreeNode(
  //       title: node.name,
  //       leading: SvgPicture.asset(node.getIcon()),
  //       children: treeNode.children.map((e) => _buildNode(e)).toList(),
  //     );
  //   } else {
  //     return TreeNode(
  //       title: node.name,
  //       leading: SvgPicture.asset(AppImages.pin),
  //       children: treeNode.children.map((e) => _buildNode(e)).toList(),
  //     );
  //   }
  // }

  void _searchListener() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 2), () {
      _buildTree();
    });
  }
}
