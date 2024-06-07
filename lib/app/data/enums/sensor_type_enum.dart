import 'package:get/get.dart';

enum SensorTypeEnum {
  vibration,
  energy;

  static SensorTypeEnum getByName(String name) =>
      SensorTypeEnum.values.firstWhereOrNull((e) => e.name == name) ??
      SensorTypeEnum.energy;
}
