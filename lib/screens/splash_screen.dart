// splash_screen.dart
// ignore_for_file: lines_longer_than_80_chars, avoid_dynamic_calls

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../global_variables.dart';
import '../utils/helpers/navigation_helper.dart';
import '../values/app_routes.dart';

late String responseDetailsAppLogo;
late String responseDetailsAppLogoBar;
late String responseDetailsAppNameString;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      await detailLembaga(); // Call your detailLembaga function
      // Navigate to your login screen and pass the loaded data
      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage(detailData: detailData)));
      if (kDebugMode) {
        print('lanjut');
      }
      await NavigationHelper.pushReplacementNamed(AppRoutes.login);
    } catch (e) {
      // Handle errors or show an error message
      if (kDebugMode) {
        print('Error loading data: $e');
      }
    }
  }

  Future<void> detailLembaga() async {
    // Your existing detailLembaga logic here
    const url =
        'https://dkuapi.dkuindonesia.id/api/Credential/koperasi_details';
    const headers = {
      'ClientID':
          'KnxNoQkPMMesAVR85tM\/XdLG6Bruiabbx\/8KmD3GyDnB4G8tCmKSnaUa4HMu+nCtRR1FaQK4uTTTiPu+m+8u83JrExoOE0L5AI5TEFHhhKH6pFq3PLqfqyKWXgmb4FFMX7Y2oZ0PtKjXhkWefB6S4\/I3Oe0aTy9rHfC7uFTUeadmExtCcSRsBXUklgneVI9kGwkMSbVOUN06UsrGwYvJqu8GizUJ6NJH98cVaJ9mqdcgXhNoLVSv68LicRycfoYVf0T\/IL5iXgHEoKYEBcfL5tzpZQ8g+D\/njHYYaIsVl16LDUcWTrCxrChgodXTRCtFWqtsIW1OSbAAZU7LZZJGU\/3iTqzGvBc6Irs10bvwQsAGbiNMTGJ5WyDGolSfp7c55ZYPgm+G82hin8qoICSCSndPJjbyVAkstdjjMbDUoqwwSuAOmEJVSvRLpx1P7+djYc+tNHAK1A269UTDwfv5B0nK6M5ZWRab2eGeNBQ5QXDsNZIhfNg1rqWaFwFtVzatnjk0vbSv+TFvSDqja\/2+Qtr+hZR68hRKtGurmSqZoMwQ4g8pM4RhCv7bvne77Ku\/uGcMbLBoep4WTnx+654eMA==',
      'Content-Type': 'application/json',
    };
    // final body = json.encode({
    //   'status': 'OK',
    //   'data_post': [
    //     {
    //       'username': phoneController.text,
    //       'password': passwordController.text,
    //     }
    //   ],
    // });

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        // body: body,
      );

      if (response.statusCode == 200) {
        final responseBody = json.decode(response.body);
        if (kDebugMode) {
          print(responseBody);
        }
        responseDetailsAppNameString =
            responseBody['data_app']['app_name_string'].toString();
        responseDetailsAppLogo =
            responseBody['data_app']['app_logo'].toString();
        responseDetailsAppLogoBar =
            responseBody['data_app']['app_logo_bar'].toString();
        updateDetailsApp(
          responseDetailsAppNameString,
          responseDetailsAppLogo,
          responseDetailsAppLogoBar,
        );

        if (kDebugMode) {
          debugPrint(apiDataAppLogo);
          debugPrint(apiDataAppLogoBar);
          debugPrint(apiDataAppNameString);
        } else {
          debugPrint('Request failed with status: ${response.statusCode}.');
        }
    } catch (e) {
      debugPrint('Error: $e');
    }
    // Return the data or throw an exception
  }

  @override
  Widget build(BuildContext context) {
    // Your SplashScreen widget tree here
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Display a loading indicator
      ),
    );
  }
}
