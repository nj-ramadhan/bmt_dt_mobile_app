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
          'jLdCPSe3816XRXk7+aCMc+Et0nk1y6\/48a2bpVHFMrkza9T41ymgT7iBDLH8jQ\/7OKmOPQ5d9tON6yBcTQEUiO9yZBfwotnfDzFTS5l7cH++Cuh2MXj5MdUgBdPo22oyTY9x9OqCYkszV5A\/Le8Lm1sA93eDJILe14nPJDBGkKnh5LE4spoyKFgjDRs\/WzXeZ9pQGOkHyX6IK\/2oxI8ZGuKpRxrvMxlPYdhp9dC11Y5QZgdXmAt3DYU6qqaX6I9hhRNYYR4M\/fXTrjkHB\/v+1VFKgkGRFz0eIhDXZ3yp7e\/uKAzAjpxxdsdRHMcQQUqsmx6Og60tJUXzcX1UVYtbHhay40s9Yq6uKdBVDArlKxtxDQ4Nr9NmUHbXBlaQG0Z37e+F1ILz5a0wZrjpst3ncVssMr1HgaXa3HdxMolyFAQslH4k9bujP5n\/B4JLrQX0oRxTVAjxosQMOg750NgtzVArRloEsIQHarjhoRMpDOXFZEZIpxXx4tOGZ3KtUdvY8F9CfWo6IAcFP1KubCu2lxnLfx76MfUU7IpGLqS3\/gKIXwL6NGFqzdeEy3xC\/Qr6',
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
