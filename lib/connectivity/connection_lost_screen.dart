import 'package:flutter/material.dart';

class ConnectionLostWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      body: Center(
        child: Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Icon(Icons.signal_wifi_off),
              SizedBox(
                height: 10,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Waiting for wifi   ',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    WidgetSpan(
                      baseline: TextBaseline.alphabetic,
                      alignment: PlaceholderAlignment.baseline,
                      child: SizedBox(
                        width:
                            Theme.of(context).textTheme.bodyText1.fontSize - 4,
                        height:
                            Theme.of(context).textTheme.bodyText1.fontSize - 4,
                        child: CircularProgressIndicator(
                          strokeWidth: 1.4,
                          valueColor:
                              new AlwaysStoppedAnimation<Color>(Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.8,
          height: 300,
        ),
      ),
    );
  }
}
