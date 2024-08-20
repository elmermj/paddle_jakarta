import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:paddle_jakarta/utils/tools/log.dart';

class WebClientIdHelper {
  
  static Future<String> getWebClientId() async {
    final jsonString = await rootBundle.loadString('assets/firebase_options.json');
    Map<String, dynamic> jsonData = jsonDecode(jsonString);
    Log.green(jsonData.toString());
    String clientId = jsonData['web_client_id'];
    return clientId;
  }
  
}