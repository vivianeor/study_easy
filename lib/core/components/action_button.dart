import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_easy/core/utils/const_colors.dart';

class ActionButton extends StatefulWidget {

  final String buttonText;
  final double buttonTextSize;
  final VoidCallback onTap;
  final double width;
  final double height;
  final borderRadius;
  final margin;
  ActionButton({
    required this.width,
    this.height = 55,
    this.margin,
    this.borderRadius,
    required this.buttonText,
    this.buttonTextSize = 18,
    required this.onTap
  });
  @override
  _ActionButtonState createState() => _ActionButtonState();
}
class _ActionButtonState extends State<ActionButton> {
  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: widget.onTap,
        child: Container(
            width: widget.width,
            height: widget.height,
            padding: EdgeInsets.all(1),
            margin: widget.margin,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(70),
                gradient: LinearGradient(
                    colors: [ConstColors.blue, ConstColors.yellow]
                )
            ),
            child: Container(
              decoration: BoxDecoration(
                color: ConstColors.background,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                  child: Text(
                    widget.buttonText,
                    style: TextStyle(fontSize: widget.buttonTextSize,),
                  )
              ),
            )
        )
    );
  }
}