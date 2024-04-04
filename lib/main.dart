import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ordretest/config/picture_state/picture_provider.dart';
import 'package:ordretest/config/size_config.dart';
import 'package:ordretest/pages/camera_page.dart';
import 'package:ordretest/pages/landing_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return PictureProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/landingPage',
        onGenerateRoute: (RouteSettings settings) {
           SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
              DeviceOrientation.portraitDown,
            ]);
           final arguments = settings.arguments;
            return PageRouteBuilder(
            pageBuilder: (context,animation1, animation2){
                if(settings.name == '/landingPage'){
                    return const SafeArea(child:  LandingPage());
                }else if (settings.name == '/camera'){
                    return  SafeArea(child: CameraPage(cameras: arguments as List<CameraDescription>,));
                }
            
                return const SizedBox();
            
            },
            transitionsBuilder: (_, anim, __, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.ease;
      
              var tween =  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      
              return SlideTransition(
                position: anim.drive(tween),
                child: child,
              );
            },
            transitionDuration:const Duration(milliseconds: 300),);
        }
      ),
    );
  }
}

