import 'package:flutter/material.dart';

import '../components/app_drop_down_form_field.dart';
import '../components/app_drop_down_items.dart';
import '../components/app_text_form_field.dart';
import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../utils/helpers/snackbar_helper.dart';
import '../values/app_colors.dart';
import '../values/app_constants.dart';
import '../values/app_regex.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';
import '../components/base_layout.dart';

class RegisterPage extends StatefulWidget {
  final String? originPage; // Add this line to receive the origin page
  final String? restorationId;

  const RegisterPage({super.key, this.restorationId, this.originPage}); // Update constructor

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
  late final TextEditingController rwController;
  late final TextEditingController rtController;
  late final TextEditingController religionController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController referalController;

  final ValueNotifier<bool> passwordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> confirmPasswordNotifier = ValueNotifier(true);
  final ValueNotifier<bool> fieldValidNotifier = ValueNotifier(false);
  String? valueDownCommunity;
  String? valueDownReligion;
  String? valueDownProvince;
  String? valueDownCity;
  String? valueDownDistrict;
  String? valueDownSubDistrict;
  String? valueDownGender;
  String? valueDownStatusPerkawinan;
  String? valueDownCitizenship;
  String valuebirthDate = '1999-02-01';
  final List<String> listDownGender = ['L', 'P'];
  final List<String> listDownStatusPerkawinan = [
    'BELUM KAWIN',
    'KAWIN',
    'CERAI HIDUP',
    'CERAI MATI'
  ];
  final List<String> listDownReligion = [
    "Islam",
    "Kristen Protestan",
    "Kristen Katolik",
    "Hindu",
    "Buddha",
    "Konghucu",
  ];
  final List<String> listDownPekerjaan = [
    'PNS',
    'Pegawai Swasta',
    'TNI/POLRI',
    'Ibu Rumah Tangga',
    'Wiraswasta',
    'Pelajar/Mahasiswa',
    'Pensiunan',
    'Akunting/Keuangan',
    'Customer Service',
    'Engineering',
    'Eksekutif',
    'Administrasi umum',
    'Komputer',
    'Konsultan',
    'Marketing',
    'Pendidikan',
    'Petani',
    'Lain-Lain'
  ];
  final List<String> listDownCitizenship = ['WNI', 'WNA'];
  late Future<List<DropdownItemsModel>> _province;
  late Future<List<DropdownItemsModel>> _futureCity;
  late Future<List<DropdownItemsModel>> _futureDistrict;
  late Future<List<DropdownItemsModel>> _futureSubDistrict;

  void initializeControllers() {
    nameController = TextEditingController()..addListener(controllerListener);
    phoneController = TextEditingController()..addListener(controllerListener);
    idController = TextEditingController()..addListener(controllerListener);
    referalController = TextEditingController()..addListener(controllerListener);
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
    rwController = TextEditingController()..addListener(controllerListener);
    rtController = TextEditingController()..addListener(controllerListener);
    religionController = TextEditingController()
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
    rwController.dispose();
    rtController.dispose();
    religionController.dispose();
    referalController.dispose();
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
    final rw = rwController.text;
    final rt = rtController.text;
    final religion = religionController.text;
    final referal = referalController.text;

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
        referal.isEmpty &&
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
    _futureCity = ApiHelper.getCity(address: '12');
    _futureDistrict = ApiHelper.getDistrict(address: '1204');
    _futureSubDistrict = ApiHelper.getSubDistrict(address: '1204010');
    String? pageorigin = widget.originPage;
    print("----------------------------");
    print("data page origin $pageorigin");
    // Pre-fill referral field based on origin
    if (widget.originPage == 'home') {
      
      referalController.text = apiDataAccountTelepon; // Assuming the phone number is available
    }
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
          firstDate: DateTime(1940),
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

  void _onBackButtonPressed() {
    if (widget.originPage == 'home') {
      Navigator.of(context).popUntil((route) => route.isFirst);
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
        color: AppColors.lightGreen,
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
                          validator: (value) {
                            return value!.isEmpty
                                ? AppStrings.pleaseEnterPassword
                                : AppConstants.passwordRegex.hasMatch(value)
                                    ? null
                                    : AppStrings.invalidPassword;
                          },
                          suffixIcon: Focus(
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
                      items: listDownGender,
                      value: valueDownGender,
                      hint: "Pilih Jenis Kelamin",
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownGender = value;
                        });
                      },
                    ),
                    const Text(AppStrings.pleasePickBirthDate),
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
                      labelText: 'Tempat Lahir',
                      controller: birthPlaceController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.name,
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Tolong Masukan Tempat Lahir'
                            : value.length < 4
                                ? AppStrings.invalidName
                                : null;
                      },
                    ),
                    AppDropdownFormField(
                      future: _province,
                      labelText: 'Provinsi',
                      value: valueDownProvince,
                      hint: "Pilih Provinsi",
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
                      hint: "Pilih Kabupaten / Kota",
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
                      hint: "Pilih Kecamatan",
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
                      hint: "Pilih Kelurahan",
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
                      items: listDownStatusPerkawinan,
                      hint: "Pilih Status Perkawinan",
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
                      items: listDownCitizenship,
                      value: valueDownCitizenship,
                      hint: "Pilih Kewarganegaraan",
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownCitizenship = value;
                        });
                      },
                    ),
                    AppTextFormField(
                      labelText: 'RW',
                      controller: rwController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Masukan No RW'
                            : value.length < 0
                                ? AppStrings.invalidName
                                : null;
                      },
                    ),
                    AppTextFormField(
                      labelText: 'RT',
                      controller: rtController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        return value!.isEmpty
                            ? 'Masukan No RT'
                            : value.length < 0
                                ? AppStrings.invalidName
                                : null;
                      },
                    ),
                    AppDropdownList(
                      labelText: 'Agama',
                      items: listDownReligion,
                      value: valueDownReligion,
                      hint: "Pilih Agama",
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownReligion = value;
                        });
                      },
                    ),
                    AppTextFormField(
                      autofocus: true,
                      labelText: AppStrings.address,
                      keyboardType: TextInputType.streetAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterAddress
                            : value.length < 4
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
                      validator: (value) {
                        return value!.isEmpty
                            ? AppStrings.pleaseEnterMotherName
                            : value.length < 3
                                ? AppStrings.invalidMotherName
                                : null;
                      },
                      controller: motherNameController,
                    ),
                    AppDropdownList(
                      labelText: 'Pekerjaan',
                      items: listDownPekerjaan,
                      value: valueDownCommunity,
                      hint: "Pilih Pekerjaan",
                      dropdownColor: Colors.blue[100],
                      onChanged: (value) {
                        setState(() {
                          valueDownCommunity = value;
                        });
                      },
                    ),
                    AppTextFormField(
                      labelText: 'No Referal',
                      controller: referalController,
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                    ),
                    ValueListenableBuilder(
                      valueListenable: fieldValidNotifier,
                      builder: (_, isValid, __) {
                        return FilledButton(
                          onPressed: isValid
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
                                      referral_id: referalController.text,
                                      telepon: phoneController.text,
                                      jenis_kelamin: valueDownGender.toString(),
                                      tanggal_lahir: valuebirthDate,
                                      address: 'x',
                                      tempat_lahir: birthPlaceController.text,
                                      provinsi: valueDownProvince.toString(),
                                      kabupaten_kota: valueDownCity.toString(),
                                      kecamatan: valueDownDistrict.toString(),
                                      kelurahan:
                                          valueDownSubDistrict.toString(),
                                      rw: rwController.text,
                                      rt: rtController.text,
                                      agama: valueDownReligion.toString(),
                                      status_perkawinan:
                                          valueDownStatusPerkawinan.toString(),
                                      pekerjaan: valueDownCommunity.toString(),
                                      kewarganegaraan:
                                          valueDownCitizenship.toString(),
                                    );
                                    print(responRegister['status'].toString());
                                    if (responRegister['status'].toString() ==
                                        'berhasil') {
                                      NavigationHelper.pushNamed(
                                        AppRoutes.registeration_success,
                                        arguments: widget.originPage,
                                      );
                                    }
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
                  onPressed: _onBackButtonPressed,
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
