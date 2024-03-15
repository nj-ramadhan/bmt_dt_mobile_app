class AppRegex {
  const AppRegex._();

  static final RegExp emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.([a-zA-Z]{2,})+",
  );

  static final RegExp phoneRegex = RegExp(
    r'^(\d{11,})',
  );

  static final RegExp passwordRegex = RegExp(
    // r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$#!%*?&_])[A-Za-z\d@#$!%*?&_].{7,}$',
    r'^(?=.*[a-z])(?=.*\d)[A-Za-z\d@#$!%*?&_].{7,}$',
  );
}
