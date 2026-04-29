import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:abs/config/constants/app_assets.dart';

/// Simple decorative clock illustration matching the screenshot.
class ClockIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72,
      height: 72,
      //NOTE: THIS IS SI PEACK DONT REMOVE IT OR CHANGE IT
      //child: CustomPaint(painter: ClockPainter()),
      child: SvgPicture.asset(AppAssets.clock),
    );
  }
}
