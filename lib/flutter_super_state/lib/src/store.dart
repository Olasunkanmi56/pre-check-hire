import 'dart:async';

import 'package:precheck_hire/flutter_super_state/lib/src/store_module.dart';

typedef ModuleUpdatedCallback = void Function();

class Store {
  final _onChangeController = StreamController<void>.broadcast(sync: true);

  /// Stream of updates after [StoreModule.setState] in any child module. The value of the stream can be discarded (will always be `null`)
  Stream get onChange => _onChangeController.stream;

  final _modules = <Type, StoreModule>{};

  /// Do not call this manually! It will not update the store's [onChange] when the module is called.
  /// This is automatically called when calling `super` for a [StoreModule]
  ///
  /// Registers module of type [T] to the store.
  ///
  /// Only one module per type is allowed, and [T] must be unique as string.
  ModuleUpdatedCallback registerModule(StoreModule module) {
    final exists = _getModule(module.runtimeType) != null;

    if (exists) {
      throw Exception(
          "Module of type ${module.runtimeType} already registered");
    }

    _modules[module.runtimeType] = module;

    return () {
      _onChangeController.add(null);
    };
  }

  /// Get the module of type [T] inside the store.
  ///
  /// Will throw an error if the module doesn't exist in the store
  T getModule<T extends StoreModule>() {
    if (T == StoreModule) {
      throw Exception("T is StoreModule. Did you forget to pass in T?");
    }

    final module = _getModule<T>(T);

    if (module == null) {
      throw Exception("Could not find module of type $T");
    }

    return module;
  }

  T? _getModule<T extends StoreModule>(Type moduleType) {
    return _modules[moduleType] as T?;
  }

  /// Dispose of the store, and all of it's modules.
  void dispose() {
    _onChangeController.close();

    _modules.forEach((_, value) {
      value.dispose();
    });
  }
}
