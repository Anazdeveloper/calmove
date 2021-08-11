import 'dart:convert';

Doctors doctorsFromJson(String str) => Doctors.fromJson(json.decode(str));

String doctorsToJson(Doctors data) => json.encode(data.toJson());

class Doctors {
  Doctors({
    this.success,
    this.title,
    this.message,
    this.data,
    this.authKey,
  });

  bool ? success;
  String ? title;
  String ? message;
  List<DoctorData> ? data;
  dynamic authKey;

  factory Doctors.fromJson(Map<String, dynamic> json) => Doctors(
    success: json["Success"],
    title: json["Title"],
    message: json["Message"],
    data: List<DoctorData>.from(json["Data"].map((x) => DoctorData.fromJson(x))),
    authKey: json["AuthKey"],
  );

  Map<String, dynamic> toJson() => {
    "Success": success,
    "Title": title,
    "Message": message,
    "Data": List<dynamic>.from(data!.map((x) => x.toJson())),
    "AuthKey": authKey,
  };
}

class DoctorData {
  DoctorData({
    this.doctorName,
    this.doctorCode,
    this.designation,
    this.designationId,
    this.thumpImage,
    this.availability,
    this.branchId,
    this.branchName,
    this.region,
    this.departmentId,
    this.departmentName,
    this.disclaimer,
    this.favourite,
    this.availableForTeleconsultation,
  });

  String ? doctorName;
  String ? doctorCode;
  Designation ? designation;
  dynamic designationId;
  String ? thumpImage;
  String ? availability;
  BranchId ? branchId;
  BranchName ? branchName;
  Region ? region;
  String ? departmentId;
  String ? departmentName;
  String ? disclaimer;
  bool ? favourite;
  bool ? availableForTeleconsultation;

  factory DoctorData.fromJson(Map<String, dynamic> json) => DoctorData(
    doctorName: json["DoctorName"],
    doctorCode: json["DoctorCode"],
    designation: designationValues.map[json["Designation"]],
    designationId: json["DesignationId"],
    thumpImage: json["ThumpImage"],
    availability: json["Availability"],
    branchId: branchIdValues.map[json["BranchId"]],
    branchName: branchNameValues.map[json["BranchName"]],
    region: regionValues.map[json["Region"]],
    departmentId: json["DepartmentId"],
    departmentName: json["DepartmentName"],
    disclaimer: json["Disclaimer"],
    favourite: json["Favourite"],
    availableForTeleconsultation: json["AvailableForTeleconsultation"],
  );

  Map<String, dynamic> toJson() => {
    "DoctorName": doctorName,
    "DoctorCode": doctorCode,
    "Designation": designationValues.reverse[designation],
    "DesignationId": designationId,
    "ThumpImage": thumpImage,
    "Availability": availability,
    "BranchId": branchIdValues.reverse[branchId],
    "BranchName": branchNameValues.reverse[branchName],
    "Region": regionValues.reverse[region],
    "DepartmentId": departmentId,
    "DepartmentName": departmentName,
    "Disclaimer": disclaimer,
    "Favourite": favourite,
    "AvailableForTeleconsultation": availableForTeleconsultation,
  };
}

enum BranchId { SA_10, SA_1, SA_28, SA_3, SA_4, SA_9, SA_13, SA_6, SA_7 }

final branchIdValues = EnumValues({
  "SA-1": BranchId.SA_1,
  "SA-10": BranchId.SA_10,
  "SA-13": BranchId.SA_13,
  "SA-28": BranchId.SA_28,
  "SA-3": BranchId.SA_3,
  "SA-4": BranchId.SA_4,
  "SA-6": BranchId.SA_6,
  "SA-7": BranchId.SA_7,
  "SA-9": BranchId.SA_9
});

enum BranchName { ABEER_MEDICAL_CENTER_DAMMAM, ABEER_MEDICAL_CENTER_SHARAFIYAH, AL_HIBA_MEDICAL_CENTER_RUWAIS, ABEER_MEDICAL_CENTER_AZIZIYAH, ABEER_MEDICAL_CENTER_BAWADI, ABEER_MEDICAL_CENTER_MADINAH, SAUDI_NATIONAL_HOSPITAL_MAKKAH, ABEER_MEDICAL_CENTER_BATHA, ABEER_MEDICAL_CENTER_SHUMAISY }

final branchNameValues = EnumValues({
  "Abeer Medical Center - Aziziyah": BranchName.ABEER_MEDICAL_CENTER_AZIZIYAH,
  "Abeer Medical Center - Batha": BranchName.ABEER_MEDICAL_CENTER_BATHA,
  "Abeer Medical Center - Bawadi": BranchName.ABEER_MEDICAL_CENTER_BAWADI,
  "Abeer Medical Center - Dammam": BranchName.ABEER_MEDICAL_CENTER_DAMMAM,
  "Abeer Medical Center - Madinah": BranchName.ABEER_MEDICAL_CENTER_MADINAH,
  "Abeer Medical Center - Sharafiyah": BranchName.ABEER_MEDICAL_CENTER_SHARAFIYAH,
  "Abeer Medical Center - Shumaisy": BranchName.ABEER_MEDICAL_CENTER_SHUMAISY,
  "Al Hiba Medical Center Ruwais": BranchName.AL_HIBA_MEDICAL_CENTER_RUWAIS,
  "Saudi National Hospital - Makkah": BranchName.SAUDI_NATIONAL_HOSPITAL_MAKKAH
});

enum Designation { SPECIALIST, DENTIST, CONSULTANT, GENERAL_PRACTITIONER, SENIOR_SPECIALIST, RESIDENT, REGISTRAR }

final designationValues = EnumValues({
  "Consultant": Designation.CONSULTANT,
  "DENTIST": Designation.DENTIST,
  "GENERAL PRACTITIONER": Designation.GENERAL_PRACTITIONER,
  "Registrar": Designation.REGISTRAR,
  "Resident": Designation.RESIDENT,
  "Senior Specialist": Designation.SENIOR_SPECIALIST,
  "Specialist": Designation.SPECIALIST
});

enum Region { DAMMAM, JEDDAH, MADINAH, MAKKAH, RIYADH }

final regionValues = EnumValues({
  "Dammam": Region.DAMMAM,
  "Jeddah": Region.JEDDAH,
  "Madinah": Region.MADINAH,
  "Makkah": Region.MAKKAH,
  "Riyadh": Region.RIYADH
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
