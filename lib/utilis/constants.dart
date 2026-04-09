class APINetwork {
  static const String BASE_URL = "https://labasonline.com";
  static const String LOGIN_URL = "/api/patient/login";
  static const String REGISTER_MOBILE = "/api/patient/otp";
  static const String VERIFY_OTPCODE_REGISTERATION ="/api/patient/resgistration/verify/otp";
  static const String SET_PASSWORD_REGISTERATION = "/api/patient/registration";
  static const String RESET_PASSWORD_REQUEST_MOBILE_NO ="/api/patient/password/reset/request";
  static const String VERIFY_OTPCODE_RESET_PASSWORD =
      "/api/patient/password/reset/verify/otp";
  static const String RESET_PASSWORD = "/api/patient/password/reset";
  static const String CHANGE_PASSWORD = "/api/patient/change/password";
  static const String UPDATE_PROFILE = "/api/patient/change/profile";
  static const String GET_PROFILE = "/api/patient/profile";
  static const String GET_DEPARTMENTS = "/api/departments";
  static const String GET_CLINICS = "/api/department/clinics";
  static const String GET_DOCTORS = "/api/clinic/doctors";
  static const String GET_APPOINTMENT_SLOTS = "/api/patient/doctor/time/slot";
  static const String BOOK_APPOINTMENT = "/api/patient/appointment";
  static const String GET_ALL_CLINICS = "/api/clinics";
  static const String QUICK_APPOINTMENT = "/api/quick/appointment";
  static const String APPOINTMENT_HISTORY = "/api/patient/appointments";
  static const String APPOINTMENT_RATINGS = "/api/patient/raiting";
  static const String SEARCH = "/api/search";
  static const String CHECKUP_LIST = "/api/patient/doctor/checkup";
  static const String IMAGE_SLIDER = "/api/slider";
  static const String CANCEL_APPOINTMENT = "/api/patient/cancel/appointment";
  static const String GET_INSURANCES = "/api/patient/insurances";
}
