import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'layout/cubit/cubit.dart';
import 'layout/cubit/states.dart';
import 'layout/social_layout.dart';
import 'modules/login/social_login_screen.dart';
import 'shared/bloc_observer.dart';
import 'shared/components/components.dart';
import 'shared/components/constants.dart';
import 'shared/network/local/cashe_helper.dart';
import 'shared/network/remote/diohelper.dart';
import 'shared/styles/themes.dart';

Future<void>firebaseMessagingBackgroundHandler(RemoteMessage message)async
{
  print(message.data.toString());
  showToast(text: 'on background message', state: ToastStates.success);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // BY2KD EN KOL HAGA FY METHOD KHELST w b3den yf7 app
  await Firebase.initializeApp();
  var token = await FirebaseMessaging.instance.getToken();
  print(token);

  FirebaseMessaging.onMessage.listen((event)
  {
    print(event.data.toString());
    showToast(text: 'on message', state: ToastStates.success);
  });

FirebaseMessaging.onMessageOpenedApp.listen((event)
  {
    print(event.data.toString());
    showToast(text: 'on message opening app', state: ToastStates.success);
  });

FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CasheHelper.init();
  bool? isDark = CasheHelper.getData(key: 'isDark');
  late Widget widget;

   uId = CasheHelper.getData(key: 'uId');

  if(uId != null)
    {
      widget = SocialLayout();
    }else
      {
        widget = SocialLoginScreen();
      }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  Widget? startWidget;

  MyApp({
    this.startWidget,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => SocialCubit()
            ..getUserData()
              ..getPosts()

        ),
      ],
      child: BlocConsumer<SocialCubit, SocialStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            home: startWidget,
          );
        },
      ),
    );
  }
}
