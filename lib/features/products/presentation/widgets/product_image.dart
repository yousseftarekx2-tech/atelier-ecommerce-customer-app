import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({
    required this.image,
    this.fit = BoxFit.cover,
    this.width,
    this.height,
    super.key,
  });

  final String image;
  final BoxFit fit;
  final double? width;
  final double? height;

  bool get _isNetworkImage {
    return image.startsWith('http://') || image.startsWith('https://');
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    if (image.trim().isEmpty) {
      return _Placeholder(colorScheme: colorScheme);
    }

    if (_isNetworkImage) {
      return Image.network(
        image,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (_, _, _) => _Placeholder(colorScheme: colorScheme),
      );
    }

    return Image.asset(
      image,
      width: width,
      height: height,
      fit: fit,
      errorBuilder: (_, _, _) => _Placeholder(colorScheme: colorScheme),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: colorScheme.onSurfaceVariant.withValues(alpha: 0.55),
      ),
    );
  }
}
