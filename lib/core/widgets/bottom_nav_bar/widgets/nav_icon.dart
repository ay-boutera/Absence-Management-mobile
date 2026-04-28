import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NavIcon extends StatelessWidget {
  final String assetPath;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;

  const NavIcon({
    super.key,
    required this.assetPath,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: SvgPicture.asset(
        assetPath,
        colorFilter: ColorFilter.mode(
          isActive ? activeColor : inactiveColor,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
