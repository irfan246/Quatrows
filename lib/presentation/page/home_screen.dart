import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.png',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  width: screenWidth * 0.272,
                  height: screenHight * 0.32545,
                ),
                SizedBox(
                  height: screenHight * 0.04165,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/main');
                  },
                  style: ElevatedButton.styleFrom(
                    maximumSize:
                        Size(screenWidth * 0.104166, screenHight * 0.27247),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(screenWidth * 0.0104166),
                    ),
                    backgroundColor: Color(0xFF1E1D1C),
                  ),
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Color(0xFFFBF5F3),
                    size: screenWidth * 0.075,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
