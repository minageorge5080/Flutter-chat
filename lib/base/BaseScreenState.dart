import 'package:flutter/material.dart';
import 'package:flutter_chat/utils/UiUtils.dart';

abstract class BaseScreenState<T extends StatefulWidget> extends State<T> {

  UiUtils _uiUtils;

  Widget getScreenWidget();

  void getScreenInitialization();

  @override
  void initState() {
    getScreenInitialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    this._uiUtils = UiUtils(context: context);
    return getScreenWidget();
  }

  void showProgress() {
    _uiUtils.showProgress();
  }

  void hideProgress() {
    _uiUtils.hideProgress();

  }

  void onSuccess() {

  }

  void showSuccessMsg(String msg) {
    _uiUtils.showSuccessMsg(msg);

  }

  void showErrorMsg(String msg) {
    _uiUtils.showErrorMsg(msg);
  }

  void checkUser(){
    print("mohammed");
  }
}
