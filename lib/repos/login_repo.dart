import 'dart:convert';

import 'package:calmove/Services/api.dart';
import 'package:calmove/Services/device_info.dart';

class LoginRepo {
  final username;
  final password;
  //String requestFrom = DeviceInfo().getRequestForm() as String;

  LoginRepo(this.username, this.password);

  Future getData() async {
    print('username: $username');
    print('password: $password');
    //print('RequestForm: $requestFrom}');
    final response = await Http().get(
        'https://appdev.abeermedicalgroup.com/Login' +
            '?UserName=$username&Password=$password&RequestFrom=3');
    print('Login Response: ${response.body}');
    return jsonDecode(response.body);
  }
}
