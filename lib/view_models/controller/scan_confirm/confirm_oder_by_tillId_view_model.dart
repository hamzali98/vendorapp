import 'package:get/get.dart';
import '../../../data/response/status.dart';
import '../../../models/scan_confirm/scan_till_id_confirm_order_model.dart';
import '../../../repository/scan_confirm/scan_confirm_id_repository.dart';

class ConfirmOrderByIdController extends GetxController {
  final _api = ScanAndConfirmRepository();

  final rxRequestStatus = Status.LOADING.obs;
  final orderData = UserByTillIDModel().obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  void setOrderData(UserByTillIDModel value) => orderData.value = value;

  /// ✅ Get Order Details
  OrderDetails? get orderDetails => orderData.value.orderDetails;

  /// 🔍 **Confirm Order by Order Q ID**
  Future<void> confirmOrder(String orderQId) async {
    setRxRequestStatus(Status.LOADING);
    print("📡 DEBUG: Fetching Order with order_q_id: $orderQId");

    try {
      final response = await _api.ConfirmOrderByTillID(orderQId);
      print("🔎 API Response: ${response.toJson()}");

      if (response.orderDetails != null) {
        print("✅ Order Found: ${response.orderDetails!.orderId}");
        setOrderData(response);
        setRxRequestStatus(Status.COMPLETED);
      } else {
        print("❌ Order Not Found!");
        setRxRequestStatus(Status.ERROR);
      }
    } catch (error) {
      print("❌ API Error: $error");
      setRxRequestStatus(Status.ERROR);
    }
  }
}
