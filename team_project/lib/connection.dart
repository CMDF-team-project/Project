import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

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
    _subscription = _onConnectivityChanged.listen(_onChange);
    _hasConnection = _onResult(result);

    return this;
  } 

  void _onChange(bool value) {
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

mixin ConnectionAwareMixin<T extends StatefulWidget> on State<T> {
  bool hasConnection = false;

  bool get initialConnectionState;

  Stream<bool> get onConnectivityChanged;
  StreamSubscription<bool>? _subscription;

  void onConnectionStateChange();

  @override
  void initState() {
    super.initState();
    hasConnection = initialConnectionState;
    _subscription = onConnectivityChanged.listen(_onChangeConnection);
  }
  
  void _onChangeConnection(bool result) {
    hasConnection = result;
    onConnectionStateChange();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    super.dispose();
  }
}

abstract interface class RestartableStateInterface {
  Future<void> reloadState();
  Future<void> loadState();
  bool shouldReload();
}

mixin DefaultConnectionAwareMixin<T extends StatefulWidget> on ConnectionAwareMixin<T> implements RestartableStateInterface {

  @override
  Stream<bool> get onConnectivityChanged => connectionService.onConnectivityChanged;

  @override
  bool get initialConnectionState => connectionService.hasActiveConnection;

  @override
  void initState() {
    super.initState();
    reloadState();
  }

  @override
  Future<void> reloadState() async {
    await loadState();
  }

  @override
  Future<void> loadState() async {
    setState(() {});
  }

  @override
  bool shouldReload() => true;

  @override
  void onConnectionStateChange() {
    if (hasConnection && shouldReload()) {
      reloadState();
    } else {
      setState(() {});
    }
  }

  Widget buildPage(BuildContext context);

  @protected
    @override
    Widget build(BuildContext context) {
      if (hasConnection) {
        return buildPage(context);
      } else {
        return WillPopScope(
          onWillPop: () async {
            SystemNavigator.pop(animated: true);
            return false;
          },
          child: NoConnectionState(
            onRetry: reloadState,
          ),
        );
      }
    }
}

class NoConnectionState extends StatelessWidget {
  const NoConnectionState({
    Key? key,
    required this.onRetry,
  }) : super(key: key);
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('No active connection'),
            const SizedBox(
              height: 20,
            ),
            OutlinedButton(onPressed: onRetry, child: const Text('Retry'))
          ],
        ),
      ),
    );
  }
}