import 'package:flutter/material.dart';
import 'package:flushbar/flushbar.dart';
import 'package:progress_dialog/progress_dialog.dart';

class UiUtils {

  BuildContext context;
  ProgressDialog _progressDialog;

  UiUtils({this.context}){
    _progressDialog = new ProgressDialog(context);
  }

  void showProgress() {
    _progressDialog.show();
  }

  void hideProgress() {
    _progressDialog.hide();
  }

  void showSuccessMsg(String msg) {
    Flushbar(
      title:  "Chat Demo.",
      message: msg,
      duration:  Duration(seconds: 3),).show(context);
  }

  void showErrorMsg(String msg) {
    Flushbar(
      title:  "Chat Demo.",
      message: msg,
      duration:  Duration(seconds: 3),).show(context);
  }

}

