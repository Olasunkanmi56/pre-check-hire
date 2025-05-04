import 'package:flutter/material.dart';
import 'package:precheck_hire/flutter_super_state/lib/src/module_builder.dart';
import '../lib/src/store.dart';
import '../lib/src/store_module.dart';
import '../lib/src/store_provider.dart';

class CounterModule extends StoreModule {
  int get counter => _counter;

  var _counter = 0;

  CounterModule(Store store) : super(store);

  void increment() {
    setState(() {
      _counter++;
    });
  }
}

void main() {
  final store = Store();
  CounterModule(store);

  runApp(StoreProvider(
    store: store,
    child: const ExampleApp(),
  ));
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "flutter_super_state example",
      home: Scaffold(
        appBar: AppBar(
          title: const Text("flutter_super_state example"),
        ),
        body: ModuleBuilder<CounterModule>(
          builder: (context, counterModule) => Column(
            children: <Widget>[
              Center(
                child: ElevatedButton(
                  child: const Text("Increment"),
                  onPressed: () => counterModule.increment(),
                ),
              ),
              Center(
                child: Text("Pressed ${counterModule.counter} times"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
