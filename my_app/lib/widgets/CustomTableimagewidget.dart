import 'package:flutter/material.dart';

/// MODEL FOR TABLE
class TableModel {
  final String label;
  final String imagePath;

  TableModel(this.label, this.imagePath);
}

/// REUSABLE WIDGET
class CustomTableImageWidget extends StatelessWidget {
  final String label;
  final String imagePath;
  final double width;
  final double height;
  final VoidCallback? onTap;

  const CustomTableImageWidget({
    Key? key,
    required this.label,
    required this.imagePath,
    this.width = 60,
    this.height = 60,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            imagePath,
            width: width,
            height: height,
            fit: BoxFit.contain,
          ),
          if (label.isNotEmpty)
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                shadows: [
                  Shadow(
                    blurRadius: 2,
                    color: Colors.white,
                    offset: Offset(1, 1),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}

/// MAIN SCREEN
class TableScreen extends StatelessWidget {
  TableScreen({Key? key}) : super(key: key);

  // LIST OF TABLES
  final List<TableModel> tables = [
    TableModel('R1', 'assets/images/circle2.png'),
    TableModel('R1', 'assets/images/square2.png'),
    TableModel('R2', 'assets/images/rectangle4.png'),
    TableModel('R2', 'assets/images/square4.png'),
    TableModel('R2', 'assets/images/circle4.png'),
    TableModel('R2', 'assets/images/circle6.png'),
    TableModel('R3', 'assets/images/circle4.png'),
    TableModel('R3', 'assets/images/square4.png'),
    TableModel('R3', 'assets/images/rectangle6.png'),
    TableModel('R3', 'assets/images/circle6.png'),
    
    // Add more as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurant Tables'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4, // Number of columns
            childAspectRatio: 1, // Shape of each cell
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: tables.length,
          itemBuilder: (context, index) {
            final table = tables[index];
            return CustomTableImageWidget(
              label: table.label,
              imagePath: table.imagePath,
              onTap: () {
                // Action when tapped
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Tapped ${table.label}')),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

/// APP ROOT
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TableScreen(),
    );
  }
}
