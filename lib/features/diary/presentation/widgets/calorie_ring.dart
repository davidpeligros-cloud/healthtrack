import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';

class CalorieRing extends StatelessWidget {
  final int consumed;
  final int goal;
  final int burned;

  const CalorieRing({
    super.key,
    required this.consumed,
    required this.goal,
    this.burned = 0,
  });

  double get progress => (consumed / (goal + burned)).clamp(0.0, 1.0);
  int get remaining => (goal + burned) - consumed;
  bool get isOverGoal => remaining < 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 200,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: const Size(200, 200),
            painter: _RingPainter(
              progress: 1.0,
              color: AppColors.separator.withValues(alpha: 77),
              strokeWidth: 14,
            ),
          ),
          CustomPaint(
            size: const Size(200, 200),
            painter: _RingPainter(
              progress: progress,
              color: isOverGoal ? AppColors.accentPink : AppColors.accentGreen,
              strokeWidth: 14,
              useGradient: !isOverGoal,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                remaining.abs().toString(),
                style: AppTypography.displayLarge.copyWith(
                  color: isOverGoal ? AppColors.accentPink : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                isOverGoal ? 'over' : 'remaining',
                style: AppTypography.caption1.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double progress;
  final Color color;
  final double strokeWidth;
  final bool useGradient;

  _RingPainter({
    required this.progress,
    required this.color,
    required this.strokeWidth,
    this.useGradient = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final paint = Paint()
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    if (useGradient) {
      paint.shader = SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: [color, color.withValues(alpha: 204), color],
        transform: const GradientRotation(-math.pi / 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius));
    } else {
      paint.color = color;
    }

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      progress != oldDelegate.progress || color != oldDelegate.color;
}
