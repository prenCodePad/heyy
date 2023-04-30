import 'package:flutter/material.dart';
import 'package:heyy/common/app_mixin.dart';

class Button extends StatelessWidget with AppMixin {
  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;
  const Button({Key? key, required this.text, required this.onPressed, this.width, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: height ?? 48,
        width: width ?? double.infinity,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(25)),
        ),
        child: Text(text, style: theme.button()),
      ),
    );
  }
}
