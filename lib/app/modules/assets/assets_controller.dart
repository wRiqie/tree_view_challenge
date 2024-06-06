// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tree_view_challenge/app/data/models/args/assets_args.dart';
import 'package:tree_view_challenge/app/data/models/asset_model.dart';
import 'package:tree_view_challenge/app/data/repository/asset_repository.dart';
import 'package:tree_view_challenge/app/data/repository/location_repository.dart';

import '../../data/models/location_model.dart';

class AssetsController extends GetxController {
  List<AssetModel> assets = [];
  List<LocationModel> locations = [];
  final nodes = RxList<Widget>();

  final isLoading = RxBool(false);

  final AssetRepository _assetRepository;
  final LocationRepository _locationRepository;

  final args = Get.arguments as AssetsArgs;

  AssetsController(this._assetRepository, this._locationRepository);

  @override
  void onInit() {
    super.onInit();
    scheduleMicrotask(loadData);
  }

  Future<void> loadData() async {
    await _loadAssets();
    await _loadLocations();
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
}
