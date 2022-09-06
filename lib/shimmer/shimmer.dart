import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

/// Shimmer の楕円形や長方形の要素ウィジェット
class ShimmerWidget extends StatelessWidget {
  /// 楕円形
  const ShimmerWidget.circular({
    Key? key,
    required this.height,
    required this.width,
    Color? baseColor,
    Color? highlightColor,
  })  : baseColor = baseColor ?? _baseColor,
        highlightColor = highlightColor ?? _highlightColor,
        borderRadius = null,
        shape = BoxShape.circle;

  /// 長方形
  const ShimmerWidget.rectangular({
    Key? key,
    required this.height,
    this.width = double.infinity,
    this.borderRadius = 0,
    Color? baseColor,
    Color? highlightColor,
  })  : baseColor = baseColor ?? _baseColor,
        highlightColor = highlightColor ?? _highlightColor,
        shape = BoxShape.rectangle;

  static const _baseColor = Colors.black26;
  static const _highlightColor = Colors.black12;

  final double height;
  final double width;
  final Color baseColor;
  final Color highlightColor;
  final BoxShape shape;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: baseColor,
            borderRadius: borderRadius == null
                ? null
                : BorderRadius.circular(borderRadius!),
            shape: shape,
          ),
        ),
      );
}

/// Shimmer の楕円形や長方形の要素ウィジェット。
/// ListView などの子要素として並べるために Alignment ウィジェットでラップしている。
class AlignedShimmerWidget extends StatelessWidget {
  /// 楕円形
  const AlignedShimmerWidget.circular({
    Key? key,
    required this.height,
    required this.width,
    this.alignment = Alignment.centerLeft,
    Color? baseColor,
    Color? highlightColor,
  })  : baseColor = baseColor ?? _baseColor,
        highlightColor = highlightColor ?? _highlightColor,
        borderRadius = null,
        shape = BoxShape.circle;

  /// 長方形
  const AlignedShimmerWidget.rectangular({
    Key? key,
    required this.height,
    required this.width,
    this.alignment = Alignment.centerLeft,
    this.borderRadius = 0,
    Color? baseColor,
    Color? highlightColor,
  })  : baseColor = baseColor ?? _baseColor,
        highlightColor = highlightColor ?? _highlightColor,
        shape = BoxShape.rectangle;

  static const _baseColor = Colors.black26;
  static const _highlightColor = Colors.black12;

  final Alignment alignment;
  final double height;
  final double width;
  final Color baseColor;
  final Color highlightColor;
  final BoxShape shape;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) => Align(
        alignment: alignment,
        child: Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: borderRadius == null
                  ? null
                  : BorderRadius.circular(borderRadius!),
              shape: shape,
            ),
          ),
        ),
      );
}
