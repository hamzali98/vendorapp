import 'package:flutter/material.dart';
import 'package:vendor_app/res/colors/app_color.dart';

class OrderDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> orderData;

  const OrderDetailsScreen({Key? key, required this.orderData})
      : super(key: key);

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late String orderStatus;

  @override
  void initState() {
    super.initState();
    orderStatus = widget.orderData['order_status'] ?? 'pending';
  }

  void _showStatusBottomSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Change Order Status',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              ListTile(
                leading: const Icon(Icons.check_circle, color: Colors.green),
                title: const Text('Accepted'),
                onTap: () {
                  setState(() => orderStatus = 'accepted');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.cancel, color: Colors.red),
                title: const Text('Cancelled'),
                onTap: () {
                  setState(() => orderStatus = 'cancelled');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading:
                    const Icon(Icons.hourglass_empty, color: Colors.orange),
                title: const Text('Pending'),
                onTap: () {
                  setState(() => orderStatus = 'pending');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      case 'pending':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = widget.orderData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        backgroundColor: AppColor.primeryBlueColor,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 6,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 36,
                    backgroundColor: Colors.indigo.shade100,
                    child: Icon(Icons.shopping_bag,
                        size: 40, color: AppColor.primeryBlueColor),
                  ),
                ),
                const SizedBox(height: 20),
                _infoRow('Order ID', data['id']),
                _infoRow('Customer', data['customer_name']),
                _infoRow('Order Type', data['order_type']),
                _infoRow('Order Date', data['order_date']),
                _infoRow('Order Time', data['order_time']),
                _infoRow('Order Price', 'Rs. ${data['order_price']}'),
                _infoRow('Weight', '${data['weight']} kg'),
                _infoRow('Status', orderStatus,
                    valueColor: _statusColor(orderStatus)),
                const SizedBox(height: 30),
                if (orderStatus.toLowerCase() != 'completed')
                  Center(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: AppColor.primeryBlueColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      icon: const Icon(Icons.edit),
                      label: const Text('Change Status'),
                      onPressed: _showStatusBottomSheet,
                    ),
                  ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String? value, {Color? valueColor}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              value ?? '-',
              style: TextStyle(
                fontSize: 16,
                color: valueColor ?? Colors.black54,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// Example usage (replace with your actual data source):
// void main() {
//   runApp(MaterialApp(
//     home: OrderDetailsScreen(orderData: {
//       "id": "186",
//       "order_q_id": "",
//       "customer_id": "124",
//       "customer_name": "hamza ali",
//       "driver_name": null,
//       "st_address": null,
//       "order_time": "2025-05-11 04:27 PM",
//       "order_date": "2025-05-11",
//       "order_type": "pickup & delivery",
//       "order_status": "cancelled",
//       "order_price": "50.00",
//       "receipt": "",
//       "rating": null,
//       "attachment": null,
//       "delivery_code": null,
//       "product_type": null,
//       "created_at": "2025-04-19 14:22:37",
//       "weight": "0.00",
//       "pickup_order_time": ""
//     }),
//   ));
// }
