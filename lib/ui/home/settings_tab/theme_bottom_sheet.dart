import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/settings_provider.dart';

class ThemeBottomSheet extends StatefulWidget {
  const ThemeBottomSheet({super.key});

  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<SettingsProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: (){
                provider.changeThemeMode(ThemeMode.light);
              },
              child: provider.currentTheme == ThemeMode.light?
              buildSelectedThemeItem("light") : buildUnSelectedThemeItem("light")),
           SizedBox(
            height: 12,
          ),
          InkWell(
              onTap: (){
                provider.changeThemeMode(ThemeMode.dark);
              },
              child: provider.currentTheme == ThemeMode.dark ? buildSelectedThemeItem("dark") :
              buildUnSelectedThemeItem("dark")),
          ],
      ),
    );
  }
  Widget buildSelectedThemeItem(String selectedTheme) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text(
            selectedTheme,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
        Icon(
          Icons.check,
          size: 30,
          weight: 100,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }

  Widget buildUnSelectedThemeItem(String unSelectedTheme) {
    return Row(
      children: [
        Text(
          unSelectedTheme,
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ],
    );
  }
}
