import 'package:flutter_test/flutter_test.dart';
import 'package:torch_flashlight/torch_flashlight_platform_interface.dart';
import 'package:torch_flashlight/torch_flashlight_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockTorchFlashlightPlatform
    with MockPlatformInterfaceMixin
    implements TorchFlashlightPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final TorchFlashlightPlatform initialPlatform =
      TorchFlashlightPlatform.instance;

  test('$MethodChannelTorchFlashlight is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelTorchFlashlight>());
  });
}
