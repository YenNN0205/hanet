// ignore_for_file: non_constant_identifier_names

import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvironmentController {
  static late final String ACCESS_TOKEN;
  static late final String REFRESH_TOKEN;
  static late final String CLIENT_ID;

  static void setUpEnvData() {
    ACCESS_TOKEN = dotenv.get("ACCESS_TOKEN", fallback: '');
    REFRESH_TOKEN = dotenv.get("REFRESH_TOKEN", fallback: '');
    CLIENT_ID = dotenv.get("CLIENT_ID", fallback: '');

    // print("Client id: " + CLIENT_ID);
    // print("acess token: " + ACCESS_TOKEN);
    // print("refresh token: " + REFRESH_TOKEN);
  }
}
