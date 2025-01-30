import 'package:flutter/material.dart';
import 'package:quatrows/presentation/widget/box_decoration.dart';
import 'package:quatrows/presentation/widget/box_shadow.dart';

class ButtonAnswer extends StatelessWidget {
  final String text;
  final bool isSelected;
  final bool isCorrectGroup;
  final VoidCallback onTap;

  const ButtonAnswer({
    super.key,
    required this.text,
    required this.isSelected,
    required this.isCorrectGroup,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: MyBoxDecoration(
          borderRadius: BorderRadius.circular(screenWidth * 0.00522),
          color: isCorrectGroup
              ? Colors.green
              : isSelected
                  ? Color(0xFF1E1D1C)
                  : Color(0xFFFBF5F3),
          boxShadow: [
            MyBoxShadow(
              offset: Offset(0, -screenHight * 0.0142),
              blurRadius: 10.6,
              color: isSelected || isCorrectGroup
                  ? Colors.transparent
                  : Colors.black.withAlpha(145),
              inset: true,
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Coolvetica',
              fontSize: screenWidth * 0.01875,
              color: isCorrectGroup
                  ? Colors.white
                  : isSelected
                      ? Color(0xFFFBF5F3)
                      : Color(0xFF1E1D1C),
            ),
          ),
        ),
      ),
    );
  }
}
