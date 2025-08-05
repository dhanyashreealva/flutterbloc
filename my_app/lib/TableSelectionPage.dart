import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'table_selection_bloc.dart';
import 'table_selection_event.dart';
import 'table_selection_state.dart';

class TableSelectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TableSelectionBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(
            'SELECT TABLE',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildSectionWithTables('R3/AC', _buildR3Section(context)),
                        Divider(height: 32, thickness: 1),
                        _buildSectionWithTables('R2/AC', _buildR2Section(context)),
                        Divider(height: 32, thickness: 1),
                        _buildSectionWithTables('R1/non-AC', _buildR1Section(context)),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement next action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      'NEXT',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 12),
                Center(
                  child: Text(
                    'Entrance',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionWithTables(String title, Widget tables) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: tables),
        Container(
          width: 60,
          alignment: Alignment.topRight,
          padding: EdgeInsets.only(top: 8, right: 8),
          child: Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildR3Section(BuildContext context) {
    return BlocBuilder<TableSelectionBloc, TableSelectionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-1',
                  isSelected: state.selectedTables.contains('R413-1'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-2',
                  isSelected: state.selectedTables.contains('R413-2'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-3',
                  isSelected: state.selectedTables.contains('R413-3'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-4',
                  isSelected: state.selectedTables.contains('R413-4'),
                  shape: TableShape.circle,
                  chairCount: 4,
                  diameter: 60,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-5',
                  isSelected: state.selectedTables.contains('R413-5'),
                  shape: TableShape.circle,
                  chairCount: 4,
                  diameter: 60,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-6',
                  isSelected: state.selectedTables.contains('R413-6'),
                  shape: TableShape.circle,
                  chairCount: 6,
                  diameter: 80,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildR2Section(BuildContext context) {
    return BlocBuilder<TableSelectionBloc, TableSelectionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-7',
                  isSelected: state.selectedTables.contains('R413-7'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-8',
                  isSelected: state.selectedTables.contains('R413-8'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-9',
                  isSelected: state.selectedTables.contains('R413-9'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-10',
                  isSelected: state.selectedTables.contains('R413-10'),
                  shape: TableShape.circle,
                  chairCount: 4,
                  diameter: 60,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-11',
                  isSelected: state.selectedTables.contains('R413-11'),
                  shape: TableShape.circle,
                  chairCount: 4,
                  diameter: 60,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-12',
                  isSelected: state.selectedTables.contains('R413-12'),
                  shape: TableShape.circle,
                  chairCount: 6,
                  diameter: 80,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-13',
                  isSelected: state.selectedTables.contains('R413-13'),
                  shape: TableShape.rectangle,
                  chairCount: 2,
                  width: 40,
                  height: 50,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-14',
                  isSelected: state.selectedTables.contains('R413-14'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-15',
                  isSelected: state.selectedTables.contains('R413-15'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-16',
                  isSelected: state.selectedTables.contains('R413-16'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-17',
                  isSelected: state.selectedTables.contains('R413-17'),
                  shape: TableShape.circle,
                  chairCount: 4,
                  diameter: 60,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-18',
                  isSelected: state.selectedTables.contains('R413-18'),
                  shape: TableShape.circle,
                  chairCount: 4,
                  diameter: 60,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-19',
                  isSelected: state.selectedTables.contains('R413-19'),
                  shape: TableShape.circle,
                  chairCount: 6,
                  diameter: 80,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-20',
                  isSelected: state.selectedTables.contains('R413-20'),
                  shape: TableShape.rectangle,
                  chairCount: 2,
                  width: 40,
                  height: 50,
                  isFaded: true,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-21',
                  isSelected: state.selectedTables.contains('R413-21'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 80,
                  height: 50,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-22',
                  isSelected: state.selectedTables.contains('R413-22'),
                  shape: TableShape.circle,
                  chairCount: 4,
                  diameter: 60,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-23',
                  isSelected: state.selectedTables.contains('R413-23'),
                  shape: TableShape.circle,
                  chairCount: 4,
                  diameter: 60,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-24',
                  isSelected: state.selectedTables.contains('R413-24'),
                  shape: TableShape.circle,
                  chairCount: 6,
                  diameter: 80,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-25',
                  isSelected: state.selectedTables.contains('R413-25'),
                  shape: TableShape.rectangle,
                  chairCount: 2,
                  width: 40,
                  height: 50,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-26',
                  isSelected: state.selectedTables.contains('R413-26'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 50,
                  height: 120,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R413-27',
                  isSelected: state.selectedTables.contains('R413-27'),
                  shape: TableShape.rectangle,
                  chairCount: 4,
                  width: 50,
                  height: 120,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildR1Section(BuildContext context) {
    return BlocBuilder<TableSelectionBloc, TableSelectionState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R111',
                  isSelected: state.selectedTables.contains('R111'),
                  shape: TableShape.square,
                  chairCount: 2,
                  width: 50,
                  height: 50,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R112',
                  isSelected: state.selectedTables.contains('R112'),
                  shape: TableShape.square,
                  chairCount: 2,
                  width: 50,
                  height: 50,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R113',
                  isSelected: state.selectedTables.contains('R113'),
                  shape: TableShape.square,
                  chairCount: 2,
                  width: 50,
                  height: 50,
                  isFaded: true,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R114',
                  isSelected: state.selectedTables.contains('R114'),
                  shape: TableShape.square,
                  chairCount: 2,
                  width: 50,
                  height: 50,
                  isFaded: true,
                ),
                SizedBox(width: 8),
                TableWithChairs(
                  tableId: 'R115',
                  isSelected: state.selectedTables.contains('R115'),
                  shape: TableShape.square,
                  chairCount: 2,
                  width: 50,
                  height: 50,
                  isFaded: true,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

enum TableShape { rectangle, circle, square }

class TableWithChairs extends StatelessWidget {
  final String tableId;
  final bool isSelected;
  final TableShape shape;
  final int chairCount;
  final double? width;
  final double? height;
  final double? diameter;
  final bool isFaded;

  const TableWithChairs({
    Key? key,
    required this.tableId,
    required this.isSelected,
    required this.shape,
    required this.chairCount,
    this.width,
    this.height,
    this.diameter,
    this.isFaded = false,
  }) : super(key: key);

  String _getImageAsset() {
    String basePath = 'assets/images/tables/';
    String shapeStr = '';
    String countStr = chairCount.toString();

    switch (shape) {
      case TableShape.rectangle:
        shapeStr = 'rectangle';
        break;
      case TableShape.circle:
        shapeStr = 'circle';
        break;
      case TableShape.square:
        shapeStr = 'square';
        break;
    }

    // Use chairCount to select image variant
    // For example, rectangle4.png, circle6.png, square2.png etc.
    // If chairCount > 6, fallback to max available (6 or 8)
    int countForImage = chairCount;
    if (shape == TableShape.rectangle) {
      if (chairCount <= 4) countForImage = 4;
      else if (chairCount <= 6) countForImage = 6;
      else countForImage = 8;
    } else if (shape == TableShape.circle) {
      if (chairCount <= 2) countForImage = 2;
      else if (chairCount <= 4) countForImage = 4;
      else countForImage = 6;
    } else if (shape == TableShape.square) {
      if (chairCount <= 2) countForImage = 2;
      else countForImage = 4;
    }

    return '$basePath$shapeStr$countForImage.png';
  }

  @override
  Widget build(BuildContext context) {
    double imgWidth = width ?? 80;
    double imgHeight = height ?? 50;
    if (shape == TableShape.circle) {
      imgWidth = diameter ?? 60;
      imgHeight = diameter ?? 60;
    }

    Widget imageWidget = Image.asset(
      _getImageAsset(),
      width: imgWidth,
      height: imgHeight,
      color: (isFaded && !isSelected) ? Colors.grey.shade300 : null,
      colorBlendMode: (isFaded && !isSelected) ? BlendMode.modulate : null,
    );

    return Stack(
      alignment: Alignment.center,
      children: [
        imageWidget,
        if (isSelected)
          Container(
            width: imgWidth,
            height: imgHeight,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green.shade700, width: 3),
              borderRadius: shape == TableShape.rectangle
                  ? BorderRadius.circular(8)
                  : shape == TableShape.square
                      ? BorderRadius.circular(6)
                      : null,
              shape: shape == TableShape.circle ? BoxShape.circle : BoxShape.rectangle,
            ),
          ),
      ],
    );
  }
