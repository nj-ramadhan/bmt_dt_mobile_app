import 'package:flutter/material.dart';

import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/camera_id_screen.dart';
import 'screens/camera_photo_screen.dart';
import 'screens/home_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/deposit_screen.dart';
import 'screens/checking_screen.dart';
import 'screens/shopping_screen.dart';
import 'screens/funding_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/transfer_screen.dart';
import 'screens/take_picture_screen.dart';
import 'utils/common_widgets/invalid_route.dart';
import 'values/app_routes.dart';
import 'package:camera/camera.dart';

class Routes {
  const Routes._();

  static Route<dynamic> generateRoute(RouteSettings settings) {
    Route<dynamic> getRoute({
      required Widget widget,
      bool fullscreenDialog = false,
    }) {
      return MaterialPageRoute<void>(
        builder: (context) => widget,
        settings: settings,
        fullscreenDialog: fullscreenDialog,
      );
    }

    switch (settings.name) {
      case AppRoutes.login:
        return getRoute(widget: const LoginPage());

      case AppRoutes.register:
        return getRoute(widget: const RegisterPage());

      case AppRoutes.home:
        return getRoute(widget: const HomePage());

      case AppRoutes.menu:
        return getRoute(widget: const MenuPage());

      case AppRoutes.profile:
        return getRoute(widget: const ProfilePage());

      case AppRoutes.deposit:
        return getRoute(widget: const DepositPage());

      case AppRoutes.checking:
        return getRoute(widget: const CheckingPage());

      case AppRoutes.shopping:
        return getRoute(widget: const ShoppingPage());

      case AppRoutes.funding:
        return getRoute(widget: const FundingPage());

      case AppRoutes.payment:
        return getRoute(widget: const PaymentPage());

      case AppRoutes.transfer:
        return getRoute(widget: const TransferPage());

      // case AppRoutes.takepicture:
      //   return getRoute(widget: const TakePicturePage());

      /// An invalid route. User shouldn't see this,
      /// it's for debugging purpose only.
      default:
        return getRoute(widget: const InvalidRoute());
    }
  }
}
