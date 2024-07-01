import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:team_project/connectivity/no_connection_state_widget.dart';
import 'package:team_project/main.dart';

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

