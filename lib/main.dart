import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gh_app/core/borrowing_list_provider.dart';
import 'package:gh_app/view/pages/assets/camera_page.dart';
import 'package:gh_app/view/pages/assets/home_page.dart';
import 'package:gh_app/view/pages/assets/login_page.dart';
import 'package:gh_app/view/pages/assets/splash_page.dart';
import 'package:gh_app/view/pages/assets/welcome_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:provider/provider.dart';

late List<CameraDescription> cameras;
Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;

  //Supabase init
  await Supabase.initialize(
    url: 'https://wtczevzjfuhdanuakxbl.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0Y3pldnpqZnVoZGFudWFreGJsIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODUyMTkwMTYsImV4cCI6MjAwMDc5NTAxNn0.JH2Sx4nXSvtdfzD4i33vDyKNR9X28HgHWZFIwU_qj60',
    // authFlowType: AuthFlowType.pkce,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => BorrowingList()),
    ],
    child: const MyApp()
    ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            // elevation: 0,
          ),
        ),
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xff6A94FF)),
        // colorScheme: ColorScheme.light(),
        useMaterial3: true,
      ),
      initialRoute: '/',
      // routes: {
      //   // When navigating to the "/" route, build the FirstScreen widget.
      //   '/': (context) => const WelcomeScreen(),
      //   // '/camera': (context) => const CameraPage(),
      // },
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}
