import 'package:flutter/material.dart';

/// Use Spacing.vertical(height) or Spacing.horizontal(width) for flexible spacing.
class Spacing extends SizedBox {
  const Spacing.vertical(double height, {super.key}) : super(height: height);

  const Spacing.horizontal(double width, {super.key}) : super(width: width);
}

