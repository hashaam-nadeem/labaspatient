class AppointmentDetail {
  int id;
  String appointmentDate;
  String startTime;
  String endTime;
  int patientAvailability;
  String clinicName;
  double clinicLat;
  double clinicLong;
  String doctorName;
  String doctorSpecialization;
  String doctorImage;
  int doctorId;
  int clinicId;
  int rating;
  var clinicArabic;
  var doctorArabic;
  AppointmentDetail(
      {this.id,
      this.appointmentDate,
      this.startTime,
      this.endTime,
      this.clinicArabic,
      this.doctorArabic,
      this.patientAvailability,
      this.clinicName,
      this.clinicLat,
      this.clinicLong,
      this.doctorName,
      this.doctorSpecialization,
      this.doctorImage,
      this.doctorId,
      this.clinicId,
      this.rating});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'appointment_date': appointmentDate,
      'start_time': startTime,
      'end_time': endTime,
      'patient_availability': patientAvailability,
      'clinic_name': clinicName,
      'clinic_lat': clinicLat,
      'clinic_long': clinicLong,
      'doctor_name': doctorName,
      'doctor_specialization': doctorSpecialization,
      'doctor_image': doctorImage,
      'doctor_id': doctorId,
      'clinic_id': clinicId,
      'raiting': rating,
      'c_arabic_name': clinicArabic,
      'd_arabic_name': doctorArabic,
    };
  }

  factory AppointmentDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AppointmentDetail(
      id: map['id'],
      appointmentDate: map['appointment_date'],
      startTime: map['start_time'],
      endTime: map['end_time'],
      patientAvailability: map['patient_availability'],
      clinicName: map['clinic_name'],
      clinicLat: map['clinic_lat'],
      clinicLong: map['clinic_long'],
      doctorName: map['doctor_name'],
      doctorSpecialization: map['doctor_specialization'],
      doctorImage: map['doctor_image'],
      doctorId: map['doctor_id'],
      clinicId: map['clinic_id'],
      doctorArabic: map['d_arabic_name'],
      clinicArabic: map['c_arabic_name'],
      rating: map['raiting'] ?? 0,
    );
  }
}
