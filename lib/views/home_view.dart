import 'package:card_scanner/views/widgets/bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/card_controller.dart';
import 'display_card_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final CardController controller = Get.put(CardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Visiting Cards')),
      body: Obx(() {
        return controller.cardList.isEmpty
            ? const Center(
                child: Text("Scan the Visiting card to view details"),
              )
            : ListView.builder(
                itemCount: controller.cardList.length,
                itemBuilder: (context, index) {
                  final card = controller.cardList[index];
                  return ListTile(
                    title: Text(card.name),
                    subtitle: Text(card.phone),
                    onTap: () => Get.to(DisplayCardView(card: card)),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => controller.deleteCard(card.id!),
                    ),
                  );
                },
              );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showImagePickerOptions(context, controller),
        child: const Icon(Icons.camera),
      ),
    );
  }
}
