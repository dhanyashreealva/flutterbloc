import 'package:flutter/material.dart';

enum TableType { circle, square, rectangle }

class TableInfo {
  final String id;
  final String number;
  final TableType type;
  final Offset position;

  TableInfo({
    required this.id,
    required this.number,
    required this.type,
    required this.position,
  });
}
