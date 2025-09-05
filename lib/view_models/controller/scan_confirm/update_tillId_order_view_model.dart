import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor_app/view/home/home_view.dart';
import '../../../models/scan_confirm/update_order_by_till_id.dart';
import '../../../repository/scan_confirm/update_order_tillId_repository.dart';

class UpdateTillIDOrderController extends GetxController {
  final UpdateTillIdOrderRepository _updateOrderRepository =
      UpdateTillIdOrderRepository();

  var isLoading = false.obs;
  var errorMessage = RxnString();
  var updateResponse = Rxn<UpadateTillIdOderModel>();

  Future<void> updateOrderByTillID(
    String orderId,
    String customerId,
    String totalBags,
    String weight,
    String totalPrice,
  ) async {
    try {
      isLoading(true);
      errorMessage.value = null;

      // 🚀 Debugging: Print values before sending request
      print("📡 DEBUG: Updating Order");
      print("🆔 Order ID: $orderId");
      print("🏢 Laundromat ID: Awaiting from SharedPreferences");
      print("👤 Customer ID: $customerId");
      print("📦 Total Bags: $totalBags");
      print("⚖ Weight: $weight");
      print("💰 Total Price: $totalPrice");

      UpadateTillIdOderModel response =
          await _updateOrderRepository.updateOrderByTillID(
        orderId,
        customerId,
        totalBags,
        weight,
        totalPrice,
      );
      if (response.responseCode == 200) {
        updateResponse.value = response;

        print("✅ Update Successful: ${response.title}");
        Get.snackbar("Success", response.title ?? "Order updated successfully!",
            snackPosition: SnackPosition.BOTTOM);
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(HomeView()); // Replace '/home' with your actual home route
        });
      } else {
        Get.snackbar("Error", response.title ?? "Order update failed!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }
    } catch (error) {
      errorMessage.value = "❌ Update Failed: $error";
      print(errorMessage.value);
      Get.snackbar("Error", errorMessage.value!,
          snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading(false);
    }
  }
}
