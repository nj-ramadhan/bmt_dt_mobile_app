

import 'package:flutter/material.dart';
import 'global_variabel.dart'; // Impor variabel global

class Screen1 extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Screen 1')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Ubah Data GLobal disini',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                updateGlobalVariable(_controller.text); // Update variabel global
                Navigator.pushNamed(context, '/screen2'); // Navigasi ke Screen2
              },
              child: Text('Save Dan Pindah ke Screen 2'),
            ),
          ],
        ),
      ),
    );
  }
}
