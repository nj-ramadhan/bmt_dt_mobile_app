// lib/components/custom_table_row.dart

import 'package:flutter/material.dart';

class CustomTableRow {
  // Static method to build a TableRow
  static TableRow build(String label, String value, {TextStyle? labelStyle, TextStyle? valueStyle}) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            label,
            style: labelStyle ?? const TextStyle(fontSize: 16),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            ":",
            style: TextStyle(fontSize: 16),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            value,
            style: valueStyle ?? const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
