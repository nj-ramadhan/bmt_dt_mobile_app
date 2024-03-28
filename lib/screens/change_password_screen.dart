import 'package:flutter/material.dart';

import '../components/app_text_form_field.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_colors.dart';
import '../values/app_constants.dart';
import '../values/app_regex.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final _formKey = GlobalKey<FormState>();

  // late final TextEditingController nameController;
  // late final TextEditingController phoneController;
  // late final TextEditingController idController;
  // late final DatePickerDialog birthDateController;
  // late final TextEditingController addressController;
  // late final TextEditingController motherNameController;
  // late final TextEditingController communityChoiceController;
  // late final TextEditingController emailController;

  late final TextEditingController passwordController;
  late final TextEditingController newPasswordController;
  late final TextEditingController confirmPasswordController;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> newPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);

  void initializeControllers() {
    // nameController = TextEditingController()..addListener(controllerListener);
    // phoneController = TextEditingController()..addListener(controllerListener);
    // idController = TextEditingController()..addListener(controllerListener);
    // birthDateController = DatePickerDialog(
    //     firstDate: DateTime(1900, 1, 1, 23, 59),
    //     lastDate: DateTime(2100, 1, 1, 23, 59));
    // addressController = TextEditingController()
    //   ..addListener(controllerListener);
    // motherNameController = TextEditingController()
    //   ..addListener(controllerListener);
    // communityChoiceController = TextEditingController()
    //   ..addListener(controllerListener);
    // emailController = TextEditingController()..addListener(controllerListener);

    passwordController = TextEditingController()
      ..addListener(controllerListener);
    newPasswordController = TextEditingController()
      ..addListener(controllerListener);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    // nameController.dispose();
    // phoneController.dispose();
    // idController.dispose();
    // birthDateController.toString();
    // addressController.dispose();
    // motherNameController.dispose();
    // communityChoiceController.dispose();
    // emailController.dispose();

    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  void controllerListener() {
    // final name = nameController.text;
    // final phone = phoneController.text;
    // final id = idController.text;
    // final address = addressController.text;
    // final mother = motherNameController.text;
    // final community = communityChoiceController.text;
    // final email = emailController.text;

    final password = passwordController.text;
    final newPassword = newPasswordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (
        // name.isEmpty && phone.isEmpty
        // id.isEmpty &&
        // address.isEmpty &&
        // mother.isEmpty &&
        // community.isEmpty &&
        // email.isEmpty &&
        password.isEmpty && newPassword.isEmpty && confirmPassword.isEmpty)
      return;

    if (
        // AppRegex.emailRegex.hasMatch(email) &&

        AppRegex.passwordRegex.hasMatch(password) &&
            AppRegex.passwordRegex.hasMatch(newPassword) &&
            AppRegex.passwordRegex.hasMatch(confirmPassword)) {
      fieldValidNotifier.value = true;
    } else {
      fieldValidNotifier.value = false;
    }
  }

  @override
  void initState() {
    initializeControllers();
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  // @override
  // String? get restorationId => widget.restorationId;

  // final RestorableDateTime _selectedDate =
  //     RestorableDateTime(DateTime(1990, 1, 1));
  // late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
  //     RestorableRouteFuture<DateTime?>(
  //   onComplete: _selectDate,
  //   onPresent: (NavigatorState navigator, Object? arguments) {
  //     return navigator.restorablePush(
  //       _datePickerRoute,
  //       arguments: _selectedDate.value.millisecondsSinceEpoch,
  //     );
  //   },
  // );

  // @pragma('vm:entry-point')
  // static Route<DateTime> _datePickerRoute(
  //   BuildContext context,
  //   Object? arguments,
  // ) {
  //   return DialogRoute<DateTime>(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return DatePickerDialog(
  //         restorationId: 'date_picker_dialog',
  //         initialEntryMode: DatePickerEntryMode.calendarOnly,
  //         initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
  //         firstDate: DateTime(1990),
  //         lastDate: DateTime(2100),
  //       );
  //     },
  //   );
  // }

  // @override
  // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
  //   registerForRestoration(_selectedDate, 'selected_date');
  //   registerForRestoration(
  //       _restorableDatePickerRouteFuture, 'date_picker_route_future');
  // }

  // void _selectDate(DateTime? newSelectedDate) {
  //   if (newSelectedDate != null) {
  //     setState(() {
  //       _selectedDate.value = newSelectedDate;
  //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
  //         content: Text(
  //             'Tanggal Lahir: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year} dipilih'),
  //       ));
  //     });
  //   }
  // }

  // String _selectDateOnly(DateTime? newSelectedDate) {
  //   String selectedDateOnly =
  //       '${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}';
  //   return selectedDateOnly;
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
        // image: DecorationImage(
        //     image: AssetImage('assets/images/background1.jpg'),
        //     fit: BoxFit.cover),
      ),
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.zero,
          children: [
            GradientBackground(
              colors: const [Colors.transparent, Colors.transparent],
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => NavigationHelper.pushReplacementNamed(
                        AppRoutes.profile,
                      ),
                    ),
                    const Text(
                      AppStrings.password,
                      style: AppTheme.titleLarge,
                    ),
                    Image(
                      image: const AssetImage('assets/icon/icon_text.png'),
                      width: screenWidth * 0.25,
                      fit: BoxFit.cover,
                      alignment: Alignment.topCenter,
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // AppTextFormField(
                    //   autofocus: true,
                    //   labelText: AppStrings.name,
                    //   keyboardType: TextInputType.name,
                    //   textInputAction: TextInputAction.next,
                    //   onChanged: (value) => _formKey.currentState?.validate(),
                    //   validator: (value) {
                    //     return value!.isEmpty
                    //         ? AppStrings.pleaseEnterName
                    //         : value.length < 4
                    //             ? AppStrings.invalidName
                    //             : null;
                    //   },
                    //   controller: nameController,
                    // ),
                    // AppTextFormField(
                    //   autofocus: true,
                    //   labelText: AppStrings.phone,
                    //   keyboardType: TextInputType.phone,
                    //   textInputAction: TextInputAction.next,
                    //   onChanged: (value) => _formKey.currentState?.validate(),
                    //   validator: (value) {
                    //     return value!.isEmpty
                    //         ? AppStrings.pleaseEnterPhone
                    //         : value.length < 11
                    //             ? AppStrings.invalidPhone
                    //             : null;
                    //   },
                    //   controller: phoneController,
                    // ),
                    // AppTextFormField(
                    //   autofocus: true,
                    //   labelText: AppStrings.id,
                    //   keyboardType: TextInputType.number,
                    //   textInputAction: TextInputAction.next,
                    //   onChanged: (value) => _formKey.currentState?.validate(),
                    //   validator: (value) {
                    //     return value!.isEmpty
                    //         ? AppStrings.pleaseEnterId
                    //         : value.length < 15
                    //             ? AppStrings.invalidId
                    //             : null;
                    //   },
                    //   controller: idController,
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                    // AppTextFormField(
                    //   autofocus: true,
                    //   labelText: AppStrings.address,
                    //   keyboardType: TextInputType.streetAddress,
                    //   textInputAction: TextInputAction.next,
                    //   onChanged: (value) => _formKey.currentState?.validate(),
                    //   validator: (value) {
                    //     return value!.isEmpty
                    //         ? AppStrings.pleaseEnterAddress
                    //         : value.length < 15
                    //             ? AppStrings.invalidAddress
                    //             : null;
                    //   },
                    //   controller: addressController,
                    // ),
                    // AppTextFormField(
                    //   autofocus: true,
                    //   labelText: AppStrings.motherName,
                    //   keyboardType: TextInputType.name,
                    //   textInputAction: TextInputAction.next,
                    //   onChanged: (value) => _formKey.currentState?.validate(),
                    //   validator: (value) {
                    //     return value!.isEmpty
                    //         ? AppStrings.pleaseEnterMotherName
                    //         : value.length < 15
                    //             ? AppStrings.invalidMotherName
                    //             : null;
                    //   },
                    //   controller: motherNameController,
                    // ),
                    // AppTextFormField(
                    //   autofocus: true,
                    //   labelText: AppStrings.community,
                    //   keyboardType: TextInputType.text,
                    //   textInputAction: TextInputAction.next,
                    //   onChanged: (value) => _formKey.currentState?.validate(),
                    //   validator: (value) {
                    //     return value!.isEmpty
                    //         ? AppStrings.pleaseEnterCommunity
                    //         : value.length < 15
                    //             ? AppStrings.invalidCommunity
                    //             : null;
                    //   },
                    //   controller: communityChoiceController,
                    // ),
                    // AppTextFormField(
                    //   labelText: AppStrings.email,
                    //   controller: emailController,
                    //   textInputAction: TextInputAction.next,
                    //   keyboardType: TextInputType.emailAddress,
                    //   onChanged: (_) => _formKey.currentState?.validate(),
                    //   validator: (value) {
                    //     return value!.isEmpty
                    //         ? AppStrings.pleaseEnterEmailAddress
                    //         : AppConstants.emailRegex.hasMatch(value)
                    //             ? null
                    //             : AppStrings.invalidEmailAddress;
                    //   },
                    // ),

                    ValueListenableBuilder<bool>(
                      valueListenable: passwordNotifier,
                      builder: (_, passwordObscure, __) {
                        return AppTextFormField(
                          obscureText: passwordObscure,
                          controller: passwordController,
                          labelText: AppStrings.password,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? null
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: Focus(
                            /// If false,
                            ///
                            /// disable focus for all of this node's descendants
                            descendantsAreFocusable: false,

                            /// If false,
                            ///
                            /// make this widget's descendants un-traversable.
                            // descendantsAreTraversable: false,
                            child: IconButton(
                              onPressed: () =>
                                  passwordNotifier.value = !passwordObscure,
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                passwordObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: newPasswordNotifier,
                      builder: (_, passwordObscure, __) {
                        return AppTextFormField(
                          obscureText: passwordObscure,
                          controller: newPasswordController,
                          labelText: AppStrings.newPassword,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? null
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: Focus(
                            /// If false,
                            ///
                            /// disable focus for all of this node's descendants
                            descendantsAreFocusable: false,

                            /// If false,
                            ///
                            /// make this widget's descendants un-traversable.
                            // descendantsAreTraversable: false,
                            child: IconButton(
                              onPressed: () =>
                                  newPasswordNotifier.value = !passwordObscure,
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                passwordObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: confirmPasswordNotifier,
                      builder: (_, confirmPasswordObscure, __) {
                        return AppTextFormField(
                          labelText: AppStrings.confirmPassword,
                          controller: confirmPasswordController,
                          obscureText: confirmPasswordObscure,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          onChanged: (_) => _formKey.currentState?.validate(),
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseReEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? passwordController.text ==
                                            confirmPasswordController.text
                                        ? null
                                        : AppStrings.passwordNotMatched
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: Focus(
                            /// If false,
                            ///
                            /// disable focus for all of this node's descendants.
                            descendantsAreFocusable: false,

                            /// If false,
                            ///
                            /// make this widget's descendants un-traversable.
                            // descendantsAreTraversable: false,
                            child: IconButton(
                              onPressed: () => confirmPasswordNotifier.value =
                                  !confirmPasswordObscure,
                              style: IconButton.styleFrom(
                                minimumSize: const Size.square(48),
                              ),
                              icon: Icon(
                                confirmPasswordObscure
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return FilledButton(
                          onPressed: isValid
                              ? () {
                                  SnackbarHelper.showSnackBar(
                                    AppStrings.registrationComplete,
                                  );
                                  // nameController.clear();
                                  // emailController.clear();
                                  passwordController.clear();
                                  confirmPasswordController.clear();
                                }
                              : null,
                          child: const Text(AppStrings.changePassword),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
