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
  final filteredNodes = RxList<TreeNodeModel>();

  final isLoading = RxBool(false);

  final hasErrors = RxBool(false);

  final AssetRepository _assetRepository;
  final LocationRepository _locationRepository;

  final args = Get.arguments as AssetsArgs;

  Timer? _debounceTimer;
  final searchCtrl = TextEditingController();

  final isFilteringEnergy = RxBool(false);
  final isFilteringCritical = RxBool(false);

  bool get isFiltering =>
      isFilteringEnergy.isTrue || isFilteringCritical.isTrue || isSearching;
  bool get isSearching => searchCtrl.text.isNotEmpty;

  AssetsController(this._assetRepository, this._locationRepository);

  @override
  void onInit() {
    super.onInit();
    scheduleMicrotask(loadData);
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    searchCtrl.dispose();
    super.dispose();
  }

  Future<void> loadData() async {
    hasErrors.value = false;
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
    } else {
      hasErrors.value = true;
    }
  }

  Future<void> _loadLocations() async {
    var response = await _locationRepository.getAll(args.companyId);
    if (response.isSuccess) {
      locations = response.data ?? [];
    } else {
      hasErrors.value = true;
    }
  }

  void toggleFilterEnergy() {
    isFilteringCritical.value = false;
    isFilteringEnergy.value = !isFilteringEnergy.value;

    if (isFilteringEnergy.isTrue || isSearching) {
      _filter();
    } else {
      filteredNodes.clear();
    }
  }

  void toggleFilterCritical() {
    isFilteringEnergy.value = false;
    isFilteringCritical.value = !isFilteringCritical.value;

    if (isFilteringCritical.isTrue || isSearching) {
      _filter();
    } else {
      filteredNodes.clear();
    }
  }

  void _buildTree() {
    filteredNodes.clear();
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

  void onSearch() {
    if (searchCtrl.text.trim().isNotEmpty || isFiltering) {
      _filter();
    } else {
      filteredNodes.clear();
    }
  }

  void _filter() {
    final query = searchCtrl.text.trim().isNotEmpty ? searchCtrl.text : null;
    Set<TreeNodeModel> results = {};

    void searchTree(TreeNodeModel treeNode, Set<TreeNodeModel> currentPath) {
      var node = treeNode.node;
      bool matchesSearch = query != null &&
          treeNode.title.toLowerCase().contains(query.toLowerCase());
      bool matchesFilter = (isFilteringCritical.isTrue &&
              (node is AssetModel && (node.status?.isAlert ?? false))) ||
          (isFilteringEnergy.isTrue &&
              (node is AssetModel && (node.sensorType?.isEnergy ?? false)));

      bool shouldInclude = true;

      if (query != null) {
        shouldInclude = matchesSearch;
      }

      if (shouldInclude &&
          (isFilteringCritical.isTrue || isFilteringEnergy.isTrue)) {
        shouldInclude = matchesFilter;
      }

      if (shouldInclude) {
        results.addAll(currentPath);
        results.add(treeNode);
      }
      for (var child in treeNode.children) {
        var newPath = {...currentPath, treeNode};
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
          node.copyWith(
              isExpanded: true,
              children: node.children.expand(filterNodes).toList())
        ];
      }
      var relevantChildren = node.children.expand(filterNodes).toList();
      if (relevantChildren.isNotEmpty) {
        return [node.copyWith(isExpanded: true, children: relevantChildren)];
      }
      return [];
    }

    filteredNodes.value = nodes.expand(filterNodes).toList();
  }
}
