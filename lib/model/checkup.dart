class CheckUp {
  String doctorName;
  String departmentName;
  int doctorId;
  int patientId;
  String doctorImage;
  CheckUp({
    this.doctorName,
    this.departmentName,
    this.doctorId,
    this.patientId,
    this.doctorImage,
  });

  Map<String, dynamic> toMap() {
    return {
      'doctor_name': doctorName,
      'department_name': departmentName,
      'doctor_id': doctorId,
      'patient_id': patientId,
      'doctor_image': doctorImage,
    };
  }

  factory CheckUp.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CheckUp(
      doctorName: map['doctor_name'],
      departmentName: map['department_name'],
      doctorId: map['doctor_id'],
      patientId: map['patient_id'],
      doctorImage: map['doctor_image'],
    );
  }
}
