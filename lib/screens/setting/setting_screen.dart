import 'package:flutter/material.dart';
import 'package:momentry/screens/setting/components/setting_body.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('설정'),
      ),
      body: SettingBody(),
    );
  }
}
