import 'package:flutter/material.dart';

class SettingGroup extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget> children;

  const SettingGroup({
    Key? key,
    required this.title,
    required this.icon,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 24,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16.0,
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0, bottom: 8),
          child: Column(
            children: children,
          ),
        ),
        const Divider(
          thickness: 2,
          height: 2,
        ),
      ],
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;
  final Widget? trailing;

  const SettingItem({
    Key? key,
    required this.title,
    required this.onPressed,
    this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 18.0),
              ),
            ),
            trailing ?? Container()
          ],
        ),
      ),
    );
  }
}
