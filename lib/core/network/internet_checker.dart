import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:overlay_support/overlay_support.dart';
import 'package:real_estate_baghdad/features/splash/no_internet.dart';

class InternetChecker {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  OverlaySupportEntry? _overlayControll;

  run() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  Future _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        _overlayControll?.dismiss();
        _overlayControll = null;

        break;
      case ConnectivityResult.mobile:
        _overlayControll?.dismiss();
        _overlayControll = null;
        break;
      default:
        _overlayControll ??= showOverlay((context, progress) {
          return const NoInternet();
        }, duration: const Duration(seconds: 0));
    }
  }

  dispose() {
    _connectivitySubscription.cancel();
  }
}
