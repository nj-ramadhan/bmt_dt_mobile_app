import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'login_register_app.dart';

void main() {//cek commit
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
    (_) => runApp(const LoginRegisterApp()),
  );
}
