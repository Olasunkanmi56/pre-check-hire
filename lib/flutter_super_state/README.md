# flutter_super_state [![pub package](https://img.shields.io/pub/v/flutter_super_state.svg)](https://pub.dev/packages/flutter_super_state)

A simple super state management library for Flutter (with async support).

Super State uses a central store, while holds your modules. Modules are similar to Flutter's `StatefulWidget`s.

[Pub](https://pub.dev/packages/flutter_super_state) - [API Docs](https://pub.dev/documentation/flutter_super_state/latest/) - [GitHub](https://github.com/Cretezy/flutter_super_state)

Read the [Medium article](https://medium.com/@cretezy/flutter-super-state-simple-state-management-for-flutter-e6ca6e360470).

## Setup

Add the package to your `pubspec.yaml` to install:

```yaml
dependencies:
  flutter_super_state: ^0.2.0
```

See [Flutter example](https://github.com/Cretezy/flutter_super_state/blob/master/example/flutter_super_state_example.dart) for a full overview.


## Modules

First, let's create your modules. Modules hold both state (which can be changed inside `setState`) and actions.

Actions are simply class methods which can call `setState`, do other async operations, or call actions in other modules.

```dart
import 'package:ekofoods/flutter_super_state/lib/src/module_builder.dart';

// Modules extend `StoreModule`
class CounterModule extends StoreModule {
  // Read only property, to avoid accidentally setting `counter` without calling `setState`
  int get counter => _counter;

  var _counter = 0;

  // This automatically registers your module to your store
  CounterModule(Store store): super(store);

  // Synchronous actions
  void increment() {
    setState(() {
      _counter++;
    });
  }

  void decrement() {
    setState(() {
      _counter--;
    });
  }

  // Asynchronous actions
  Future<void> incrementAsync() async {
    await Future.delayed(Duration(milliseconds: 10));

    setState(() {
      _counter++;
    });
  }

  Future<void> decrementAsync() async {
    await Future.delayed(Duration(milliseconds: 10));

    setState(() {
      _counter--;
    });
  }
}

// Another module, which uses the CounterModule
class UserModule extends StoreModule {
  bool get isLoggedIn => _isLoggedIn;

  var _isLoggedIn = false;

  UserModule(Store store): super(store);

  // Synchronous actions
  Future<void> login() async {
    // Do network request...
    await Future.delayed(Duration(milliseconds: 100));
    
    // Always set state inside `setState`, or else it will not update!
    setState(() {
      _isLoggedIn = true;
    });

    // Trigger action in another module
    await store.getModule<CounterModule>().incrementAsync();
  }
}
```

> The read-only properties are optional but strongly recommended to prevent accidentally changing
> the state of a module without updating it, which would not update your views.
>
> Always do state changes inside `setState` (same as a `StatefulWidget`)

## Store

Creating a store is very simple.

```dart
import 'package:ekofoods/flutter_super_state/lib/src/module_builder.dart';


final store = Store();

// Register modules. Order does not matter. You should register all modules on initialization
CounterModule(store);
UserModule(store);

// Trigger an action
await store.getModule<UserModule>().login();
```

## Store Provider

For Flutter, simply wrap your application inside a `StoreProvider`:

```dart
runApp(StoreProvider(
  // Previously created store
  store: store,
  child: MyApp(),
));
```

This will make the store accessibly anywhere in your application using `StoreProvider.store(context)`, or using the builders.

## Module Builder

To get a module in Flutter views, you can use `ModuleBuilder`:

```dart
@override
Widget build(BuildContext context) {
  return ModuleBuilder<CounterModule>(
    builder: (context, counterModule) {
      return Text(counterModule.counter.toString());
    },
  );
}
```

The `builder` will rebuild when the module calls `setState`.

### Child builder

If you have a large part of the state which doesn't update,
you can pass it as `child` to the `ModuleBuilder` and use `childBuilder`:

```dart
@override
Widget build(BuildContext context) {
  return ModuleBuilder<CounterModule>(
    // Will not rebuild on update
    child: Container(),
    childBuilder: (context, counterModule, child) {
      return Row(
        children: <Widget>[
          child, // Container()
          Text(counterModule.counter.toString()),
        ]
      );
    },
  );
}
```

## Store Builder

To get your store in Flutter views, you can use `StoreBuilder`:

```dart
@override
Widget build(BuildContext context) {
  return StoreBuilder(
    builder: (context, store) {
      return Text(store.getModule<CounterModule>().counter.toString());
    },
  );
}
```

The `builder` will rebuild when any module calls `setState`. It is preferable to use `ModuleBuilder` which only updates when the listened module updates.

### Child builder

If you have a large part of the state which doesn't update, pass it as `child` to the `StoreBuilder` and use `childBuilder`:

```dart
@override
Widget build(BuildContext context) {
  return StoreBuilder(
    // Will not rebuild on update
    child: Container(),
    childBuilder: (context, store, child) {
      return Row(
        children: <Widget>[
          child, // Container()
          Text(store.getModule<CounterModule>().counter.toString()),
        ]
      );
    },
  );
}
```

## Hooks (Persistance)

You can add hooks per module for pre- and post-update. This can be useful for persisting state.

```dart
class PersistCounterModule extends StoreModule {
  int get counter => _counter;
  var _counter = 0;

  PersistCounterModule(Store store, int initialCounter = 0):
    // Initial state
    _counter = initialCounter,
    super(store);

  void increment() {
    setState(() {
      // Will call preSetState here
      _counter++;
      // Will call postSetState here
    });
  }

  void postSetState() {
    // Use whatever storage mechanism you want
    storage.set("counter", counter);
  }
}

// During initialization
PersistCounterModule(store, storage.get("counter"));
```

You can also use the `preSetState` which is called before `setState` is done.

> It a a convention that the `store` parameter should come first in a module's constructor.

## Streams

Both store and module expose `onChange` streams which are called whenever:
- Module: The module updates
- Store: Any module updates

> Both of these only dispatch `null`, indicating that an update was done.

## Dispose

Both the store (if extended) and modules have a `dispose` method that is available.
You can do cleanup of any value here (don't forget to call `super.dispose()` though).

This method isn't usually called, as your store is active for the lifetime of your application.

## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/Cretezy/flutter_super_state/issues).

