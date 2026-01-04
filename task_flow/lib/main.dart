import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:task_flow/screens/home.dart';
import 'package:task_flow/screens/login.dart';
import 'package:task_flow/screens/register.dart';
import 'package:task_flow/screens/splash.dart';
import 'package:task_flow/widgets/tabs.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromRGBO(30, 0, 50, 1),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData().copyWith(
        useMaterial3: true,
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: Color.fromRGBO(30, 0, 50, 1),
          foregroundColor: Colors.white,
        ),

        textTheme: ThemeData().textTheme.copyWith(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSecondary,
            fontSize: 18,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
      ),
      themeMode: ThemeMode.system,
      // darkTheme: ThemeData(
      //   useMaterial3: true,
      //   colorScheme: ColorScheme.fromSeed(
      //     seedColor: const Color.fromARGB(255, 130, 45, 186),
      //     brightness: Brightness.dark,
      //     surface: const Color.fromARGB(255, 3, 3, 19),
      //     onSurface: Colors.white,
      //   ),
      // ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/home': (context) => const HomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/tabs': (context) => const Tabs(),
      },
    );
  }
}

///////////////////
///import 'package:ahmedhelmy/screens/profile.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:ahmedhelmy/screens/home.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:ahmedhelmy/firebase_options.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';

// // --- GLOBAL CONFIGURATIONS & KEYS ---

// // This allows you to navigate without having a BuildContext
// final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// var kColorScheme = ColorScheme.fromSeed(
//   seedColor: const Color.fromARGB(255, 27, 55, 175),
// );

// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   // iOS does not use "channels" in this way; it uses "Categories"
//   'high_importance_channel',
//   'High Importance Notifications',
//   description: 'This channel is used for important notifications.',
//   importance: Importance.max,
// );

// // You need this to manually show a banner on Android when the app is open (Foreground).
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();

// // --- BACKGROUND HANDLERS ---

// // entry point tells the Flutter compiler that the following future functions will be executed
// // to prevents the code from being removed during "tree-shaking" when you build the app for release.
// @pragma('vm:entry-point')
// Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
//   // Platform:Both==>Background Isolate==>Since the background
//   // handler runs in a separate process away from main, you must
//   // re-initialize Firebase within this function to access its services.
//   await Firebase.initializeApp();
//   debugPrint('Background message: ${message.messageId}');
// }

// // --- HELPER FUNCTIONS ---

// void _handleNavigation(RemoteMessage message) {
//   if (message.data['NAVIGATE'] == 'PROFILE') {
//     navigatorKey.currentState?.pushNamed('/profile');
//   }
// }

// Future<void> requestNotificationPermission() async {
//   // Both Platforms ==>"Handshake" between your app and the mobile operating system
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//   // we use .instance to create a "remote control" (a reference) in your code that is linked to that control center
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
//     // This tells iOS that even if the app is open, it should still show the banner/sound.
//     // Even if the user is currently using the app, I still want you to drop down the banner and play the sound.
//     alert: true,
//     badge: true,
//     sound: true,
//   );
//   debugPrint('Permission status: ${settings.authorizationStatus}');
// }

// Future<void> getFcmToken() async {
//   String? token = await FirebaseMessaging.instance.getToken();
//   debugPrint('FCM Token: $token');
// }

// void setupFCMListeners() {
//   // "Control Center" for how your app reacts to messages while it is already running (either in the foreground or the background).
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     // triggers when a message arrives while the app is open
//     RemoteNotification? notification = message.notification;
//     AndroidNotification? android = message.notification?.android;

//     // If on Android and app is in foreground, manually show the notification to "force" a local notification banner using the plugin we initialized earlier.
//     if (notification != null && android != null) {
//       flutterLocalNotificationsPlugin.show(
//         notification.hashCode, // unique ID
//         notification.title,
//         notification.body,
//         NotificationDetails(
//           // envelope to add instructions when the notifications are handled by android
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//             channelDescription: channel.description,
//             icon: android.smallIcon ?? '@mipmap/ic_launcher',
//           ),
//         ),
//         payload: message.data['NAVIGATE'],
//       );
//     }
//     debugPrint('Foreground message: ${message.notification?.title}');
//   });

//   // This triggers when the user physically taps a notification while the app was sitting in the Background
//   FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
//     _handleNavigation(message);
//     debugPrint('Opened from notification: ${message.notification?.title}');
//   });
// }

// // --- MAIN ENTRY POINT ---
// void main() async {
//   // Ensures the Flutter engine is ready before trying to run asynchronous code (like Firebase setup).
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   // if i have a background message arrives while I'm asleep, please wake up this specific functionand give it the message
//   FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

//   // Initialize Local Notifications to handle Android foreground banners
//   // Creates an Android Notification Channel
//   await flutterLocalNotificationsPlugin
//       .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin
//       >()
//       ?.createNotificationChannel(channel);

//   await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

//   // 1. Define Initialization Settings for iOS to Handle notification taps
//   const initializationSettings = InitializationSettings(
//     android: AndroidInitializationSettings(
//       '@mipmap/ic_launcher',
//     ), // Uses the app launcher icon for notifications
//     iOS: DarwinInitializationSettings(), // Required for iOS
//   );

//   // 2. Initialize with the tap handler
//   await flutterLocalNotificationsPlugin.initialize(
//     initializationSettings,
//     onDidReceiveNotificationResponse: (NotificationResponse response) {
//       // This is what handles the tap while the app is OPEN (Foreground)
//       if (response.payload == 'PROFILE') {
//         navigatorKey.currentState?.pushNamed('/profile');
//       }
//     },
//   );

//   // 3. IMPORTANT: Setup listeners BEFORE runApp
//   setupFCMListeners();

//   runApp(const MyApp());

//   // for terminated states to receive keys and values
//   RemoteMessage? initialMessage = await FirebaseMessaging.instance
//       .getInitialMessage();
//   if (initialMessage != null) {
//     _handleNavigation(initialMessage);
//   }

//   await FirebaseAnalytics.instance.logEvent(
//     name: 'app_open',
//     parameters: {'user_name': 'mariam', 'action': 'testing_analytics'},
//   );

//   await requestNotificationPermission();
//   await getFcmToken();
// }

// // --- APP WIDGET ---
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       navigatorKey: navigatorKey,
//       theme: ThemeData().copyWith(
//         useMaterial3: true,
//         colorScheme: kColorScheme,
//         appBarTheme: const AppBarTheme().copyWith(
//           backgroundColor: const Color.fromRGBO(13, 68, 140, 1),
//           foregroundColor: const Color.fromARGB(255, 255, 255, 255),
//         ),
//         textTheme: ThemeData().textTheme.copyWith(
//           titleLarge: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: kColorScheme.onSecondary,
//             fontSize: 18,
//           ),
//         ),
//         elevatedButtonTheme: ElevatedButtonThemeData(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: kColorScheme.primaryContainer,
//           ),
//         ),
//       ),
//       themeMode: ThemeMode.light,
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/home',
//       routes: {
//         '/home': (context) => const HomeScreen(),
//         '/profile': (context) => const ProfileScreen(),
//       },
//     );
//   }
// }
