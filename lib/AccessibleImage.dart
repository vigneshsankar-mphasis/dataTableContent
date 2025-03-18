import 'package:flutter/material.dart';

List<Map<String, String>> images = [
  {'url': 'https://picsum.photos/200/300/?blur=2', 'alt': 'Placeholder 1'},
  {'url': 'https://picsum.photos/200/300/?blur=2', 'alt': 'Placeholder 2'},
  {'url': 'https://picsum.photos/200/300/?blur=2', 'alt': 'Placeholder 3'},
  {'url': 'https://picsum.photos/200/300/?blur=2', 'alt': 'Placeholder 4'},
];

class AccessibleImage extends StatelessWidget {
  final String imageUrl;
  final String altText;
  final double? width;
  final double? height;
  final BoxFit fit;

  const AccessibleImage({
    super.key,
    required this.imageUrl,
    required this.altText,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: altText,
      child: Image.network(
        imageUrl,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (context, error, stackTrace) => _buildErrorWidget(),
      ),
    );
  }

  Widget _buildErrorWidget() {
    return Semantics(
      label: 'Image not available: $altText',
      child: const Icon(Icons.broken_image, size: 50, color: Colors.grey),
    );
  }
}
