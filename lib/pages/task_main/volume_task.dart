import 'dart:math';
import 'package:flutter/material.dart';

class WaterContainer extends StatefulWidget {
  final int waterLevel;
  final int maxWaterLevel;
  final Color waterColor;

  const WaterContainer({
    super.key,
    required this.waterLevel,
    this.maxWaterLevel = 100,
    this.waterColor = Colors.lightBlue,
  });

  @override
  _WaterContainerState createState() => _WaterContainerState();
}

class _WaterContainerState extends State<WaterContainer>
    with TickerProviderStateMixin {
  late AnimationController _waveController;
  late Animation<double> _levelAnimation;
  double _currentLevel = 1.0;
  AnimationController? _levelController;

  @override
  void initState() {
    super.initState();

    _currentLevel = _calculateLevelRatio(widget.waterLevel);

    _waveController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _startLevelAnimation(_currentLevel);

    if (widget.waterLevel > 0) {
      _waveController.repeat();
    }
  }

  @override
  void didUpdateWidget(WaterContainer oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.waterLevel != widget.waterLevel ||
        oldWidget.maxWaterLevel != widget.maxWaterLevel) {

      final newLevel = _calculateLevelRatio(widget.waterLevel);


      _startLevelAnimation(newLevel);


      if (widget.waterLevel > 0 && !_waveController.isAnimating) {
        _waveController.repeat();
      } else if (widget.waterLevel == 0 && _waveController.isAnimating) {
        _waveController.stop();
      }
    }
  }


  double _calculateLevelRatio(int waterLevel) {
    if (widget.maxWaterLevel <= 0) return 0.0;
    final ratio = waterLevel / widget.maxWaterLevel;
    return ratio.clamp(0.0, 1.0);
  }


  void _startLevelAnimation(double targetLevel) {

    if (_levelController != null) {
      _levelController!.stop();
      _levelController!.dispose();
      _levelController = null;
    }

    _levelController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _levelAnimation = Tween(
      begin: _currentLevel,
      end: targetLevel,
    ).animate(CurvedAnimation(
      parent: _levelController!,
      curve: Curves.easeOut,
    ))
      ..addListener(() {
        setState(() {
          _currentLevel = _levelAnimation.value;
        });
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed || status == AnimationStatus.dismissed) {
          _levelController?.dispose();
          _levelController = null;
        }
      });

    _levelController!.forward();
  }

  @override
  void dispose() {

    _waveController.stop();
    _waveController.dispose();


    if (_levelController != null) {
      _levelController!.stop();
      _levelController!.dispose();
      _levelController = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _waveController,
          _levelAnimation,
          if (_levelController != null) _levelController!,
        ]),
        builder: (context, child) {
          return CustomPaint(
            painter: WaterContainerPainter(
              waterLevel: _currentLevel,
              waveValue: _currentLevel > 0 ? _waveController.value : 0.0,
              waterColor: widget.waterColor,
            ),
          );
        },
      ),
    );
  }
}

class WaterContainerPainter extends CustomPainter {
  final double waterLevel;
  final double waveValue;
  final Color waterColor;

  WaterContainerPainter({
    required this.waterLevel,
    required this.waveValue,
    required this.waterColor,
  });

  @override
  void paint(Canvas canvas, Size size) {

    if (waterLevel > 0) {

      final waveAmplitude = waterLevel > 0.1 ? 10.0 : 3.0;


      final waterPath = Path();


      final waterHeight = size.height * waterLevel;
      final waterTop = size.height - waterHeight;


      waterPath.moveTo(0, size.height);


      final waveFrequency = 1.5;
      final points = <Offset>[];


      for (double x = 0; x <= size.width; x += 1) {
        final y = waterTop +
            _calculateWaveY(x, size.width, waveValue, waveFrequency) *
                waveAmplitude;
        points.add(Offset(x, y));
      }


      if (points.isNotEmpty) {
        waterPath.lineTo(points.first.dx, points.first.dy);

        for (int i = 0; i < points.length - 1; i++) {
          final p0 = i > 0 ? points[i - 1] : points[i];
          final p1 = points[i];
          final p2 = points[i + 1];
          final p3 = i < points.length - 2 ? points[i + 2] : p2;


          final control1 = Offset(
            p1.dx + (p2.dx - p0.dx) / 6,
            p1.dy + (p2.dy - p0.dy) / 6,
          );

          final control2 = Offset(
            p2.dx - (p3.dx - p1.dx) / 6,
            p2.dy - (p3.dy - p1.dy) / 6,
          );

          waterPath.cubicTo(
            control1.dx, control1.dy,
            control2.dx, control2.dy,
            p2.dx, p2.dy,
          );
        }
      }


      waterPath.lineTo(size.width, size.height);
      waterPath.close();


      final gradient = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          waterColor.withOpacity(1.0),
          waterColor.withOpacity(0.9),
          waterColor.withOpacity(0.8),
        ],
        stops: const [0.0, 0.5, 1.0],
      );

      final waterPaint = Paint()
        ..shader = gradient.createShader(Rect.fromLTRB(0, waterTop, size.width, size.height))
        ..style = PaintingStyle.fill;

      canvas.drawPath(waterPath, waterPaint);
    }
  }


  double _calculateWaveY(double x, double width, double time, double frequency) {
    final normalizedX = x / width;

    final wave1 = sin(normalizedX * 2 * pi * frequency + time * 2 * pi);


    final wave2 = sin(normalizedX * 2 * pi * (frequency * 1.7) + time * 3 * pi) * 0.5;

    return wave1 + wave2;
  }

  @override
  bool shouldRepaint(WaterContainerPainter oldDelegate) {
    return waterLevel != oldDelegate.waterLevel ||
        waveValue != oldDelegate.waveValue ||
        waterColor != oldDelegate.waterColor;
  }
}