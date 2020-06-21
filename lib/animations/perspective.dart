import 'package:flutter/material.dart';

class Perspective extends StatefulWidget {
  _Perspective createState() => _Perspective();
}

class _Perspective extends State<Perspective> {
  Offset _offset = Offset(0.4, 0.7);

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: FractionalOffset.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(0.01 * _offset.dy)
        ..rotateY(-0.01 * _offset.dx),
      child: GestureDetector(
        child: _theApp(),
        onDoubleTap: () => setState(() => _offset = Offset.zero),
        onPanUpdate: (details) => setState(() => _offset += details.delta),
      ),
    );
  }

  Scaffold _theApp() {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Perspective')),
      body: Column(
        children: <Widget>[],
      ),
    );
  }
}
