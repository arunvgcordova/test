import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:location/location.dart';
import 'package:quick_actions/quick_actions.dart';

void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}
/////////////////////////////////

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => TestController());
    return GetMaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String shortcut = "no action set";

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   switch (state) {
  //     case AppLifecycleState.resumed:
  //       print('app resumed');
  //       break;
  //     case AppLifecycleState.inactive:
  //       print('app inactive');
  //       break;
  //     case AppLifecycleState.paused:
  //       print('app paused');
  //       Timer.periodic(Duration(seconds: 1), (timer) {
  //         print('object');
  //       });
  //       break;
  //     case AppLifecycleState.detached:
  //       print('app detached');
  //       break;
  //     case AppLifecycleState.hidden:
  //     // TODO: Handle this case.
  //   }
  // }

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(this);

    final QuickActions quickActions = QuickActions();
    quickActions.initialize((String shortcutType) {
      setState(() {
        if (shortcutType != null) shortcut = shortcutType;
      });
    });

    quickActions.setShortcutItems(<ShortcutItem>[
      // NOTE: This first action icon will only work on iOS.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
        type: 'action_one',
        localizedTitle: 'Action one',
        icon: 'AppIcon',
      ),
      // NOTE: This second action icon will only work on Android.
      // In a real world project keep the same file name for both platforms.
      const ShortcutItem(
          type: 'action_two',
          localizedTitle: 'Action two',
          icon: 'ic_launcher'),
    ]);

    super.initState();
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Obx(() => Center(
            child: InkWell(
                onTap: () {
                  // Get.find<TestController>().getLiveLocaion();
                },
                child:
                    Text(Get.find<TestController>().lat.value.toString())))));
  }
}

class TestController extends GetxController {
  // Location location = Location();

  late bool _serviceEnabled;
  // late PermissionStatus _permissionGranted;

  RxDouble lat = 0.0.obs;
  RxDouble log = 0.0.obs;

  // getLiveLocaion() async {
  //   _serviceEnabled = await location.serviceEnabled();
  //   if (!_serviceEnabled) {
  //     _serviceEnabled = await location.requestService();
  //     if (!_serviceEnabled) {
  //       return;
  //     }
  //   }

  //   _permissionGranted = await location.hasPermission();
  //   if (_permissionGranted == PermissionStatus.denied) {
  //     _permissionGranted = await location.requestPermission();
  //     if (_permissionGranted != PermissionStatus.granted) {
  //       return;
  //     }
  //   }
  //   await location.enableBackgroundMode(enable: true);
  //   await location.changeSettings(
  //       accuracy: LocationAccuracy.high, interval: 1000);

  //   location.onLocationChanged.listen((LocationData currentLocation) {
  //     lat.value = currentLocation.latitude!;
  //     log.value = currentLocation.longitude!;

  //     print('calling');
  //     // Use current location
  //   });
  // }
}
