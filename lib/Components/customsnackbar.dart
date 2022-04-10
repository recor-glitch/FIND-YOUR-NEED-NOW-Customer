import 'package:flutter/material.dart';

ScaffoldFeatureController CustomSnackbar(String data, BuildContext context) {
  return ScaffoldMessenger.of(context)
      .showSnackBar(SnackBar(content: Text(data)));
}