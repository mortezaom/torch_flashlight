import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'torch_flashlight_method_channel.dart';

abstract class TorchFlashlightPlatform extends PlatformInterface {
  /// Constructs a TorchFlashlightPlatform.
  TorchFlashlightPlatform() : super(token: _token);

  static final Object _token = Object();

  static TorchFlashlightPlatform _instance = MethodChannelTorchFlashlight();

  /// The default instance of [TorchFlashlightPlatform] to use.
  ///
  /// Defaults to [MethodChannelTorchFlashlight].
  static TorchFlashlightPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [TorchFlashlightPlatform] when
  /// they register themselves.
  static set instance(TorchFlashlightPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

class EnableTorchNotAvailableException implements Exception {
  String? message;

  EnableTorchNotAvailableException({this.message});

  @override
  String toString() => message != null
      ? "[EnableTorchNotAvailableException: $message]"
      : "[EnableTorchNotAvailableException]";
}

class DisableTorchExistentUserException implements Exception {
  String? message;

  DisableTorchExistentUserException({this.message});

  @override
  String toString() => message != null
      ? "[DisableTorchExistentUserException: $message]"
      : "[DisableTorchExistentUserException]";
}

class FlashlightOffException implements Exception {
  String? message;

  FlashlightOffException({this.message});

  @override
  String toString() => message != null
      ? "[FlashlightOffException: $message]"
      : "[FlashlightOffException]";
}

class FlashlightDisabledException implements Exception {
  String? message;

  FlashlightDisabledException({this.message});

  @override
  String toString() => message != null
      ? "[FlashlightDisabledException: $message]"
      : "[FlashlightDisabledException]";
}

class ExistingFlashlightEnableException implements Exception {
  String? message;

  ExistingFlashlightEnableException({this.message});

  @override
  String toString() => message != null
      ? "[ExistingFlashlightEnableException: $message]"
      : "[ExistingFlashlightEnableException]";
}

class EnableFlashlightException implements Exception {
  String? message;

  EnableFlashlightException({this.message});

  @override
  String toString() => message != null
      ? "[EnableFlashlightException: $message]"
      : "[EnableFlashlightException]";
}
