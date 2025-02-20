import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io' show Platform;

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    
    // Force portrait mode
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Add any initialization code here
    await Future.wait([
      // Add your async initializations here
    ]);

    runApp(const MyApp());
  }, (error, stack) {
    if (kDebugMode) {
      print('🔴 Fatal error: $error');
      print(stack);
    }
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('MDM Tool')),
        body: Center(
          child: Column(
            children: [
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final url = Uri.parse('https://support.apple.com/guide/iphone/remove-configuration-profiles-iph3dafcb5d/ios');
                  try {
                    if (Platform.isIOS || Platform.isAndroid) {
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: Platform.isIOS
                              ? LaunchMode.externalApplication
                              : LaunchMode.platformDefault,
                        );
                      } else {
                        throw Exception('Could not launch URL');
                      }
                    } else {
                      throw Exception('Unsupported platform');
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Open MDM Removal Guide'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  try {
                    final deviceInfo = DeviceInfoPlugin();
                    if (Platform.isIOS) {
                      final iosInfo = await deviceInfo.iosInfo;
                      final isPhysicalDevice = iosInfo.isPhysicalDevice;
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Device Status'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Physical Device: $isPhysicalDevice'),
                              SizedBox(height: 10),
                              Text('Device: ${iosInfo.name}'),
                              Text('Model: ${iosInfo.model}'),
                              Text('System: iOS ${iosInfo.systemVersion}'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('OK'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      throw Exception('This feature is only available on iOS devices');
                    }
                  } catch (e) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text('Error'),
                        content: Text(e.toString()),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('OK'),
                          ),
                        ],
                      ),
                    );
                  }
                },
                child: Text('Check Supervision Status'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(200, 50),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
