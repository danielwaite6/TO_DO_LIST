import 'package:flutter/material.dart';

class Validator {
  Validator._();

  static FormFieldValidator compare(
      TextEditingController? valueEC, String msg) {
    return (value) {
      final valueCompare = valueEC!.text ?? '';
      if (value == null || (value != null && value != valueCompare)) {
        return msg;
      }
      return '';
    };
  }
}
