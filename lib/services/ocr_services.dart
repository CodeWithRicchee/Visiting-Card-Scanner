import 'dart:io';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:card_scanner/models/card_model.dart';

class OcrService {
  Future<CardModel> extractText(File imageFile) async {
    final inputImage = InputImage.fromFile(imageFile);
    final textRecognizer = TextRecognizer();

    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    String name = '';
    String phone = '';
    String email = '';

    final phoneRegex = RegExp(r'\b(\+\d{1,3}|\d{1,3})?\s?(\d{7,15}|\d{1,5}(\s\d{1,5}){1,4})\b');
    final emailRegex = RegExp(r'\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\b');

    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        String lineText = line.text;

        final phoneMatch = phoneRegex.firstMatch(lineText);
        if (phone.isEmpty && phoneMatch != null) {
          final matchedPhone = phoneMatch.group(0)?.replaceAll(RegExp(r'\D'), '') ?? '';
          if (matchedPhone.length >= 10) {
            phone = matchedPhone;
          }
        } else if (email.isEmpty && emailRegex.hasMatch(lineText)) {
          email = emailRegex.firstMatch(lineText)?.group(0) ?? '';
        } else if (name.isEmpty) {
          name = lineText;
        }
      }
    }

    await textRecognizer.close();

    return CardModel(name: name, phone: phone, email: email);
  }
}
