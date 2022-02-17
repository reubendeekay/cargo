import 'package:flutter/material.dart';

TextFormField myTextField({String? hint, Function(String)? onChanged}) {
  return TextFormField(
    onChanged: (val) {
      onChanged!(val);
    },
    style: const TextStyle(fontSize: 12),
    decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 10),
        border: const OutlineInputBorder()),
  );
}
