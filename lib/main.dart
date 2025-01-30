import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quatrows/route/route.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  runApp(App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Color(0xFF1B9AAA)),
      initialRoute: '/',
      onGenerateRoute: AppRouter().generateRoute,
    );
  }
}
