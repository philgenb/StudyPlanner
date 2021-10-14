/*
 * All rights reserved ~ ©Phil Gengenbach
 */

import 'package:flutter/material.dart';

class SizeHelper {

  static Size displaySize (BuildContext context) {
    return MediaQuery.of(context).size;
  }

  static double getDisplayWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getDisplayHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

}
