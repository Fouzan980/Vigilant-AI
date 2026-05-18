import 'package:flutter/material.dart';

class MediaPickerRow extends StatelessWidget {
  final VoidCallback onPhotoPressed;
  final VoidCallback onVideoPressed;
  final VoidCallback onLocationPressed;
  final VoidCallback onTagPressed;

  const MediaPickerRow({
    super.key,
    required this.onPhotoPressed,
    required this.onVideoPressed,
    required this.onLocationPressed,
    required this.onTagPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton.icon(
            onPressed: onPhotoPressed,
            icon: const Icon(Icons.camera_alt, color: Colors.grey),
            label: const Text('Photo', style: TextStyle(color: Colors.grey)),
          ),
          TextButton.icon(
            onPressed: onVideoPressed,
            icon: const Icon(Icons.videocam, color: Colors.grey),
            label: const Text('Video', style: TextStyle(color: Colors.grey)),
          ),
          TextButton.icon(
            onPressed: onLocationPressed,
            icon: const Icon(Icons.location_on, color: Colors.grey),
            label: const Text('Location', style: TextStyle(color: Colors.grey)),
          ),
          TextButton.icon(
            onPressed: onTagPressed,
            icon: const Icon(Icons.label, color: Colors.grey),
            label: const Text('Tag', style: TextStyle(color: Colors.grey)),
          ),
        ],
      ),
    );
  }
}
