import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:provider_medical_valley/core/shared_pref/shared_pref.dart';
import 'package:provider_medical_valley/features/home/home_screen/data/api/fcm_client.dart';

enum UserIdentityType { Admin, Provider, PublicUser }

enum DeviceType { Android, IOS, WEB }

class UpdateFcmUseCase {
  FcmClient client;

  UpdateFcmUseCase(this.client);

  Future<void> updateFcmToken() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    final fcmToken = await FirebaseMessaging.instance.getToken();
    String deviceId = "";
    int deviceType = 0;
    final userId = LocalStorageManager.getUser()!['id'];
    if (Platform.isAndroid) {
      deviceType = DeviceType.Android.index;
      await deviceInfo.androidInfo.then((value) => deviceId = value.id);
    } else {
      deviceType = DeviceType.IOS.index;
      await deviceInfo.iosInfo
          .then((value) => deviceId = value.identifierForVendor!);
    }
    await client.updateFcmToken(
      fcmToken: fcmToken ?? "",
      deviceId: deviceId,
      deviceType: deviceType,
      userId: userId,
      userIdentityType: UserIdentityType.Provider.index,
    );
  }
}
