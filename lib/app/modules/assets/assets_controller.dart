// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tree_view_challenge/app/data/models/args/assets_args.dart';
import 'package:tree_view_challenge/app/data/models/asset_model.dart';
import 'package:tree_view_challenge/app/data/repository/asset_repository.dart';
import 'package:tree_view_challenge/app/data/repository/location_repository.dart';
import 'package:tree_view_challenge/app/widgets/tree_node_widget.dart';

import '../../core/values/app_images.dart';
import '../../data/models/location_model.dart';
import '../../data/models/tree_node_model.dart';

class AssetsController extends GetxController {
  List<AssetModel> assets = [];
  List<LocationModel> locations = [];
  final nodes = RxList<TreeNode>();

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
    List<TreeNode> nodes = [];
    Map<String, TreeNodeModel> nodeMap = {};

    locations.sort((a, b) => b.name.compareTo(a.name));
    assets.sort((a, b) => b.name.compareTo(a.name));

    // Criar map de root
    for (var location in locations) {
      nodeMap[location.id] = TreeNodeModel<LocationModel>(location);
    }
    for (var asset in assets) {
      nodeMap[asset.id] = TreeNodeModel<AssetModel>(asset);
    }

    List<TreeNodeModel> roots = [];

    // Transformar em lista aninhada
    for (var treeNode in nodeMap.values) {
      var node = treeNode.node;
      if (node is AssetModel) {
        if (node.parentId != null) {
          var parentNode = nodeMap[node.parentId];
          if (parentNode != null) {
            parentNode.children.add(treeNode);
          }
        } else if (node.locationId != null) {
          var parentNode = nodeMap[node.locationId];
          if (parentNode != null) {
            parentNode.children.add(treeNode);
          }
        } else {
          roots.add(treeNode);
        }
      } else if (node is LocationModel) {
        if (node.parentId == null) {
          roots.add(treeNode);
        } else {
          var parentNode = nodeMap[node.parentId];
          if (parentNode != null) {
            parentNode.children.add(treeNode);
          }
        }
      }
    }

    // Transformar lista em widget
    nodes.clear();
    for (var node in roots) {
      nodes.add(_buildNode(node));
    }
    this.nodes.value = nodes;
  }

  TreeNode _buildNode(TreeNodeModel treeNode) {
    var node = treeNode.node;
    if (node is AssetModel) {
      return TreeNode(
        title: node.name,
        leading: SvgPicture.asset(node.getIcon()),
        children: treeNode.children.map((e) => _buildNode(e)).toList(),
      );
    } else {
      return TreeNode(
        title: node.name,
        leading: SvgPicture.asset(AppImages.pin),
        children: treeNode.children.map((e) => _buildNode(e)).toList(),
      );
    }
  }

  void _searchListener() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(seconds: 2), () {
      _buildTree();
    });
  }
}
