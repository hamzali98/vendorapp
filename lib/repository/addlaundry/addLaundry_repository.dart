import 'dart:convert';
import 'dart:io';

import 'package:vendor_app/data/app_exceptions.dart';

import '../../data/network/network_api_services.dart';
import 'package:http/http.dart' as http;

class AddlaundryRepository {
  final _apiService = NetworkApiServices();

  Future<dynamic> fetchzapi() async {
    // try {
    //   dynamic response =
    //       await _apiService.postApi(signupData, AppUrl.signupApi);

    //   print("🔹 signup API Response: $response");

    //   if (response["ResponseCode"] == "200") {
    //     // ✅ Save user and token
    //     print("🔍 Checking Token After Saving: ${response["SecurityToken"]}");
    //   } else {
    //     print("🚨 signup Failed: ${response["ResponseMsg"]}");
    //   }

    //   return response; // Return response to UI
    // } catch (e) {
    //   print("❌ Signup Error: $e");
    //   return null;
    // }
    // (((((((((((())))))))))))

    const url = 'https://laundry.saleselevation.tech/user_api/getzone.php';
    dynamic responseJson;
    try {
      print("📡 Sending GET (POST) request to: $url");

      // ✅ Convert `laundromat_id` into a JSON body
      // Map<String, dynamic> body = {
      //   "laundromat_id": laundromatId, // 🔹 Send in request body
      //   "page": 1,
      //   "limit": 200
      // };

      // print("📡 Sending Request Body: ${jsonEncode(body)}");

      final response = await http.get(
        // ✅ Use `POST` instead of `GET`
        Uri.parse(url),
        headers: {
          // "Security-Token": token, // ✅ Include the security token
          "Content-Type": "application/json",
        },
        // body: jsonEncode(body),
      ).timeout(const Duration(seconds: 10));

      print("🔹 Response Status: ${response.statusCode}");
      print("🔹 Response Body: ${response.body}");

      responseJson = _apiService.returnResponse(response);
    } on SocketException {
      print("🚨 No Internet Connection!");
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }

  Future<dynamic> addlaundapi(Map<String, dynamic> body) async {
    // (((((((((((())))))))))))

    const url =
        'https://laundry.saleselevation.tech/laundry_api/add_laundry.php';
    dynamic responseJson;
    try {
      print("📡 Sending GET (POST) request to: $url");

      final response = await http
          .post(
            // ✅ Use `POST` instead of `GET`
            Uri.parse(url),
            headers: {
              // "Security-Token": token, // ✅ Include the security token
              "Content-Type": "application/json",
            },
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 10));

      print("🔹 Response Status: ${response.statusCode}");
      print("🔹 Response Body: ${response.body}");

      responseJson = _apiService.returnResponse(response);
    } on SocketException {
      print("🚨 No Internet Connection!");
      throw InternetException('');
    } on RequestTimeOut {
      throw RequestTimeOut('');
    }
    return responseJson;
  }
}
// }
