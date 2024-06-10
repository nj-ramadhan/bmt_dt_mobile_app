import 'package:flutter/material.dart';

import 'screens/add_client_screen.dart';

import 'screens/add_client_dif_bank_screen.dart';

import 'screens/change_email_screen.dart';
import 'screens/change_password_screen.dart';
import 'screens/change_pin_screen.dart';
import 'screens/checking_screen.dart';
import 'screens/deposit_screen.dart';
import 'screens/funding_screen.dart';
import 'screens/home_screen.dart';

import 'screens/input_account_dif_bank_screen.dart';
import 'screens/input_account_screen.dart';
import 'screens/input_amount_screen.dart';
import 'screens/input_amount_dif_bank_screen.dart';

import 'screens/login_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/profile_detail_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/register_screen.dart';
import 'screens/registration_success_screen.dart';
import 'screens/saving_mandatory_screen.dart';
import 'screens/saving_principal_screen.dart';
import 'screens/saving_voluntary_screen.dart';
import 'screens/shopping_confirm_screen.dart';
import 'screens/shopping_provider_list_screen.dart';
import 'screens/shopping_screen.dart';
import 'screens/transaction_detail_screen.dart';

import 'screens/transaction_detail_dif_bank_screen.dart';
import 'screens/transfer_metode_screen.dart';

import 'screens/transfer_screen.dart';
import 'screens/transfer_success_screen.dart';
import 'utils/common_widgets/invalid_route.dart';
import 'values/app_routes.dart';

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

      case AppRoutes.registeration_success:
        return getRoute(widget: const RegistrationSuccessPage());

      case AppRoutes.home:
        return getRoute(widget: Builder(
          builder: (context) {
            return const HomePage();
          },
        ));

      case AppRoutes.menu:
        return getRoute(widget: const MenuPage());

      case AppRoutes.profile:
        return getRoute(widget: const ProfilePage());

      case AppRoutes.profile_detail:
        return getRoute(widget: const ProfileDetailPage());

      case AppRoutes.change_password:
        return getRoute(widget: const ChangePasswordPage());

      case AppRoutes.change_email:
        return getRoute(widget: const ChangeEmailPage());

      case AppRoutes.change_pin:
        return getRoute(widget: const ChangePinPage());

      case AppRoutes.deposit:
        return getRoute(widget: const DepositPage());

      case AppRoutes.transaction_detail:
        return getRoute(widget: const TransactionDetailPage());

      case AppRoutes.transaction_detail_dif_Bank:
        return getRoute(widget: const TransactionDetailDifBankPage());

      case AppRoutes.transaction_sucess:
        return getRoute(widget: const TransferSuccessPage());

      case AppRoutes.add_client:
        return getRoute(widget: const AddClientPage());

      case AppRoutes.transfer_metode:
        return getRoute(widget: const TransferMetodePage());

      case AppRoutes.add_client_dif_bank:
        return getRoute(widget: const AddClientDifBankPage());

      case AppRoutes.input_account:
        return getRoute(widget: const InputAccountPage());

      case AppRoutes.input_account_dif_bank:
        return getRoute(widget: const InputAccountDifBankPage());

      case AppRoutes.input_amount:
        return getRoute(widget: const InputAmountPage());

      case AppRoutes.input_amount_dif_bank:
        return getRoute(widget: const InputAmountDifBankPage());

      case AppRoutes.checking:
        return getRoute(widget: const CheckingPage());

      case AppRoutes.shopping:
        return getRoute(widget: const ShoppingPage());

      case AppRoutes.shopping_provider_list:
        return getRoute(widget: const ShoppingProviderListPage());

      case AppRoutes.shopping_confirm:
        return getRoute(widget: const ShoppingConfirmPage());

      case AppRoutes.funding:
        return getRoute(widget: const FundingPage());

      case AppRoutes.payment:
        return getRoute(widget: const PaymentPage());

      case AppRoutes.transfer:
        return getRoute(widget: const TransferPage());

      case AppRoutes.saving_mandatory:
        return getRoute(widget: const SavingMandatoryPage());

      case AppRoutes.saving_principal:
        return getRoute(widget: const SavingPrincipalPage());

      case AppRoutes.saving_voluntary:
        return getRoute(widget: const SavingVoluntaryPage());

      default:
        return getRoute(widget: const InvalidRoute());
    }
  }
}
