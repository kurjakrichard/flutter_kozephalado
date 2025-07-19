import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';
import '../main.dart';

class HomePage extends HookWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    ValueNotifier<int> counter = useState(prefs.getInt('counter') ?? 0);
    return Scaffold(
      drawer: drawerNavigation(context),
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${counter.value}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            Text(context.read<String>()),
            Text(Provider.of<String>(context, listen: false)),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'btn1',
            onPressed: () {
              _incrementCounter(counter);
            },
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            heroTag: 'btn2',
            onPressed: () {
              _reset(counter);
            },
            tooltip: 'Reset',
            child: const Icon(Icons.exposure_zero),
          ),
          FloatingActionButton(
            heroTag: 'btn3',
            onPressed: () {
              _decrementCounter(counter);
            },
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),
        ],
      ),
    );
  }

  Widget drawerNavigation(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Homepage'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/');
              }),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/settings', arguments: 'Settings');
            },
          ),
        ],
      ),
    );
  }

  void _incrementCounter(ValueNotifier counter) {
    counter.value++;
    prefs.setInt('counter', counter.value);
  }

  void _decrementCounter(ValueNotifier counter) {
    counter.value--;
    prefs.setInt('counter', counter.value);
  }

  void _reset(ValueNotifier counter) {
    counter.value = 0;
    prefs.setInt('counter', counter.value);
  }
}
