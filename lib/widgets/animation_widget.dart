import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:plantapp/pages/plant_add_page.dart';
import 'package:plantapp/widgets/painter_widget.dart';
import 'dart:math' as math;

class AnimationScan extends StatefulWidget {
  const AnimationScan({Key? key}) : super(key: key);

  @override
  _AnimationScanState createState() => _AnimationScanState();
}

class _AnimationScanState extends State<AnimationScan>with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _positon;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      // ignore: prefer_const_constructors
      duration: Duration(milliseconds: 1000),
    );
    _positon = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(
        parent: _animationController,
        // ignore: prefer_const_constructors
        curve: Interval(0, 1),
      ),
    )..addListener(() {
        setState(() {});
      });
      _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      width: 200,
      height: 200,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Transform.rotate(
                    angle: math.pi / 2,
                    child: _buildPainter(),
                  ),
                  Transform.rotate(
                    angle: math.pi,
                    child: _buildPainter(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _buildPainter(),
                  Transform.rotate(
                    angle: -math.pi / 2,
                    child: _buildPainter(),
                  ),
                ],
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: DottedBorder(
              color: Colors.white,
              dashPattern: [8, 4],
              strokeWidth: 2,
              customPath: (size) {
                return Path()
                  ..moveTo(0, 0)
                  ..lineTo(size.width, 0);
              },
              child: Container(
                height: _positon.value,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white30.withAlpha(30), Colors.white30],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  CustomPaint _buildPainter() {
    return CustomPaint(
      painter: PainterWidget(),
      child: Container(
        width: 50,
        height: 50,
      ),
    );
  }
}
