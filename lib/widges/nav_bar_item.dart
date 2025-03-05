import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavBarItem extends StatelessWidget {
  NavBarItem({required this.imageName});
  String imageName;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$imageName.svg',
      height: 24,
      width: 24,
      fit: BoxFit.scaleDown,
    );
  }
}
