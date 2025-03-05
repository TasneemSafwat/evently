import 'package:flutter/material.dart';

class DefaultElevatedButton extends StatelessWidget {
  DefaultElevatedButton({required this.lable, required this.onPressed});

  String lable;
  VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(MediaQuery.sizeOf(context).width, 56),
      ),
      child: Text(
        lable,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
}
