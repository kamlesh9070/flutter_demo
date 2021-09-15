import 'package:flutter/material.dart';
import 'package:flutter_demo/apputils.dart';
const kQuizErrorRed = const Color(0xFFFF002D);
const kQuizBackgroundWhite = Colors.white;
class CommonFunction {


  static displayErrorDialog({@required BuildContext context, String msg, String error}) {
    if (msg != null && msg.toUpperCase().contains("SOCKET")) msg = "Looks like you lost your Internet !!";
    if (msg == null) msg = "Something wrong happened, please try again after some time or contact to ";
    if (context != null) {
      alertDialog(
        context: context,
        msg: msg,
        type: 'error',
        barrierDismissible: false,
        errorHint: error,
      );
    }
  }

  // common Alert dialog
  static alertDialog(
      {@required BuildContext context,
        String type = 'info', // 'success' || 'error'
        String title = '',
        @required String msg,
        bool showDoneButton = true,
        String doneButtonText = 'OK',
        String cancelButtonText = 'Cancel',
        Function doneButtonFn,
        bool barrierDismissible = true,
        bool showCancelButton = false,
        Function doneCancelFn,
        AlertDialog Function() builder,
        Widget widget,
        String errorHint,
        bool closeable = true}) {
    if (context != null) {
      String newTitle = title != null ? title : type == 'error' ? 'Error' : type == 'success' ? title : 'Success';
      showDialog(
        context: context,
        barrierDismissible: barrierDismissible,
        builder: (_) {
          return WillPopScope(
              onWillPop: () async => closeable,
              child: AlertDialog(
                title: AppUtils.isNullOrEmpty(newTitle) ? null : Text(newTitle),
                contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                shape: new RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                content: InkWell(
                  onLongPress: errorHint == null ? () {} : () {alertDialog(context: context, msg: errorHint);},
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      widget != null ? widget : Container(),
                      SizedBox(height: 5),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(
                          msg != null
                              ? msg
                              : type == 'error'
                              ? "Looks like your lack of \n Imagination ! "
                              : "Looks like today is your luckyday ... !!",
                          style: TextStyle(color: Theme.of(context).textTheme.caption.color),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          FlatButton(
                            color: type == 'error' ? kQuizErrorRed : Colors.green[600],
                            child: Text(
                              doneButtonText = doneButtonText ?? "OK",
                              style: TextStyle(color: kQuizBackgroundWhite),
                            ),
                            onPressed: doneButtonFn != null
                                ? doneButtonFn
                                : () {
                              Navigator.pop(context);
                            },
                          ),
                          showCancelButton ? SizedBox(width: 10) : new Container(),
                          showCancelButton
                              ? FlatButton(
                            color: Colors.red,
                            child: Text(
                              cancelButtonText ?? 'Cancel',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            onPressed: doneCancelFn != null
                                ? doneCancelFn
                                : () {
                              Navigator.pop(context);
                            },
                          )
                              : new Container(),
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
    }
  }
}