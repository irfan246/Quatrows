import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: screenHight * 0.1362346,
        automaticallyImplyLeading: false,
        flexibleSpace: Stack(
          children: [
            Positioned(
              left: screenWidth * 0.02604166,
              top: screenHight * 0.0285,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                hoverColor: Colors.transparent,
                focusColor: Colors.transparent,
                icon: Image.asset(
                  'assets/images/icon_back_white.png',
                  width: screenWidth * 0.0421875,
                  height: screenHight * 0.076632,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment(0, 0),
              children: [
                Material(
                  shape: CircleBorder(),
                  color: Color(0xFF1E1D1C),
                  child: SizedBox(
                    width: screenWidth * 0.1953125,
                    height: screenHight * 0.354777,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/game');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(screenWidth * 0.169272, screenHight * 0.307474),
                    shape: CircleBorder(),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    side: BorderSide(
                      color: Color(0xFFFBF5F3),
                      width: screenWidth * 0.0104166,
                    ),
                  ),
                  child: Text(
                    'Mudah',
                    style: TextStyle(
                      fontFamily: 'Coolvetica',
                      fontSize: screenWidth * 0.025,
                      color: Color(0xFFFBF5F3),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: screenWidth * 0.15573,
            ),
            Stack(
              alignment: Alignment(0, 0),
              children: [
                Material(
                  shape: CircleBorder(),
                  color: Color(0xFFFBF5F3),
                  child: SizedBox(
                    width: screenWidth * 0.1953125,
                    height: screenHight * 0.354777,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/game_challenge');
                  },
                  style: ElevatedButton.styleFrom(
                    fixedSize:
                        Size(screenWidth * 0.169272, screenHight * 0.307474),
                    shape: CircleBorder(),
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    side: BorderSide(
                      color: Color(0xFF1E1D1C),
                      width: screenWidth * 0.0104166,
                    ),
                  ),
                  child: Text(
                    'Tantangan',
                    style: TextStyle(
                      fontFamily: 'Coolvetica',
                      fontSize: screenWidth * 0.025,
                      color: Color(0xFF1E1D1C),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
