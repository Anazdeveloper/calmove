import 'dart:convert';

import 'package:calmove/Modals/doctors_list_modal.dart';
import 'package:calmove/Services/api.dart';

class DoctorsRepo {
  Future getData() async {
    final response = await Http().get('https://appdev.abeermedicalgroup.com/GetAllDoctors');
    print('DoctorsList Response: ${response.body}');
    if(response.statusCode == 200) {
      return Doctors.fromJson(jsonDecode(response.body));
    } else {
      return jsonDecode(response.body);
    }
  }
}