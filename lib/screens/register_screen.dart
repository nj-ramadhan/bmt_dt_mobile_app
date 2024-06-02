import 'package:flutter/material.dart';

import '../components/app_text_form_field.dart';
import '../components/app_drop_down_form_field.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/navigation_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_colors.dart';
import '../values/app_constants.dart';
import '../values/app_regex.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../components/dropdown_V2.dart';
import '../utils/helpers/api_helper.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.restorationId});
  final String? restorationId;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> with RestorationMixin {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController nameController;
  late final TextEditingController phoneController;
  late final TextEditingController idController;
  late final DatePickerDialog birthDateController;
  late final TextEditingController addressController;
  late final TextEditingController motherNameController;
  late final TextEditingController communityChoiceController;
  late final TextEditingController passwordController;
  late final TextEditingController emailController;
  late final TextEditingController birthPlaceController;
  late final TextEditingController RwController;
  late final TextEditingController RtController;
  late final TextEditingController ReligionController;
  late final TextEditingController confirmPasswordController;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  String? valueDownProvince = null;
  String? valueDownCity = null;
  String? valueDownDistrict = null;
  String? valueDownSubDistrict = null;
  String? valueDownGender = null;
  String? valueDownStatusPerkawinan = null;
  String? valueDownCitizenship = null;
  String valuebirthDate = "1999-02-01";
  final List<String> ListDownGender = ['L', 'P'];
  final List<String> ListDownStatusPerkawinan = [
    'BELUM KAWIN',
    'KAWIN',
    'CERAI HIDUP',
    'CERAI MATI'
  ];
  final List<String> ListDownCitizenship = ['WNI', 'WNA'];
  late Future<List<DropdownItemsModel>> _province; // Marked as 'late'
  late Future<List<DropdownItemsModel>> _futureCity;
  late Future<List<DropdownItemsModel>> _futureDistrict;
  late Future<List<DropdownItemsModel>> _futureSubDistrict;
  void initializeControllers() {
    nameController = TextEditingController()..addListener(controllerListener);
    phoneController = TextEditingController()..addListener(controllerListener);
    idController = TextEditingController()..addListener(controllerListener);
    birthDateController = DatePickerDialog(
        firstDate: DateTime(1900, 1, 1, 23, 59),
        lastDate: DateTime(2100, 1, 1, 23, 59));
    addressController = TextEditingController()
      ..addListener(controllerListener);
    motherNameController = TextEditingController()
      ..addListener(controllerListener);
    communityChoiceController = TextEditingController()
      ..addListener(controllerListener);
    emailController = TextEditingController()..addListener(controllerListener);
    birthPlaceController = TextEditingController()
      ..addListener(controllerListener);
    RwController = TextEditingController()..addListener(controllerListener);
    RtController = TextEditingController()..addListener(controllerListener);
    ReligionController = TextEditingController()
      ..addListener(controllerListener);
    passwordController = TextEditingController()
      ..addListener(controllerListener);
    confirmPasswordController = TextEditingController()
      ..addListener(controllerListener);
  }

  void disposeControllers() {
    nameController.dispose();
    phoneController.dispose();
    idController.dispose();
    birthDateController.toString();
    addressController.dispose();
    motherNameController.dispose();
    communityChoiceController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    birthPlaceController.dispose();
    RwController.dispose();
    RtController.dispose();
    ReligionController.dispose();
  }

  void controllerListener() {
    final name = nameController.text;
    final phone = phoneController.text;
    final id = idController.text;
    final address = addressController.text;
    final mother = motherNameController.text;
    final community = communityChoiceController.text;
    final email = emailController.text;
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    final birthPlace = birthPlaceController.text;
    final rw = RwController.text;
    final rt = RtController.text;
    final religion = ReligionController.text;

    if (name.isEmpty &&
        phone.isEmpty &&
        id.isEmpty &&
        address.isEmpty &&
        mother.isEmpty &&
        community.isEmpty &&
        email.isEmpty &&
        password.isEmpty &&
        birthPlace.isEmpty &&
        rw.isEmpty &&
        rt.isEmpty &&
        religion.isEmpty &&
        confirmPassword.isEmpty) return;

    if (AppRegex.emailRegex.hasMatch(email) &&
        AppRegex.passwordRegex.hasMatch(password) &&
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
    _province = ApiHelper.getProvince();
    _futureCity = ApiHelper.getCity(address: "12");
    _futureDistrict = ApiHelper.getDistrict(address: "1204");
    _futureSubDistrict = ApiHelper.getSubDistrict(address: "1204010");
  }

  @override
  void dispose() {
    disposeControllers();
    super.dispose();
  }

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(1990, 1, 1));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @pragma('vm:entry-point')
  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(1990),
          lastDate: DateTime(2100),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Tanggal Lahir: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year} dipilih'),
        ));
      });
    }
  }

  String _selectDateOnly(DateTime? newSelectedDate) {
    String selectedDateOnly =
        '${_selectedDate.value.year}-${_selectedDate.value.month}-${_selectedDate.value.day}';
    return selectedDateOnly;
  }

  String _getMonthName(int month) {
    const List<String> monthNames = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];
    return monthNames[month - 1];
  }

  String _showDateOnly(DateTime? newSelectedDate) {
    String selectedDateOnly =
        '${_selectedDate.value.day} ${_getMonthName(_selectedDate.value.month)} ${_selectedDate.value.year}';
    return selectedDateOnly;
  }

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
          padding: EdgeInsets.fromLTRB(0, screenHeight * 0.01, 0, 0),
          children: [
            GradientBackground(
              colors: const [Colors.transparent, Colors.transparent],
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      AppStrings.registerTitle,
                      style: AppTheme.titleLarge,
                    ),
                    Image.network(
                      apiDataAppLogoBar,
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
                    AppTextFormField(
                      autofocus: true,
                      labelText: AppStrings.id,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      // onChanged: (value) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterId
                            : value.length < 15
                                ? AppStrings.invalidId
                                : null;
                      },
                      controller: idController,
                    ),
                    AppTextFormField(
                      autofocus: true,
                      labelText: AppStrings.name,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      // onChanged: (value) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterName
                            : value.length < 4
                                ? AppStrings.invalidName
                                : null;
                      },
                      controller: nameController,
                    ),
                    AppTextFormField(
                      autofocus: true,
                      labelText: AppStrings.phone,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      // onChanged: (value) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterPhone
                            : value.length < 11
                                ? AppStrings.invalidPhone
                                : null;
                      },
                      controller: phoneController,
                    ),
                    AppTextFormField(
                      labelText: AppStrings.email,
                      controller: emailController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      // onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterEmailAddress
                            : AppConstants.emailRegex.hasMatch(value)
                                ? null
                                : AppStrings.invalidEmailAddress;
                      },
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: passwordNotifier,
                      builder: (_, passwordObscure, __) {
                        return AppTextFormField(
                          obscureText: passwordObscure,
                          controller: passwordController,
                          labelText: AppStrings.password,
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.visiblePassword,
                          // onChanged: (_) => _formKey.currentState?.validate(),
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
                    ValueListenableBuilder(
                      valueListenable: confirmPasswordNotifier,
                      builder: (_, confirmPasswordObscure, __) {
                        return AppTextFormField(
                          labelText: AppStrings.confirmPassword,
                          controller: confirmPasswordController,
                          obscureText: confirmPasswordObscure,
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.visiblePassword,
                          // onChanged: (_) => _formKey.currentState?.validate(),
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
                    AppDropdownList(
                      labelText: 'Kelamin',
                      items: ListDownGender,
                      value: valueDownGender,
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownGender = value;
                        });
                      },
                    ),
                    const Text(AppStrings.pleasePickbirthDate),
                    FilledButton(
                      onPressed: () {
                        _restorableDatePickerRouteFuture.present();
                        valuebirthDate = _selectDateOnly(_selectedDate.value);
                      },
                      child: Text(_showDateOnly(_selectedDate.value)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    AppTextFormField(
                      labelText: "Tempat Lahir",
                      controller: birthPlaceController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      // onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? "Tolong Masukan Tempat Lahir"
                            : value.length < 4
                                ? AppStrings.invalidName
                                : null;
                      },
                    ),
                    AppDropdownFormField(
                      future: _province,
                      labelText: 'Provinsi',
                      value: valueDownProvince,
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownCity = null;
                          valueDownDistrict = null;
                          valueDownSubDistrict = null;
                          valueDownProvince = value;
                          _futureCity = ApiHelper.getCity(
                              address: valueDownProvince.toString());
                        });
                      },
                    ),
                    AppDropdownFormField(
                      future: _futureCity,
                      labelText: 'Kabupaten / Kota',
                      value: valueDownCity,
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownDistrict = null;
                          valueDownSubDistrict = null;
                          valueDownCity = value;
                          _futureDistrict = ApiHelper.getDistrict(
                              address: valueDownCity.toString());
                        });
                      },
                    ),
                    AppDropdownFormField(
                      future: _futureDistrict,
                      labelText: 'Kecamatan',
                      value: valueDownDistrict,
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownSubDistrict = null;
                          valueDownDistrict = value;
                          _futureSubDistrict = ApiHelper.getSubDistrict(
                              address: valueDownDistrict.toString());
                        });
                      },
                    ),
                    AppDropdownFormField(
                      future: _futureSubDistrict,
                      labelText: 'Kelurahan',
                      value: valueDownSubDistrict,
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownSubDistrict = value;
                        });
                      },
                    ),
                    AppDropdownList(
                      labelText: 'Status Perkawinan',
                      items: ListDownStatusPerkawinan,
                      value: valueDownStatusPerkawinan,
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownStatusPerkawinan = value;
                        });
                      },
                    ),
                    AppDropdownList(
                      labelText: 'Kewarganegaraan',
                      items: ListDownCitizenship,
                      value: valueDownCitizenship,
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownCitizenship = value;
                        });
                      },
                    ),
                    AppTextFormField(
                      labelText: "RW",
                      controller: RwController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      // onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? "Masukan No RW"
                            : value.length < 0
                                ? AppStrings.invalidName
                                : null;
                      },
                    ),
                    AppTextFormField(
                      labelText: "RT",
                      controller: RtController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      // onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? "Masukan No RT"
                            : value.length < 0
                                ? AppStrings.invalidName
                                : null;
                      },
                    ),
                    AppTextFormField(
                      labelText: "Agama",
                      controller: ReligionController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      // onChanged: (_) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? "masukan Agama"
                            : value.length < 0
                                ? AppStrings.invalidName
                                : null;
                      },
                    ),
                    AppTextFormField(
                      autofocus: true,
                      labelText: AppStrings.address,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      // onChanged: (value) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterAddress
                            : value.length < 15
                                ? AppStrings.invalidAddress
                                : null;
                      },
                      controller: addressController,
                    ),
                    AppTextFormField(
                      autofocus: true,
                      labelText: AppStrings.motherName,
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.next,
                      // onChanged: (value) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterMotherName
                            : value.length < 3
                                ? AppStrings.invalidMotherName
                                : null;
                      },
                      controller: motherNameController,
                    ),
                    AppTextFormField(
                      autofocus: true,
                      labelText: "Pekerjaan",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      // onChanged: (value) => _formKey.currentState?.validate(),
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterCommunity
                            : value.length < 15
                                ? AppStrings.invalidCommunity
                                : null;
                      },
                      controller: communityChoiceController,
                    ),
                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return FilledButton(
                          onPressed: true
                              ? () async {
                                  valuebirthDate =
                                      _selectDateOnly(_selectedDate.value);
                                  if (_formKey.currentState != null &&
                                      _formKey.currentState!.validate()) {
                                    
                                    final Map<String, dynamic> responRegister =
                                        await ApiHelper.APIRegister(
                                      nik: idController.text,
                                      nama_lengkap: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      telepon: phoneController.text,
                                      jenis_kelamin: valueDownGender.toString(),
                                      tanggal_lahir: valuebirthDate,
                                      address: "x",
                                      tempat_lahir: birthPlaceController.text,
                                      provinsi: valueDownProvince.toString(),
                                      kabupaten_kota: valueDownCity.toString(),
                                      kecamatan: valueDownDistrict.toString(),
                                      kelurahan:
                                          valueDownSubDistrict.toString(),
                                      rw: RwController.text,
                                      rt: RtController.text,
                                      agama: ReligionController.text,
                                      status_perkawinan:
                                          valueDownStatusPerkawinan.toString(),
                                      pekerjaan: communityChoiceController.text,
                                      kewarganegaraan:
                                          valueDownCitizenship.toString(),
                                    );
                                    print(responRegister['status'].toString());
                                    if (responRegister['status'].toString() ==
                                        "berhasil") {
                                      NavigationHelper.pushReplacementNamed(
                                        AppRoutes.registeration_success,
                                      );
                                    }
                                    // nameController.clear();
                                    // emailController.clear();
                                    // passwordController.clear();
                                    // confirmPasswordController.clear();
                                    SnackbarHelper.showSnackBar(
                                      AppStrings.registrationComplete,
                                    );
                                  }
                                }
                              : null,
                          child: const Text(AppStrings.register),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.iHaveAnAccount,
                  style: AppTheme.bodySmall.copyWith(color: Colors.black),
                ),
                TextButton(
                  onPressed: () => NavigationHelper.pushReplacementNamed(
                    AppRoutes.login,
                  ),
                  child: const Text(AppStrings.login),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
