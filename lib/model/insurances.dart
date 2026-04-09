import 'package:Labas/model/insurance.dart';

class Insurances {
  var id;
  var clinicId;
  var insuranceId;
  Insurance insurance;
  Insurances({
    this.id,
    this.clinicId,
    this.insuranceId,
    this.insurance,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'clinic_id': clinicId,
      'insurance_id': insuranceId,
      'insurance': insurance != null ? insurance.toMap() : {},
    };
  }

  factory Insurances.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Insurances(
      id: map['id'],
      clinicId: map['clinic_id'],
      insuranceId: map['insurance_id'],
      insurance: Insurance.fromMap(
        map['insurance'] ?? {},
      ),
    );
  }
}
