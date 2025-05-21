import 'package:flutter/widgets.dart';
import 'package:precheck_hire/flutter_super_state/lib/src/store_provider.dart';
import 'package:precheck_hire/flutter_super_state/lib/src/store_module.dart';

typedef ModuleBuilderBuilder<T> = Widget Function(
  BuildContext context,
  T module,
);
typedef ModuleBuilderChildBuilder<T> = Widget Function(
  BuildContext context,
  T module,
  Widget child,
);

/// Get the module of type [T] inside the Flutter widget tree.
///
/// The builders will update when the module updates (calls `setState`)
///
/// Example:
/// ```dart
/// Container(
///   child: ModuleBuilder<CounterModule>(
///     builder: (context, counterModule) {
///       return Text(counterModule.counter.toString());
///     },
///   ),
/// )
/// ```
/*
class ModuleBuilder<T extends StoreModule> extends StatelessWidget {

  final Function(T)? onInit;

  /// Module builder.
  final ModuleBuilderBuilder<T>? builder;

  /// Module child build, passed [child] as third argument.
  /// Takes precedence over [builder].
  final ModuleBuilderChildBuilder<T>? childBuilder;

  /// Child to be passed to [childBuilder].
  final Widget? child;

  const ModuleBuilder({
    Key? key,
     this.onInit,
    this.builder,
    this.childBuilder,
     this.child,
  })
      : assert(
  childBuilder != null || builder != null,
  "builder or childBuilder must be set",
  ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final module = StoreProvider.store(context)!.getModule<T>();

    return StreamBuilder(
      stream: module.onChange,
      builder: (context, _) {
        if (childBuilder != null) {
          return childBuilder!(context, module, child!);
        } else {
          return builder!(context, module);
        }
      },
    );
  }


  //@override
  //State<ModuleBuilder<T>> createState() => _ModuleBuilderState<T>();
}
*/
class ModuleBuilder<T extends StoreModule> extends StatefulWidget {
  final Function(T)? onInit;

  /// Module builder.
  final ModuleBuilderBuilder<T>? builder;

  /// Module child build, passed [child] as third argument.
  /// Takes precedence over [builder].
  final ModuleBuilderChildBuilder<T>? childBuilder;

  /// Child to be passed to [childBuilder].
  final Widget? child;

  const ModuleBuilder({
    super.key,
    this.onInit,
    this.builder,
    this.childBuilder,
    this.child,
  })  : assert(
          childBuilder != null || builder != null,
          "builder or childBuilder must be set",
        );

  @override
  State<ModuleBuilder<T>> createState() => _ModuleBuilderState<T>();
}

class _ModuleBuilderState<T extends StoreModule>
    extends State<ModuleBuilder<T>> {
  var ranInit = false;

  @override
  Widget build(BuildContext context) {
    final module = StoreProvider.store(context)!.getModule<T>();
    if (widget.onInit != null && !ranInit) {
      Future.delayed(const Duration(milliseconds: 50), () {
        widget.onInit!(module);
        setState(() => ranInit = true);
      });
    }

    return StreamBuilder(
      stream: module.onChange,
      builder: (context, _) {
        if (widget.childBuilder != null) {
          return widget.childBuilder!(context, module, widget.child!);
        } else {
          return widget.builder!(context, module);
        }
      },
    );
  }
}


/*
class _ModuleBuilderState<T extends StoreModule> extends State<ModuleBuilder<T>> {
  var ranInit = false;

  @override
  Widget build(BuildContext context) {
    final module = StoreProvider.store(context)?.getModule<T>();
    if (widget.onInit != null && !ranInit) {
      Future.delayed(const Duration(milliseconds: 50), () {
        widget.onInit!(module!);
        setState(() => ranInit = true);
      });
    };

    return StreamBuilder(
      stream: module?.onChange,
      builder: (context, _) {
        if (widget.childBuilder != null) {
          return widget.childBuilder!(context, module!, widget.child!);
        } else {
          return widget.builder!(context, module!);
        }
      },
    );
  }
}*/
