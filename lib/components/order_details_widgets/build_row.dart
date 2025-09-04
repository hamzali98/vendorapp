import 'package:flutter/material.dart';

/// **Row for Displaying Order Details**
Widget buildRow(String title, String value, {Color? valueColor}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            color: valueColor?.withValues().withAlpha(60),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value,
            style: TextStyle(fontSize: 16, color: valueColor ?? Colors.black54),
            softWrap: true,
            maxLines: null,
            overflow: TextOverflow.visible,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    ),
  );
}
