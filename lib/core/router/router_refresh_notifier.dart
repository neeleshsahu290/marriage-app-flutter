import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GoRouterRefreshNotifier extends ChangeNotifier {
  late final StreamSubscription _subscription;

  GoRouterRefreshNotifier(BlocBase bloc) {
    _subscription = bloc.stream.listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
