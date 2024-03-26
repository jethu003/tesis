import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:tesis/firebase_options.dart';
import 'package:tesis/hive_db_functions/hive_models/add_plants.dart';
import 'package:tesis/reminders_screen/notification_controller.dart';
import 'package:tesis/reminders_screen/reminder_models/reminder_model.dart';
import 'package:tesis/settings_screen/fire_store.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:tesis/splash_welcome_screens/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(AddPlantModelAdapter().typeId)) {
    Hive.registerAdapter(AddPlantModelAdapter());
  }
  if (!Hive.isAdapterRegistered(ReminderModelAdapter().typeId)) {
    Hive.registerAdapter(ReminderModelAdapter());
  }

  await FirestroreService().getUsers();

  await AwesomeNotifications().initialize(null, [
    NotificationChannel(
        channelGroupKey: 'basic_Channel_group',
        channelKey: 'basic_channel',
        channelName: 'Basic Notification',
        channelDescription: 'Basic notifications channel')
  ], channelGroups: [
    NotificationChannelGroup(
        channelGroupKey: 'basic_Channel_group', channelGroupName: 'Basic Group')
  ]);

  bool isAllowedToSendNotification =
      await AwesomeNotifications().isNotificationAllowed();

  if (!isAllowedToSendNotification) {
    AwesomeNotifications().requestPermissionToSendNotifications();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    AwesomeNotifications().setListeners(
      onActionReceivedMethod: NotificationController.onActionReceivedMethod,
      onNotificationCreatedMethod:
          NotificationController.onNotificationCreatedMethod,
      onNotificationDisplayedMethod:
          NotificationController.onNotificationDisplayedMethod,
      onDismissActionReceivedMethod:
          NotificationController.onDismissActionReceivedMethod,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 3, 108, 29)),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
