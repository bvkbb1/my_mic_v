library my_mic_v;

export 'my_mic_widget.dart';
import 'my_mic_v_platform_interface.dart';

class MyMic_v {
  Future<String?> getPlatformVersion() {
    return MyMic_vPlatform.instance.getPlatformVersion();
  }
}
