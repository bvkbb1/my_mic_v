import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'my_mic_v_platform_interface.dart';

/// An implementation of [MyMic_vPlatform] that uses method channels.
class MethodChannelMyMic_v extends MyMic_vPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_mic_v');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
