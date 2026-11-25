import 'dart:math' as math show min;

import 'package:flutter/material.dart';
import 'package:kiosk_app/core/constants/text_style_constants.dart';
import 'package:kiosk_app/core/utils/extensions.dart';

class ChooseServiceCard extends StatelessWidget {
  const ChooseServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(),
      child: Container(
        width: 190,
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.3)),
              child: Center(
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.design_services_outlined,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
            10.height,
            Text(
              "Choose a service First",
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyleConstants.h3(),
            ),
            8.height,
            Container(
              width: 40,
              height: 1,
              color: Colors.grey.shade300,
            ),
            8.height,
            Text("Book with",
                textAlign: TextAlign.center, style: TextStyleConstants.label(size: 12)),
            8.height,
            Text("Any professional",
                textAlign: TextAlign.center, style: TextStyleConstants.label(size: 12)),
          ],
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFD0D0D0)
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(
        0.5,
        0.5,
        size.width - 1,
        size.height - 1,
      ),
      const Radius.circular(16),
    );

    final path = Path()..addRRect(rect);

    for (final metric in path.computeMetrics()) {
      double distance = 0;

      while (distance < metric.length) {
        final length = math.min(
          5.0,
          metric.length - distance,
        );

        canvas.drawPath(
          metric.extractPath(distance, distance + length),
          paint,
        );

        distance += length + 4;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
