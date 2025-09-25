import 'package:flutter/material.dart';

class BluetoothPage extends StatelessWidget {
  const BluetoothPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('蓝牙连接'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text('Bluetooth demo placeholder', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text('• Scan for devices\n• Connect / Disconnect\n• Show connection state'),
          ],
        ),
      ),
    );
  }
}
