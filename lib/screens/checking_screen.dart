import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
import '../utils/helpers/api_helper.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_colors.dart';
import '../values/app_routes.dart';
import '../values/app_strings.dart';
import '../values/app_theme.dart';

class CheckingPage extends StatefulWidget {
  const CheckingPage({super.key, this.restorationId});
  final String? restorationId;
  // const CheckingPage({super.key});

  @override
  State<CheckingPage> createState() => _CheckingPageState();
}

class _CheckingPageState extends State<CheckingPage> with RestorationMixin {
  Map<int, Map<String, String>> dataTransaction = {};
  late DatePickerDialog beginDateController;
  late DatePickerDialog endDateController;
  String valueDateBegin = DateTime.now().toString();
  String valueDateFinish = DateTime.now().toString();

  String indonesianCurrencyFormat(String data) {
    int dataInt = int.parse(data);
    var dataFormatted =
        NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ', decimalDigits: 0)
            .format(dataInt);
    return dataFormatted.toString();
  }

  Future<void> fetchCheckingHistory() async {
    final data = await ApiHelper.getListTransaction(
        loginToken: apiLoginToken,
        dateBegin: valueDateBegin,
        dateFinish: valueDateFinish);
    debugPrint('date begin: $valueDateBegin, date finish: $valueDateFinish');

    setState(() {
      dataTransaction = data;
      debugPrint('response list data transaksi: $dataTransaction');
    });
  }

  void initializeControllers() {
    beginDateController = DatePickerDialog(
        firstDate: DateTime(2024, 1, 1, 23, 59),
        lastDate: DateTime(2100, 1, 1, 23, 59));

    endDateController = DatePickerDialog(
        firstDate: DateTime(2024, 1, 1, 23, 59),
        lastDate: DateTime(2100, 1, 1, 23, 59));
  }

  void disposeControllers() {
    beginDateController.toString();
    endDateController.toString();
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

  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedBeginDate =
      RestorableDateTime(DateTime.now());
  final RestorableDateTime _selectedEndDate =
      RestorableDateTime(DateTime.now());

  late final RestorableRouteFuture<DateTime?>
      _restorableBeginDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
    onComplete: _selectBeginDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedBeginDate.value.millisecondsSinceEpoch,
      );
    },
  );

  late final RestorableRouteFuture<DateTime?>
      _restorableEndDatePickerRouteFuture = RestorableRouteFuture<DateTime?>(
    onComplete: _selectEndDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedEndDate.value.millisecondsSinceEpoch,
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
          firstDate: DateTime(2024),
          lastDate: DateTime(2100),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedBeginDate, 'selected_date');
    registerForRestoration(_selectedEndDate, 'selected_date');
    registerForRestoration(
        _restorableBeginDatePickerRouteFuture, 'date_picker_route_future');
    registerForRestoration(
        _restorableEndDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectBeginDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedBeginDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Tanggal Awal: ${_selectedBeginDate.value.day}/${_selectedBeginDate.value.month}/${_selectedBeginDate.value.year} dipilih'),
        ));
      });
    }
  }

  void _selectEndDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedEndDate.value = newSelectedDate;
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Tanggal Akhir: ${_selectedEndDate.value.day}/${_selectedEndDate.value.month}/${_selectedEndDate.value.year} dipilih'),
        ));
      });
    }
  }

  String _selectBeginDateOnly(DateTime? newSelectedDate) {
    final selectedDateOnly =
        '${_selectedBeginDate.value.year}-${_selectedBeginDate.value.month}-${_selectedBeginDate.value.day}';
    return selectedDateOnly;
  }

  String _selectEndDateOnly(DateTime? newSelectedDate) {
    final selectedDateOnly =
        '${_selectedEndDate.value.year}-${_selectedEndDate.value.month}-${_selectedEndDate.value.day}';
    return selectedDateOnly;
  }

  String _getMonthName(int month) {
    const monthNames = <String>[
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

  String _showBeginDateOnly(DateTime? newSelectedDate) {
    final selectedDateOnly =
        '${_selectedBeginDate.value.day} ${_getMonthName(_selectedBeginDate.value.month)} ${_selectedBeginDate.value.year}';
    return selectedDateOnly;
  }

  String _showEndDateOnly(DateTime? newSelectedDate) {
    final selectedDateOnly =
        '${_selectedEndDate.value.day} ${_getMonthName(_selectedEndDate.value.month)} ${_selectedEndDate.value.year}';
    return selectedDateOnly;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
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
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => NavigationHelper.pushNamed(
                        AppRoutes.home,
                      ),
                    ),
                    const Text(
                      AppStrings.checkingTitle,
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: AppColors.lightGreen,
                      child: SizedBox(
                        height: 220,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () {
                                        _restorableBeginDatePickerRouteFuture
                                            .present();
                                        valueDateBegin = _selectBeginDateOnly(
                                          _selectedBeginDate.value,
                                        );
                                      },
                                      child: Text(
                                        _showBeginDateOnly(
                                            _selectedBeginDate.value),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Material(
                                    color: AppColors.darkGreen,
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(Icons.calendar_month,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    child: FilledButton(
                                      onPressed: () {
                                        _restorableEndDatePickerRouteFuture
                                            .present();
                                        valueDateFinish = _selectEndDateOnly(
                                          _selectedEndDate.value,
                                        );
                                      },
                                      child: Text(
                                        _showEndDateOnly(
                                            _selectedEndDate.value),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Material(
                                    color: AppColors.darkGreen,
                                    shape: CircleBorder(),
                                    child: Padding(
                                      padding: EdgeInsets.all(15),
                                      child: Icon(Icons.calendar_month,
                                          color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              child: FilledButton(
                                onPressed: fetchCheckingHistory,
                                child: const Text(AppStrings.checkingProcees),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * 0.02,
                    ),
                    Column(
                      children: [
                        // dataProvider.keys.map((i) {
                        for (var i = 1; i <= dataTransaction.keys.length; i++)
                          // debugPrint('response: $dataProvider');
                          Card(
                            color: AppColors.lightGreen,
                            child: InkWell(
                              child: Padding(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          dataTransaction[i]?['trx_code'] ?? '',
                                          style: AppTheme.bodySmall,
                                        ),
                                        Container(
                                          width: screenWidth * 0.7,
                                          child: Text(
                                            dataTransaction[i]?['trx_title'] ??
                                                '',
                                            style: AppTheme.bodyTiny,
                                            textAlign: TextAlign.center,
                                            maxLines: 3,
                                          ),
                                        ),
                                        Text(
                                          dataTransaction[i]?['status'] ?? '',
                                          style: AppTheme.bodySmall,
                                        ),
                                        Text(
                                            indonesianCurrencyFormat(
                                                dataTransaction[i]
                                                        ?['nominal_bayar'] ??
                                                    ''),
                                            style: AppTheme.bodyMedium),
                                      ],
                                    ),
                                    const Icon(
                                      Icons.chevron_right,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              ),
                              onTap: () {
                                // apiDataProductName =
                                //     dataProduct[i]?['nama_produk'] ?? '';
                                // apiDataProductPrice =
                                //     dataProduct[i]?['harga_jual_agen'] ?? '';
                                // apiDataProductCode =
                                //     dataProduct[i]?['kode_dku'] ?? '';
                                // NavigationHelper.pushNamed(
                                //   AppRoutes.shopping_confirm,
                                // );
                              },
                            ),
                          ),
                      ],
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
