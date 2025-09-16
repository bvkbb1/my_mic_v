import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'my_mic_v_method_channel.dart';

abstract class MyMic_vPlatform extends PlatformInterface {
  /// Constructs a MyMic_vPlatform.
  MyMic_vPlatform() : super(token: _token);

  static final Object _token = Object();

  static MyMic_vPlatform _instance = MethodChannelMyMic_v();

  /// The default instance of [MyMic_vPlatform] to use.
  ///
  /// Defaults to [MethodChannelMyMic_v].
  static MyMic_vPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MyMic_vPlatform] when
  /// they register themselves.
  static set instance(MyMic_vPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
