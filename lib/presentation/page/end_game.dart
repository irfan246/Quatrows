import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EndGame extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String subTitle;

  EndGame(
      {Key? key,
      required this.onTap,
      required this.title,
      required this.subTitle});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return Material(
      color: Color(0xF21E1D1C),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Coolvetica',
              fontSize: screenWidth * 0.05,
              color: Color(0xFFFBF5F3),
            ),
          ),
          SizedBox(
            height: screenHight * 0.0037843,
          ),
          Text(
            subTitle,
            style: TextStyle(
              fontFamily: 'Coolvetica',
              fontSize: screenWidth * 0.025,
              color: Color(0xFFFBF5F3),
            ),
          ),
          SizedBox(
            height: screenHight * 0.0246,
          ),
          ElevatedButton(
            onPressed: onTap,
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth * 0.16875, screenHight * 0.09463),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.013022),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/icon_repeat.png',
                    width: screenWidth * 0.05522,
                    height: screenHight * 0.1004,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'Main Lagi',
                      style: TextStyle(
                        fontFamily: 'Coolvetica',
                        fontSize: screenWidth * 0.022,
                        color: Color(0xFF1E1D1C),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: screenHight * 0.02,
          ),
          ElevatedButton(
            onPressed: () {
              onTap;
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              fixedSize: Size(screenWidth * 0.16875, screenHight * 0.09463),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(screenWidth * 0.013022),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Image.asset(
                    'assets/images/icon_back.png',
                    width: screenWidth * 0.03687,
                    height: screenHight * 0.02934,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Center(
                    child: Text(
                      'Kembali',
                      style: TextStyle(
                        fontFamily: 'Coolvetica',
                        fontSize: screenWidth * 0.022,
                        color: Color(0xFF1E1D1C),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
