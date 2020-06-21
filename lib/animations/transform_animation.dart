import 'package:flutter/material.dart';

class TransformAnimation extends StatefulWidget {
  _TransformAnimation createState() => _TransformAnimation();
}

class _TransformAnimation extends State<TransformAnimation> {
  double x = 0.0;
  double y = 0.0;
  double z = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transform Matrix4')),
      body: Center(
        child: Transform(
          alignment: FractionalOffset.center,
          transform: Matrix4(
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
            0,
            0,
            0,
            0,
            1,
          )
            ..rotateX(x)
            ..rotateY(y)
            ..rotateZ(z),
          child: GestureDetector(
            onPanUpdate: (DragUpdateDetails details) {
              setState(() {
                y -= details.delta.dx / 100;
                x += details.delta.dy / 100;
              });
            },
            child: Container(
              width: 200,
              height: 200,
              color: Colors.blueGrey,
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Move Me',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
