import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/providers/theme_provider.dart';
import 'package:momentry/screens/setting/components/setting_group.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingBody extends ConsumerStatefulWidget {
  const SettingBody({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends ConsumerState<SettingBody> {
  PackageInfo? packageInfo;

  @override
  void initState() {
    super.initState();

    getPackageInfo();
  }

  void getPackageInfo() async {
    final result = await PackageInfo.fromPlatform();
    setState(() {
      packageInfo = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          SettingGroup(
            title: '테마',
            icon: Icons.settings_display,
            children: [
              SettingItem(
                title: '시스템',
                onPressed: () {
                  ref.read(themeProvider.notifier).setMode(ThemeMode.system);
                },
                trailing: SizedBox(
                  height: 20,
                  child: Radio<ThemeMode>(
                    value: ThemeMode.system,
                    groupValue: ref.watch(themeProvider),
                    onChanged: ref.read(themeProvider.notifier).setMode,
                  ),
                ),
              ),
              SettingItem(
                title: '다크 모드',
                onPressed: () {
                  ref.read(themeProvider.notifier).setMode(ThemeMode.dark);
                },
                trailing: SizedBox(
                  height: 20,
                  child: Radio<ThemeMode>(
                    value: ThemeMode.dark,
                    groupValue: ref.watch(themeProvider),
                    onChanged: ref.read(themeProvider.notifier).setMode,
                  ),
                ),
              ),
              SettingItem(
                title: '라이트 모드',
                onPressed: () {
                  ref.read(themeProvider.notifier).setMode(ThemeMode.light);
                },
                trailing: SizedBox(
                  height: 20,
                  child: Radio<ThemeMode>(
                    value: ThemeMode.light,
                    groupValue: ref.watch(themeProvider),
                    onChanged: ref.read(themeProvider.notifier).setMode,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          SettingGroup(
            title: '기타',
            icon: Icons.more_horiz_outlined,
            children: [
              SettingItem(
                title: '버전정보',
                onPressed: () {},
                trailing: Row(
                  children: [
                    Text('${packageInfo?.version}'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
