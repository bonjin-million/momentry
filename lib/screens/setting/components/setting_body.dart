import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:momentry/providers/theme_provider.dart';
import 'package:momentry/screens/setting/components/setting_group.dart';

class SettingBody extends ConsumerStatefulWidget {
  const SettingBody({Key? key}) : super(key: key);

  @override
  ConsumerState<SettingBody> createState() => _SettingBodyState();
}

class _SettingBodyState extends ConsumerState<SettingBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          SettingGroup(title: '테마', icon: Icons.settings_display, children: [
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
                  activeColor: Theme.of(context).primaryColor,
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
                  activeColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }
}
