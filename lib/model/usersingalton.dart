import 'package:Labas/model/clinic.dart';

class User {
  // singleton
  static final User _singleton = User._internal();
  factory User() => _singleton;
  User._internal();
  static User get userData => _singleton;
  int totalpages = 0;
  var departmentId;
  List<Clinic> searchClinics = List<Clinic>();
  var selectedInsurance;
  bool error;
  var selectedDepartment;
  var departmentName;
}
