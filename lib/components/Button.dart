import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String iconPath;
  final Color? iconColor;
  final String buttonText;
  final dynamic buttonColor;
  final Color? borderColor;
  final Color? textColor;
  final dynamic nextPage;
  final Function? onPressedCallback;

  const Button({
    super.key,
    required this.iconPath,
    this.iconColor,
    required this.buttonText,
    required this.buttonColor,
    this.borderColor,
    this.textColor,
    this.nextPage,
    this.onPressedCallback,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: borderColor != null
                ? BorderSide(color: borderColor!)
                : BorderSide.none,
          ),
          padding: const EdgeInsets.all(0.0)),
      onPressed: () {
        if (onPressedCallback != null) {
          onPressedCallback?.call();
        }
        if (nextPage != null) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => nextPage),
          );
        }
      },
      child: Container(
        width: double.infinity,
        height: 64.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: buttonColor is LinearGradient ? buttonColor : null,
          color: buttonColor is Color ? buttonColor : null,
        ),
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (iconPath.isNotEmpty)
              Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Image.asset(
                    iconPath,
                    width: 20,
                    height: 20,
                    color: iconColor,
                  )),
            Expanded(
              child: Text(
                buttonText,
                style: TextStyle(
                  fontFamily: 'Manrope',
                  color: textColor ?? Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        )),
      ),
    );
  }
}
