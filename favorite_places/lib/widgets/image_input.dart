import 'package:flutter/material.dart';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key});

  @override
  State<ImageInput> createState() {
    return _ImageInputState();
  }
}

class _ImageInputState extends State<ImageInput> {
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Theme.of(context).colorScheme.onSurface,
        ),
      ),
      height: 250,
      width: double.infinity,
      child: TextButton.icon(
        label: Text('Take Picture'),
        icon: const Icon(Icons.camera),
        onPressed: () {},
      ),
    );
  }
}
