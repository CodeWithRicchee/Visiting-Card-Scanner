import 'dart:io';
import 'package:card_scanner/services/database_services.dart';
import 'package:card_scanner/services/ocr_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../models/card_model.dart';

class CardController extends GetxController {
  var cardList = <CardModel>[].obs;
  final OcrService _ocrService = OcrService();
  final DatabaseService _databaseService = DatabaseService();
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    fetchCards();
  }

  void fetchCards() async {
    cardList.value = await _databaseService.getAllCards();
  }

  Future<void> addCardFromImage(File image) async {
    CardModel card = await _ocrService.extractText(image);

    if (card.name.isEmpty && card.phone.isEmpty && card.email.isEmpty) {
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.snackbar(
          'Error',
          'No text found in the image. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      });
      return;
    }

    await _databaseService.insertCard(card);
    fetchCards();
  }

  void deleteCard(int id) async {
    await _databaseService.deleteCard(id);
    fetchCards();
  }

  Future<void> pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      await addCardFromImage(File(image.path));
      Get.back();
    }
  }
}
