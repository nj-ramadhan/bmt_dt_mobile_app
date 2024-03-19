
import 'package:flutter/material.dart';
import 'global_variabel.dart'; // Impor variabel global
class Screen2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 2')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(globalVariable), // Tampilkan nilai variabel global terkini
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke Screen sebelumnya
              },
              child: Text('Pindah Ke Screen 1'),
            ),
          ],
        ),
      ),
    );
  }
}
