import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';
import '../utils/common_widgets/gradient_background.dart';
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
  late final DatePickerDialog beginDateController;
  late final DatePickerDialog endDateController;
  String valueBeginDate = '2024-01-01';
  String valueEndDate = '2024-01-01';

  Future<void> getCheckingHistory() async {
    final dateBegin = valueBeginDate;
    final dateEnd = valueEndDate;

    final url =
        'https://dkuapi.dkuindonesia.id/api/Pulsa/get_trectrans?from_date=$dateBegin&to_date=$dateEnd&start=0&length=10';
    final headers = {
      'ClientID':
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6\/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ\/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A\/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs\/WzXeZ9pQGOkHyX6IK\/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M\/fXTrjkHB\/v+1VFKgkGRFz0eIhDXZ3yp7e\/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n\/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3\/gKIXwL6NGFqzdeEy3xC\/Qr6',
      'Authorization': 'Bearer $apiLoginToken',
      'Content-Type': 'application/json',
    };
    debugPrint('response: $url');

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
      );

      final responseBody = json.decode(response.body);
      final message = responseBody['message'].toString();
      // debugPrint('response: $headers');
      // debugPrint('response: $body');
      // debugPrint('response: $responseBody');
      debugPrint('response: $message');
    } catch (e) {
      debugPrint('Error: $e');
    }
  }

  void initializeControllers() {
    beginDateController = DatePickerDialog(
        firstDate: DateTime(1900, 1, 1, 23, 59),
        lastDate: DateTime(2100, 1, 1, 23, 59));

    endDateController = DatePickerDialog(
        firstDate: DateTime(1900, 1, 1, 23, 59),
        lastDate: DateTime(2100, 1, 1, 23, 59));
  }

  void disposeControllers() {
    beginDateController.toString();
    endDateController.toString();
  }

  // void controllerListener() {
  //   final begin = beginDateController..text;

  //   if (amount.isEmpty) return;
  // }

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
      RestorableDateTime(DateTime(1990, 1, 1));
  final RestorableDateTime _selectedEndDate =
      RestorableDateTime(DateTime(1990, 1, 1));

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
          firstDate: DateTime(1990),
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
                        height: 300,
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
                                        valueBeginDate = _selectBeginDateOnly(
                                          _selectedBeginDate.value,
                                        );
                                      },
                                      child: Text(
                                        _showBeginDateOnly(
                                            _selectedBeginDate.value),
                                      ),
                                    ),
                                    // TextField(
                                    //                   decoration: const InputDecoration(
                                    //                     hintText: AppStrings.amountTransfer,
                                    //                     fillColor: AppColors.primaryColor,
                                    //                   ),
                                    //                   controller: beginDateController,
                                    //                   textInputAction: TextInputAction.done,
                                    //                   textAlign: TextAlign.end,
                                    //                   keyboardType: TextInputType.number,
                                    //                   onChanged: (_) => updateAmountText(
                                    //                     amountController.text,
                                    //                   ),
                                    //                 ),
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
                                        valueEndDate = _selectEndDateOnly(
                                          _selectedEndDate.value,
                                        );
                                      },
                                      child: Text(
                                        _showEndDateOnly(
                                            _selectedEndDate.value),
                                      ),
                                    ),
                                    // TextField(
                                    //   decoration: const InputDecoration(
                                    //       hintText: AppStrings.amountTransfer,
                                    //       fillColor: AppColors.primaryColor),
                                    //   controller: amountController,
                                    //   textInputAction: TextInputAction.done,
                                    //   textAlign: TextAlign.end,
                                    //   keyboardType: TextInputType.number,
                                    //   onChanged: (_) => updateAmountText(
                                    //       amountController.text),
                                    // ),
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
                                onPressed: getCheckingHistory,
                                child: const Text(AppStrings.checkingProcees),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
