import 'dart:io';

import 'package:flutter/material.dart';

class FullScreenImageViewer extends StatelessWidget {
  final File? imageFile;
  final String? imageUrl;

  const FullScreenImageViewer({super.key, this.imageFile, this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: imageFile != null
                ? Image.file(imageFile!,
                    fit: BoxFit.contain) // Display local file
                : imageUrl != null
                    ? Image.network(imageUrl!,
                        fit: BoxFit.contain) // Display network image
                    : Container(), // Fallback in case both are null
          ),
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: const Icon(
                Icons.close,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
