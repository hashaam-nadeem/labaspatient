import 'dart:io';

import 'package:Labas/connectivity/connection_lost_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity/connectivity.dart';

class BlocClass extends Bloc<MyEvents, bool> {
  var connectivityResult;

  BlocClass(bool initalState) : super(initalState) {
    initialState();
  }

  initialState() {
    Stream.periodic(
      Duration(seconds: 5),
    ).listen((event) {
      internetConnectionAvailabilty();
    });
    connectivityResult =
        Connectivity().onConnectivityChanged.listen((event) async {
      if (event == ConnectivityResult.none) {
        if (state) {
          add(MyEvents.connnectionLost);
        }
      } else {
        internetConnectionAvailabilty();
      }
    });
    return true;
  }

  internetConnectionAvailabilty() async {
    try {
      final result = await InternetAddress.lookup('example.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        if (!state) {
          add(MyEvents.connectionAvailable);
        }
      }
    } on SocketException catch (_) {
      if (state) {
        add(MyEvents.connnectionLost);
      }
    }
  }

  @override
  Stream<bool> mapEventToState(MyEvents event) async* {
    print('Event: ' + event.toString());
    if (event == MyEvents.connnectionLost) {
      print('showing custom dialog');
      BotToast.showCustomLoading(toastBuilder: (adfasd) {
        return ConnectionLostWidget();
      });
      yield false;
    } else {
      BotToast.closeAllLoading();
      yield true;
    }
  }
}

enum MyEvents {
  connnectionLost,
  connectionAvailable,
}
