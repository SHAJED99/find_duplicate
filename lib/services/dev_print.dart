import 'package:flutter/foundation.dart';

void devPrint(var text) {
  if(kDebugMode) print("Debug: $text");
}