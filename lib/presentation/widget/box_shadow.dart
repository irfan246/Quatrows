import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'dart:ui' as ui show lerpDouble;
import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter/painting.dart' as painting;

class MyBoxShadow extends painting.BoxShadow {
  const MyBoxShadow({
    super.color,
    super.offset,
    super.blurRadius,
    super.spreadRadius,
    super.blurStyle,
    this.inset = false,
  });
  final bool inset;
  @override
  MyBoxShadow scale(double factor) {
    return MyBoxShadow(
      color: color,
      offset: offset * factor,
      blurRadius: blurRadius * factor,
      spreadRadius: spreadRadius * factor,
      blurStyle: blurStyle,
      inset: inset,
    );
  }
  static MyBoxShadow? lerp(MyBoxShadow? a, MyBoxShadow? b, double t) {
    if (a == null && b == null) {
      return null;
    }
    if (a == null) {
      return b!.scale(t);
    }
    if (b == null) {
      return a.scale(1.0 - t);
    }

    final blurStyle =
        a.blurStyle == BlurStyle.normal ? b.blurStyle : a.blurStyle;

    if (a.inset != b.inset) {
      return MyBoxShadow(
        color: lerpColorWithPivot(a.color, b.color, t),
        offset: lerpOffsetWithPivot(a.offset, b.offset, t),
        blurRadius: lerpDoubleWithPivot(a.blurRadius, b.blurRadius, t),
        spreadRadius: lerpDoubleWithPivot(a.spreadRadius, b.spreadRadius, t),
        blurStyle: blurStyle,
        inset: t >= 0.5 ? b.inset : a.inset,
      );
    }

    return MyBoxShadow(
      color: Color.lerp(a.color, b.color, t)!,
      offset: Offset.lerp(a.offset, b.offset, t)!,
      blurRadius: ui.lerpDouble(a.blurRadius, b.blurRadius, t)!,
      spreadRadius: ui.lerpDouble(a.spreadRadius, b.spreadRadius, t)!,
      blurStyle: blurStyle,
      inset: b.inset,
    );
  }

  /// Linearly interpolate between two lists of box shadows.
  ///
  /// If the lists differ in length, excess items are lerped with null.
  ///
  /// {@macro dart.ui.shadow.lerp}
  static List<MyBoxShadow>? lerpList(
    List<MyBoxShadow>? a,
    List<MyBoxShadow>? b,
    double t,
  ) {
    if (a == null && b == null) {
      return null;
    }
    a ??= <MyBoxShadow>[];
    b ??= <MyBoxShadow>[];
    final int commonLength = math.min(a.length, b.length);
    return <MyBoxShadow>[
      for (int i = 0; i < commonLength; i += 1)
        MyBoxShadow.lerp(a[i], b[i], t)!,
      for (int i = commonLength; i < a.length; i += 1) a[i].scale(1.0 - t),
      for (int i = commonLength; i < b.length; i += 1) b[i].scale(t),
    ];
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (other.runtimeType != runtimeType) {
      return false;
    }
    return other is MyBoxShadow &&
        other.color == color &&
        other.offset == offset &&
        other.blurRadius == blurRadius &&
        other.spreadRadius == spreadRadius &&
        other.blurStyle == blurStyle &&
        other.inset == inset;
  }

  @override
  int get hashCode =>
      Object.hash(color, offset, blurRadius, spreadRadius, blurStyle, inset);

  @override
  String toString() =>
      'MyBoxShadow($color, $offset, ${debugFormatDouble(blurRadius)}, ${debugFormatDouble(spreadRadius)}), $blurStyle, $inset)';
}

double lerpDoubleWithPivot(num? a, num? b, double t) {
  if (t < 0.5) {
    return ui.lerpDouble(a, 0, t * 2)!;
  }

  return ui.lerpDouble(0, b, (t - 0.5) * 2)!;
}

Offset lerpOffsetWithPivot(Offset? a, Offset? b, double t) {
  if (t < 0.5) {
    return Offset.lerp(a, Offset.zero, t * 2)!;
  }

  return Offset.lerp(Offset.zero, b, (t - 0.5) * 2)!;
}

Color lerpColorWithPivot(Color? a, Color? b, double t) {
  if (t < 0.5) {
    return Color.lerp(a, a?.withAlpha(0), t * 2)!;
  }

  return Color.lerp(b?.withAlpha(0), b, (t - 0.5) * 2)!;
}
