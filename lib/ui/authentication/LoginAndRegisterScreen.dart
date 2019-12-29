import 'package:flutter/material.dart';
import 'package:flutter_chat/base/BaseScreenState.dart';
import 'package:flutter_chat/ui/authentication/LoginAndRegisterPresenter.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';

class LoginAndRegisterScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginAndRegisterState();
  }
}

class LoginAndRegisterState extends BaseScreenState<LoginAndRegisterScreen> {
  int _selectIndex = 1;

  LoginAndRegisterPresenter _presenter;

  String _login_email;
  String _login_password;
  String _register_name;
  String _register_email;
  String _register_password;

  final _formKey = new GlobalKey<FormState>();

  @override
  void getScreenInitialization() {
    _presenter = LoginAndRegisterPresenter(screen: this);
  }

  @override
  Widget getScreenWidget() {
    return Scaffold(
      body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                backgroundColor: Colors.white,
                expandedHeight: 60.0,
                floating: false,
                pinned: true,
                elevation: 0,
                flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    title: Text("Chat Demo",
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 16.0,
                        ))),
              ),
            ];
          },
          body: Container(
            child: Column(
              children: <Widget>[
                // custom tabs.
                Padding(
                  padding: EdgeInsets.only(top: 10, right: 5, left: 5),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: createTab("Login", 1),
                      ),
                      Expanded(
                        child: createTab("Register", 2),
                      )
                    ],
                  ),
                ),
                Expanded(
                    flex: 9,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          child: _selectIndex == 1
                              ? loginScreen()
                              : registerScreen(),
                          padding: EdgeInsets.only(
                              top: 15, right: 10, left: 10, bottom: 15),
                        )
                      ],
                    ))
              ],
            ),
            color: Colors.white,
          )),
    );
  }

  Widget createTab(String title, int tabIndex) {
    // 2
    return GestureDetector(
      child: Padding(
        child: Container(
          color: Colors.transparent,
          child: new Container(
              decoration: new BoxDecoration(
                  color: tabIndex == _selectIndex ? Colors.green : Colors.white,
                  borderRadius: new BorderRadius.all(Radius.circular(30.0))),
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 18,
                        color: tabIndex == _selectIndex
                            ? Colors.white
                            : Colors.green),
                  ),
                ),
              )),
        ),
        padding: EdgeInsets.all(0),
      ),
      onTap: () {
        setState(() {
          _selectIndex = tabIndex;
        });
      },
    );
  }

  Widget loginScreen() {
    return Center(
        child: Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: new TextFormField(
                maxLines: 1,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration: new InputDecoration(
                  filled: true,
                  fillColor: Colors.greenAccent,
                  contentPadding: EdgeInsets.all(15),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Email',
                ),
                validator: (value) =>
                    value.isEmpty ? 'Email can\'t be empty' : null,
                onSaved: (value) => _login_email = value.trim()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: new TextFormField(
              maxLines: 1,
              keyboardType: TextInputType.visiblePassword,
              autofocus: false,
              decoration: new InputDecoration(
                filled: true,
                fillColor: Colors.greenAccent,
                contentPadding: EdgeInsets.all(15),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.green,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Password',
              ),
              validator: (value) =>
                  value.isEmpty ? 'Password can\'t be empty' : null,
              onSaved: (value) => _login_password = value,
            ),
          ),
          Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Forget password ?",
                style: TextStyle(fontSize: 16),
              )),
          Padding(
              padding: EdgeInsets.only(top: 10, right: 20, left: 20),
              child: SizedBox(
                height: 45,
                width: double.infinity,
                child: new RaisedButton(
                  elevation: 5.0,
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(30.0)),
                  color: Colors.green,
                  child: new Text('Login',
                      style:
                          new TextStyle(fontSize: 20.0, color: Colors.white)),
                  onPressed: _loginClicked,
                ),
              )),
          Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "OR",
                style: TextStyle(fontSize: 16),
              )),
          Padding(
            padding: EdgeInsets.only(top: 5, right: 5, left: 5),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Container(
                    child: Padding(
                      child: FacebookSignInButton(
                          text: "Facebook",
                          borderRadius: 15,
                          onPressed: () {
                            _presenter.processFacebookLogin().then((value) {
                              if (value) navigateToHome();
                            });
                          }),
                      padding: EdgeInsets.all(5),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      child: GoogleSignInButton(
                        text: "Google",
                        borderRadius: 15,
                        onPressed: () {},
                        darkMode: true, // default: false
                      ),
                      padding: EdgeInsets.all(5),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }

  Widget registerScreen() {
    return Center(
      child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: new TextFormField(
                    maxLines: 1,
                    keyboardType: TextInputType.text,
                    autofocus: false,
                    decoration: new InputDecoration(
                      filled: true,
                      fillColor: Colors.greenAccent,
                      contentPadding: EdgeInsets.all(15),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.green,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'Name',
                    ),
                    validator: (value) =>
                        value.isEmpty ? 'Name can\'t be empty' : null,
                    onSaved: (value) => _register_name = value.trim()),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: new TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.greenAccent,
                    contentPadding: EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Email',
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Email can\'t be empty' : null,
                  onSaved: (value) => _register_email = value,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: new TextFormField(
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  autofocus: false,
                  decoration: new InputDecoration(
                    filled: true,
                    fillColor: Colors.greenAccent,
                    contentPadding: EdgeInsets.all(15),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Password',
                  ),
                  validator: (value) =>
                      value.isEmpty ? 'Password can\'t be empty' : null,
                  onSaved: (value) => _register_password = value,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 15, right: 20, left: 20),
                  child: SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: new RaisedButton(
                      elevation: 5.0,
                      shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0)),
                      color: Colors.green,
                      child: new Text('Register',
                          style: new TextStyle(
                              fontSize: 20.0, color: Colors.white)),
                      onPressed: _registerClicked,
                    ),
                  )),
            ],
          )),
    );
  }

  void _loginClicked() {
    if (validate())
      _presenter.processLogin(_login_email, _login_password).then((value) {
        if (value) navigateToHome();
      });
  }

  void _registerClicked() {
    if (validate())
      _presenter.processRegister(_register_name, _register_email, _register_password)
          .then((value) {
        if (value) navigateToHome();
      });
  }

  bool validate() {
    var form = _formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  void navigateToHome() {
    Navigator.of(context).pushReplacementNamed("/host");
  }
}
