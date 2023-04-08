import 'package:flutter/material.dart';
import 'package:flutter_session1/pages/home_page.dart';
import 'package:flutter_session1/pages/status_page.dart';
import 'package:flutter_session1/services/socket_service.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SocketService()),
      ],
      child: MaterialApp(
        title: 'Material App',
        initialRoute: HomePage.routeName,
        debugShowCheckedModeBanner: false,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          StatusPage.routeName: (context) => StatusPage(),
        },
      ),
    );
  }
}
