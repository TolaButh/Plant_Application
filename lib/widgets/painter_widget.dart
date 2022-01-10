import 'package:flutter/material.dart';
class PainterWidget extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    var radius = 10.0;
    var paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;
    var path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.width- radius);
    
    path.quadraticBezierTo(0, size.width,radius,size.height);
    path.lineTo(size.width, size.height);
    canvas.drawPath(path, paint);



    
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate)=>true;
   

}