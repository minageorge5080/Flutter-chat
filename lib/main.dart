import 'package:flutter/material.dart';
import 'package:flutter_chat/ui/DioScreen.dart';
import 'package:flutter_chat/ui/authentication/LoginAndRegisterScreen.dart';
import 'ui/host/HostScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chat Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
//          textTheme: TextTheme(caption: TextStyle(color: Colors.white)),
//          scaffoldBackgroundColor: Colors.green,
          primarySwatch: Colors.green,
          buttonColor: Colors.green
    ),
      initialRoute: '/',
      routes: {
        '/': (context) => DioScreen(),
        '/auth': (context) => LoginAndRegisterScreen(),
        '/host': (context) => HostScreen(),
      },

    );
  }
}
