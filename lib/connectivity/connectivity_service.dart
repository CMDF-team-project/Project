import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {
  ConnectivityService(this._connectivity)
    : _onConnectivityChanged = _connectivity.onConnectivityChanged
      .map(_onResult)
      .asBroadcastStream();


  final Connectivity _connectivity;
  final Stream<bool> _onConnectivityChanged;
  StreamSubscription<bool>? _subscription;

  Stream<bool> get onConnectivityChanged => _onConnectivityChanged;

  bool _hasConnection = false;
  bool get hasActiveConnection => _hasConnection;

  Future<ConnectivityService> init() async {
    final result = await _connectivity.checkConnectivity();
    _subscription = _onConnectivityChanged.listen(onChange);
    _hasConnection = _onResult(result);

    return this;
  } 

  void onChange(bool value) {
    _hasConnection = value;
  }

  static bool _onResult(ConnectivityResult result) {
    bool hasConnection = false;
    if (result case ConnectivityResult.mobile || ConnectivityResult.wifi) {
      hasConnection = true;
    }

    return hasConnection;
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}