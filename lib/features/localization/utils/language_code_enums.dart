import 'package:flutter/material.dart';

import '../../../core/common/constants/constants.dart';

enum LanguageCode {
  english(Constants.en),
  hindi(Constants.hi),
  marathi(Constants.mr),
  nepali(Constants.ne);

  final String code;

  const LanguageCode(this.code);

  static List<Locale> get appLocales =>
      LanguageCode.values.map((locale) => Locale(locale.code)).toList();
}
