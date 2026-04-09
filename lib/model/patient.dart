class Patient {
  final UserResult result;

  Patient({
    this.result,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      result: UserResult.fromJson(json),
    );
  }
}

class UserResult {
  var id;
  String name;
  String mobileNo;
  int gender;
  String address;
  String age;
  UserResult({
    this.id,
    this.name,
    this.mobileNo,
    this.gender,
    this.address,
    this.age,
  });

  factory UserResult.fromJson(Map<String, dynamic> json) {
    return UserResult(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      mobileNo: json['mobile'] ?? "",
      gender: json['gender'] ?? 0,
      address: json['address'] ?? "",
      age: json['age'] ?? "",
    );
  }
}