// splash_screen.dart
import 'package:flutter/material.dart';
import 'login_screen.dart'; // Make sure to import your login screen
import '../utils/helpers/navigation_helper.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../values/app_routes.dart';

import '../global_variables.dart';


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
      print("lanjut");
      NavigationHelper.pushReplacementNamed(AppRoutes.login);
    } catch (e) {
      // Handle errors or show an error message
      print("Error loading data: $e");
    }
  }

  Future<void> detailLembaga() async {
    // Your existing detailLembaga logic here
    const url = 'https://dkuapi.dkuindonesia.id/api/Credential/koperasi_details';
    const headers = {
      'ClientID':
          'bX4LUEznPFu1WIA5ykO\/Q\/9O9VKVqaGyr7mXBWMdxDFHTwAjsC+R3dW6GuZDJzQrQHSWSDxWMLyWLb5ppbFfP1m2vQ22Wzvsk1wS0yoMMTkSyYtAWPv7pDQKWznPZJtQOTDeodHYexRm0OOnmA05009fjZdAL7kVldbNu3c2ld2dgfiifrCkWjmEwf8ENgQFsT49lbkBaIbmdEMd1cWlkm036ukefHYpf\/mEAcsdRleO0UKvNhHsT+fDxr2ztZwMJ7F4DIGn6hOTr7f4AgcbHiX18jmrhaAMispIFcbNRvQJACb9D7HunKt90yhUpfF3YQzHdSaZ+zrc5xf4Quw46z5E9Yj3JDyl7kZC8c6dT4E=',
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
        print(responseBody);
        responseDetailsAppNameString = responseBody['data_app']['app_name_string'].toString();
        responseDetailsAppLogo = responseBody['data_app']['app_logo'].toString();
        responseDetailsAppLogoBar = responseBody['data_app']['app_logo_bar'].toString();
        updateDetailsApp(
          responseDetailsAppNameString,
          responseDetailsAppLogo,
          responseDetailsAppLogoBar,
        );

        print(apiDataAppLogo);
        print(apiDataAppLogoBar);
        print(apiDataAppNameString);
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
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(), // Display a loading indicator
      ),
    );
  }
}
