import 'package:flutter/material.dart';
import 'widgets/CustomTableimagewidget.dart'; // Your CustomTableImageWidget

class SelectTableScreen extends StatelessWidget {
  const SelectTableScreen({Key? key}) : super(key: key);

  // Round table with chairs
  Widget roundTable(String label, String imagePath) {
    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomTableImageWidget(
            label: label,
            imagePath: imagePath,
            width: 70,
            height: 70,
          ),
          _chair(top: 5, left: 32),
          _chair(bottom: 5, left: 32),
          _chair(left: 5, top: 32),
          _chair(right: 5, top: 32),
          _chair(top: 18, right: 18),
          _chair(top: 18, left: 18),
          _chair(bottom: 18, right: 18),
          _chair(bottom: 18, left: 18),
        ],
      ),
    );
  }

  // Chair widget for positioning
  static Widget _chair({double? top, double? bottom, double? left, double? right}) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: CustomTableImageWidget(
        label: '',
        imagePath: 'assets/images/rectangle4.png',
        width: 20,
        height: 20,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SELECT TABLE'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home_outlined, color: Colors.black),
            onPressed: () => print("Home pressed"),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double w = constraints.maxWidth;
          double h = constraints.maxHeight;

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // R3/AC
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Stack(
                      children: [
                        // First row
                        Positioned(
                          top: h * 0.009,
                          left: w * 0.02,
                          child: Row(
                            children: [
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/rectangle6.png',
                                //isAvailable: true,
                                width: 90,
                                height: 90,
                              ),
                              SizedBox(width: w * 0.02),
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/rectangle6.png',
                                //isAvailable: true,
                                width: 90,
                                height: 90,
                              ),
                            ],
                          ),
                        ),
                        // Second row
                        Positioned(
                          top: h * 0.11,
                          left: w * 0.03,
                          child: Row(
                            children: [
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/square4.png',
                                //isAvailable: true,
                              ),
                              SizedBox(width: w * 0.02),
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/circle4.png',
                               // isAvailable: true,
                                width: 90,
                                height: 90,
                              ),
                            ],
                          ),
                        ),
                        // Large round table right
                        Positioned(
                          top: h * 0.05,
                          right: w * 0.05,
                          child: CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/circle6.png',
                               // isAvailable: true,
                                width: 90,
                                height: 90,
                              ),
                        ),
                        Positioned(
                          top: 5,
                          right: 5,
                          child: const Text('R3/AC', style: TextStyle(fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // R2/AC
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Stack(
                      children: [
                        // Grid layout
                        Positioned(
                          top: h * 0.01,
                          left: w * 0.02,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  CustomTableImageWidget(
                                    label: 'R413',
                                    imagePath: 'assets/images/rectangle4.png',
                                    //isAvailable: false,
                                  ),
                                  SizedBox(width: w * 0.02),
                                  CustomTableImageWidget(
                                    label: 'R413',
                                    imagePath: 'assets/images/rectangle4.png',
                                    //isAvailable: true,
                                  ),
                                  SizedBox(width: w * 0.02),
                                  CustomTableImageWidget(
                                    label: 'R413',
                                    imagePath: 'assets/images/rectangle4.png',
                                    //isAvailable: true,
                                  ),
                                ],
                              ),
                              SizedBox(height: h * 0.02),
                           ],
                           ),
                         ),
                        Positioned(
                          top: h * 0.075,
                          left: w * 0.02,
                          child: Row(
                            children: [
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/square4.png',
                                //isAvailable: false,
                              ),
                              SizedBox(width: w * 0.02),
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/circle4.png', 
                                //isAvailable: true,
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(width: w*0.02),
                            ],
                          ),
                        ),
                         Positioned(
                          top: h * 0.165,
                          left: w * 0.02,
                          child: Row(
                            children: [
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/square4.png',
                                //isAvailable: false,
                              ),
                              SizedBox(width: w * 0.02),
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/circle4.png',
                               // isAvailable: true,
                                width: 80,
                                height:80,
                              ),
                              SizedBox(width: w*0.02),
                            ],
                          ),
                        ),
                         Positioned(
                          top: h * 0.255,
                          left: w * 0.02,
                          child: Row(
                            children: [
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/square4.png',
                              ),
                              SizedBox(width: w * 0.02),
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/circle4.png',
                                width: 80,
                                height: 80,
                              ),
                              SizedBox(width: w*0.02),
                            ],
                          ),
                        ),

                        // Right vertical tables
                        Positioned(
                          top: h * 0.10,
                          left: w * 0.5,
                          child: Column(
                            children: [
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/circle6.png',
                                //isAvailable: true,
                                width: 80,
                                height:80,                             
                                 ),
                              SizedBox(height: h * 0.02),
                              CustomTableImageWidget(
                                label: 'R413',
                                imagePath: 'assets/images/circle6.png',
                                //isAvailable: false,
                                width: 80,
                                height: 80,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                            top: h * 0.065,
                            right: w * 0.04,
                            child: Column(
                              children: [
                                RotatedBox(
                                  quarterTurns: 3, // Rotate 90 degrees clockwise
                                  child: CustomTableImageWidget(
                                    label: 'R413',
                                    imagePath: 'assets/images/rectangle4.png',
                                    //isAvailable: true,
                                  ),
                                ),
                                SizedBox(height: h * 0.02),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: CustomTableImageWidget(
                                    label: 'R413',
                                    imagePath: 'assets/images/rectangle4.png',
                                    //isAvailable: false,
                                  ),
                                ),
                                SizedBox(height: h * 0.02),
                                RotatedBox(
                                  quarterTurns: 3,
                                  child: CustomTableImageWidget(
                                    label: 'R413',
                                    imagePath: 'assets/images/rectangle4.png',
                                    //isAvailable: true,
                                  ),
                                ),
                              ],
                            ),
                          ),

                        Positioned(
                          top: 5,
                          right: 5,
                          child: const Text('R2/AC', style: TextStyle(fontSize: 11)),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 8),

                // R1/non-AC
                Expanded(
                  flex: 2,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: h * 0.015,
                          left: w * 0.02,
                          child: Row(
                            children: [
                              RotatedBox(
                                  quarterTurns: 1, // Rotate 90 degrees clockwise
                                  child: CustomTableImageWidget(
                                    label: 'R112',
                                    imagePath: 'assets/images/square2.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              SizedBox(width: w * 0.03),
                              CustomTableImageWidget(
                                label: 'R111',
                                imagePath: 'assets/images/circle2.png',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(width: w * 0.03),
                              CustomTableImageWidget(
                                label: 'R112',
                                imagePath: 'assets/images/square2.png',
                                width: 40,
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: h * 0.08,
                          left: w * 0.02,
                          child: Row(
                            children: [
                              RotatedBox(
                                  quarterTurns: 3, // Rotate 90 degrees clockwise
                                  child: CustomTableImageWidget(
                                    label: 'R111',
                                    imagePath: 'assets/images/circle2.png',
                                    width: 40,
                                    height: 40,
                                  ),
                                ),
                              SizedBox(width: w * 0.03),
                              CustomTableImageWidget(
                                label: 'R112',
                                imagePath: 'assets/images/square2.png',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(width: w * 0.03),
                              CustomTableImageWidget(
                                label: 'R111',
                                imagePath: 'assets/images/circle2.png',
                                width: 40,
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: h * 0.15,
                          left: w * 0.02,
                          child: Row(
                            children: [
                              CustomTableImageWidget(
                                label: 'R112',
                                imagePath: 'assets/images/square2.png',
                                width: 40,
                                height: 40,
                              ),
                              SizedBox(width: w * 0.03),
                              CustomTableImageWidget(
                                label: 'R111',
                                imagePath: 'assets/images/circle2.png',
                                width: 40,
                                height: 40,
                              ),
                            ],
                          ),
                        ),
                        Column(
                         children: [
                           Spacer(), // pushes down
                               Center(
                                child: Text(
                                  "Entrance",
                                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                             ),
                            ),
                          ],
                         ),

                        Positioned(
                          top: 5,
                          right: 5,
                          child: const Text('R1/non-AC', style: TextStyle(fontSize: 11)),
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
                    onPressed: () => Navigator.pushNamed(context, '/MenuPage'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[800],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Adjust corner roundness
                      ),
                    ),
                    child: const Text(
                      'NEXT',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
