import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ShimmerPaint extends SingleChildRenderObjectWidget {
  final double percent;
  final Gradient gradient;

  ShimmerPaint({Widget child, this.percent, this.gradient})
      : super(child: child);

  @override
  void updateRenderObject(BuildContext context, _ShimmerFilter shimmer) {
    shimmer.percent = percent;
    // super.updateRenderObject(context, shimmer);
  }

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _ShimmerFilter(percent, gradient);
  }
}

class _ShimmerFilter extends RenderProxyBox {
  double _percent;
  final Gradient _gradient;
  final Paint _gradientPaint;
  final _clearPaint = Paint();

  _ShimmerFilter(this._percent, this._gradient)
      : _gradientPaint = Paint()..blendMode = BlendMode.srcIn;

  set percent(double newValue) {
    if (newValue != _percent) {
      _percent = newValue;
      markNeedsPaint();
    }
  }

  @override
  bool get alwaysNeedsCompositing => child != null;

  double _offset(double start, double end, double percent) {
    return start + (end - start) * percent;
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    if (child != null) {
      assert(needsCompositing);

      final width = child.size.width;
      final height = child.size.height;

      double dy = 0.0;
      double dx = _offset(-width, width, _percent);
      Rect rect =
          Rect.fromLTWH(offset.dx - width, offset.dy, 3 * width, height);

      _gradientPaint.shader = _gradient.createShader(rect);

      context.canvas.saveLayer(offset & child.size, _clearPaint);
      context.paintChild(child, offset);
      context.canvas.translate(dx, dy);
      context.canvas.drawRect(rect, _gradientPaint);
      context.canvas.restore();
    }
  }
}
