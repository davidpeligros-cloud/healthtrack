import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_spacing.dart';
import '../../../../core/constants/app_typography.dart';

class BarcodeScannerScreen extends StatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  State<BarcodeScannerScreen> createState() => _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends State<BarcodeScannerScreen> {
  final MobileScannerController _controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.normal,
    facing: CameraFacing.back,
    torchEnabled: false,
  );

  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            controller: _controller,
            onDetect: _onBarcodeDetected,
          ),
          CustomPaint(
            painter: _ScannerOverlayPainter(),
            child: const SizedBox.expand(),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _CircleButton(
                    icon: Icons.close,
                    onTap: () => Navigator.of(context).pop(),
                  ),
                  _CircleButton(
                    icon: _controller.torchEnabled ? Icons.flash_on : Icons.flash_off,
                    onTap: () => _controller.toggleTorch(),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: 0,
            right: 0,
            child: Text(
              'Point camera at barcode',
              textAlign: TextAlign.center,
              style: AppTypography.headline.copyWith(color: Colors.white),
            ),
          ),
          if (_isProcessing)
            Container(
              color: Colors.black54,
              child: const Center(
                child: CircularProgressIndicator(color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _onBarcodeDetected(BarcodeCapture capture) async {
    if (_isProcessing) return;
    final barcode = capture.barcodes.isNotEmpty ? capture.barcodes.first : null;
    if (barcode?.rawValue == null) return;

    setState(() => _isProcessing = true);
    HapticFeedback.mediumImpact();
    await Future.delayed(const Duration(milliseconds: 300));
    if (mounted) Navigator.of(context).pop(barcode!.rawValue);
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 31),
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        child: Icon(icon, color: Colors.white, size: 22),
      ),
    );
  }
}

class _ScannerOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black54;
    final scanAreaSize = size.width * 0.7;
    final scanRect = Rect.fromCenter(
      center: Offset(size.width / 2, size.height / 2 - 50),
      width: scanAreaSize,
      height: scanAreaSize * 0.6,
    );
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(16)))
      ..fillType = PathFillType.evenOdd;
    canvas.drawPath(path, paint);
    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawRRect(RRect.fromRectAndRadius(scanRect, const Radius.circular(16)), borderPaint);
    final cornerPaint = Paint()
      ..color = AppColors.accentBlue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    const cornerLength = 30.0;
    canvas.drawLine(scanRect.topLeft + const Offset(0, 16), scanRect.topLeft + const Offset(0, 16 + cornerLength), cornerPaint);
    canvas.drawLine(scanRect.topLeft + const Offset(16, 0), scanRect.topLeft + const Offset(16 + cornerLength, 0), cornerPaint);
    canvas.drawLine(scanRect.topRight + const Offset(0, 16), scanRect.topRight + const Offset(0, 16 + cornerLength), cornerPaint);
    canvas.drawLine(scanRect.topRight + const Offset(-16, 0), scanRect.topRight + const Offset(-16 - cornerLength, 0), cornerPaint);
    canvas.drawLine(scanRect.bottomLeft + const Offset(0, -16), scanRect.bottomLeft + const Offset(0, -16 - cornerLength), cornerPaint);
    canvas.drawLine(scanRect.bottomLeft + const Offset(16, 0), scanRect.bottomLeft + const Offset(16 + cornerLength, 0), cornerPaint);
    canvas.drawLine(scanRect.bottomRight + const Offset(0, -16), scanRect.bottomRight + const Offset(0, -16 - cornerLength), cornerPaint);
    canvas.drawLine(scanRect.bottomRight + const Offset(-16, 0), scanRect.bottomRight + const Offset(-16 - cornerLength, 0), cornerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
