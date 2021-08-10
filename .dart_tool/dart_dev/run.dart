import 'dart:io';

import 'package:dart_dev/src/core_config.dart';
import 'package:dart_dev/src/executable.dart' as executable;


void main(List<String> args) async {
  await executable.runWithConfig(args,
    () => coreConfig);
}
