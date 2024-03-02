import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:todoapp/model/data_model.dart';
import 'package:todoapp/ui/screens/home_screen/home_screen.dart';
import 'package:todoapp/ui/screens/splash_screen/splash_page.dart';
import 'package:todoapp/util/app_color.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if(!Hive.isAdapterRegistered(TodoModelAdapter().typeId)){
    Hive.registerAdapter(TodoModelAdapter());

  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.green
        )
      ),
      home:SplashPage(),

    );
  }
}


