import 'package:flutter/material.dart';
import 'package:flutter_kozephalado/providers/themeprovider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var routeSettings = ModalRoute.of(context)!.settings;
    String title = routeSettings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Wrap(alignment: WrapAlignment.center, children: [
        const Card(
          child: ListTile(
            title: Text('Theme'),
          ),
        ),
        SwitchListTile(
          title: const Text('Dark Theme'),
          value: context.watch<ThemeProvider>().isDark,
          onChanged: (value) {
            Provider.of<ThemeProvider>(context, listen: false).toggle();
          },
        ),
        Column(
          children: [
            Text(context.read<String>()),
            Text(Provider.of<String>(context, listen: false)),
          ],
        ),
      ]),
    );
  }
}
