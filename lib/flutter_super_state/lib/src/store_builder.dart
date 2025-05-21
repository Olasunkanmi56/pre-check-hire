import 'package:flutter/widgets.dart';

import '../flutter_super_state.dart';

typedef StoreBuilderBuilder = Widget Function(
  BuildContext context,
  Store store,
);
typedef StoreBuilderChildBuilder = Widget Function(
  BuildContext context,
  Store store,
  Widget child,
);

/// Get the store inside the Flutter widget tree.
///
/// It is recommended to use [ModuleBuilder] as this will update whenever any of
/// the store's module is updated.
///
/// Example:
/// ```dart
/// Container(
///   child: StoreBuilder(
///     builder: (context, store) {
///       return Text(store.getModule<CounterModule>().counter.toString());
///     },
///   ),
/// )
/// ```
class StoreBuilder extends StatefulWidget {
  /// Store builder.
  final StoreBuilderBuilder? builder;

  /// Store child build, passed [child] as third argument.
  /// Takes precedence over [builder].
  final StoreBuilderChildBuilder? childBuilder;

  /// Child to be passed to [childBuilder].
  final Widget? child;
  final Function(Store)? onInit;

  const StoreBuilder({
    super.key,
    this.builder,
    this.childBuilder,
    this.child,
    this.onInit,
  })  : assert(
  childBuilder != null || builder != null,
  "builder or childBuilder must be set",
  );



/* final Function(Store)? onInit;

  const StoreBuilder({
    Key? key,
    required this.builder,
    this.childBuilder,
     this.child,
     this.onInit,
  })
      : assert(
  childBuilder != null || builder != null,
  "builder or childBuilder must be set",
  ), super(key: key);
*/
  @override
  State<StoreBuilder> createState() => _StoreBuilderState();
}
class _StoreBuilderState extends State<StoreBuilder> {
  var ranInit = false;

  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.store(context);
    if (widget.onInit != null && !ranInit) {
      Future.delayed(const Duration(milliseconds: 50), () {
        widget.onInit!(store!);
        setState(() => ranInit = true);
      });
    }
    return StreamBuilder(
      stream: store!.onChange,
      builder: (context, _) {
        if (widget.childBuilder != null) {
          return widget.childBuilder!(context, store, widget.child!);
        } else {
          return widget.builder!(context, store);
        }
      },
    );
  }
}
