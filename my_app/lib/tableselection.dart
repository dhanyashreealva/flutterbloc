import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: SelectTableScreen()));
}

class SelectTableScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Custom table widget
    Widget tableBox(String label,
        {double width = 60, double height = 40, double borderRadius = 6}) {
      return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: Colors.grey.shade500),
        ),
        alignment: Alignment.center,
        child: Text(label, style: TextStyle(fontSize: 10)),
      );
    }
     Widget chairBox({double size = 20}) {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: Colors.grey.shade500),
        ),
      );
    }


    // Round table with chairs around it
    Widget roundTable(String label) {
      return SizedBox(
        width: 90,
        height: 90,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade500),
              ),
              alignment: Alignment.center,
              child: Text(label, style: TextStyle(fontSize: 10)),
            ),
            // Chairs positions
            Positioned(top: 5, left: 32, child: chairBox()),
            Positioned(bottom: 5, left: 32, child: chairBox()),
            Positioned(left: 5, top: 32, child: chairBox()),
            Positioned(right: 5, top: 32, child: chairBox()),
            Positioned(top: 18, right: 18, child: chairBox(size: 15)),
            Positioned(top: 18, left: 18, child: chairBox(size: 15)),
            Positioned(bottom: 18, right: 18, child: chairBox(size: 15)),
            Positioned(bottom: 18, left: 18, child: chairBox(size: 15)),
          ],
        ),
      );
    }

    // Chair widget
   
    return Scaffold(
      appBar: AppBar(
        title: const Text('SELECT TABLE'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.home_outlined, color: Colors.black),
            onPressed: () {
              // TODO: Implement home navigation if needed
              print("Home pressed");
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: [
            // R3/AC area
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400)),
                child: Stack(
                  children: [
                    // Tables in grid style top left
                    Positioned(
                      top: 8,
                      left: 8,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              tableBox('R4/13'),
                              SizedBox(width: 15),
                              tableBox('R4/13'),
                            ],
                          ),
                          SizedBox(height: 15),
                          Row(
                            children: [
                              tableBox('R4/12'),
                              SizedBox(width: 15),
                              roundTable('R4/13'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Big round table top right
                    Positioned(
                      top: 25,
                      right: 15,
                      child: roundTable('R4/13'),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Text('R3/AC', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),

            // R2/AC area
            Expanded(
              flex: 4,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 15,
                      left: 8,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              tableBox('R3/12'),
                              SizedBox(width: 10),
                              tableBox('R3/13'),
                              SizedBox(width: 10),
                              tableBox('R3/12'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              tableBox('R4/13'),
                              SizedBox(width: 10),
                              roundTable('R4/10'),
                              SizedBox(width: 10),
                              roundTable('R4/13'),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              tableBox('R4/13'),
                              SizedBox(width: 10),
                              roundTable('R4/15'),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      right: 10,
                      top: 20,
                      child: Column(
                        children: [
                          tableBox('R4/11', width: 30, height: 60),
                          SizedBox(height: 10),
                          tableBox('R4/10', width: 30, height: 60),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Text('R2/AC', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),

            // R1/non-AC area
            Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400)),
                child: Stack(
                  children: [
                    Positioned(
                      top: 15,
                      left: 5,
                      child: Row(
                        children: [
                          tableBox('R1/12', width: 40, height: 40),
                          SizedBox(width: 10),
                          tableBox('R1/11', width: 40, height: 40),
                          SizedBox(width: 10),
                          tableBox('R1/10', width: 40, height: 40),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 50,
                      left: 5,
                      child: Row(
                        children: [
                          tableBox('R1/12', width: 40, height: 40),
                          SizedBox(width: 10),
                          tableBox('R1/11', width: 40, height: 40),
                          SizedBox(width: 10),
                          tableBox('R1/10', width: 40, height: 40),
                        ],
                      ),
                    ),
                    Positioned(
                      top: 20,
                      right: 10,
                      child: Column(
                        children: [
                          tableBox('R1/10', width: 30, height: 60),
                          SizedBox(height: 10),
                          tableBox('R1/11', width: 30, height: 60),
                          SizedBox(height: 10),
                          tableBox('R1/12', width: 30, height: 60),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 5,
                      left: 20,
                      child: Text(
                        'Entrance',
                        style:
                            TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                      ),
                    ),
                    Positioned(
                      top: 5,
                      right: 5,
                      child: Text('R1/non-AC', style: TextStyle(fontSize: 11)),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 10),

            // Next button
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                onPressed: () {
                  print("Next button pressed");
                },
                child: Text(
                  'NEXT',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green[800]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
