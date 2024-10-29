import 'package:card_scanner/controllers/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

void showImagePickerOptions(BuildContext context, CardController controller) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                controller.pickImage(ImageSource.camera);
                Get.back();
              },
              icon: const Icon(Icons.camera),
              label: const Text("Camera"),
            ),
            ElevatedButton.icon(
              onPressed: () {
                controller.pickImage(ImageSource.gallery);
                Get.back();
              },
              icon: const Icon(Icons.image),
              label: const Text("Gallery"),
            ),
          ],
        ),
      );
    },
  );
}
