import 'package:get/get.dart';

enum StatusEnum {
  operanting,
  alert;

  static StatusEnum getByName(String name) =>
      StatusEnum.values.firstWhereOrNull((e) => e.name == name) ??
      StatusEnum.operanting;
}
