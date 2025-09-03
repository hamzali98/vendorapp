import 'package:get/get.dart';
import '../../../models/activity/activity_history_model.dart';
import '../../../repository/activity_repository/activity_history_repository.dart';

class ActivityOrdersHistoryViewModel extends GetxController {
  final ActivityOrdersHistoryRepository _repository = ActivityOrdersHistoryRepository();

  var orders = <Orders>[].obs;
  var isLoading = false.obs;
  var hasMoreData = true.obs;

  int _currentPage = 1;
  int _totalPages = 1;

  @override
  void onInit() {
    super.onInit();
    //fetchOrders(); // ✅ Fetch initial orders when ViewModel initializes
  }

  /// **🔄 Load Initial Orders**
  Future<void> fetchOrders({int limit = 10, String? orderType}) async {
    isLoading(true);
    hasMoreData(true);
    orders.clear();
    _currentPage = 1;
    _totalPages = 1;

    try {
      print("📡 Fetching Orders - Page: $_currentPage, Limit: $limit");

      ActivityOrdersHistoryModel? orderHistory = await _repository.fetchOrders(
        page: _currentPage,
        limit: limit,
        orderType: orderType,
      );

      // ✅ Log the entire JSON response before parsing it
      print("🔹 API Response (Raw JSON): ${orderHistory?.toJson()}");

      if (orderHistory != null && orderHistory.orders != null) {
        print("✅ Orders Fetched: ${orderHistory.orders!.length}");
        orders.addAll(orderHistory.orders!);
        _totalPages = orderHistory.pagination?.totalPages ?? 1;
        hasMoreData(_currentPage < _totalPages);
        update(); // ✅ Force UI Update
      } else {
        print("⚠️ No Orders Found!");
        hasMoreData(false);
      }
    } catch (e) {
      print("❌ Error Fetching Orders: $e");
    } finally {
      isLoading(false);
    }
  }


  /// **📌 Load More Orders (Pagination)**
  Future<void> loadMoreOrders({int limit = 10, String? orderType}) async {
    if (!hasMoreData.value || isLoading.value) return;

    isLoading(true);
    _currentPage++;

    try {
      print("📡 Loading More Orders - Page: $_currentPage");

      ActivityOrdersHistoryModel? moreOrders = await _repository.fetchOrders(
        page: _currentPage,
        limit: limit,
        orderType: orderType,
      );

      // ✅ Log the entire JSON response before parsing it
      print("🔹 API Response (Raw JSON): ${moreOrders?.toJson()}");

      if (moreOrders != null && moreOrders.orders != null) {
        print("✅ More Orders Fetched: ${moreOrders.orders!.length}");
        orders.addAll(moreOrders.orders!);
        hasMoreData(_currentPage < _totalPages);
        update(); // ✅ Ensure UI Updates
      } else {
        hasMoreData(false);
      }
    } catch (e) {
      print("❌ Error Loading More Orders: $e");
    } finally {
      isLoading(false);
    }
  }

}
