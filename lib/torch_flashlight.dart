import 'dart:math';
import 'torch_flashlight_platform_interface.dart';
import 'dart:async';
import 'package:flutter/services.dart';

class TorchFlashlight {
  static const _channelIdentifier = 'torch_flashlight';
  static const _eventTorchAvailable = 'torch_available';
  static const _eventEnableTorch = 'enable_torch';
  static const _errorExistingUserEnableTorch =
      'enable_torch_error_existent_user';
  static const _errorTorchNotAvailableEnable = 'enable_torch_not_available';
  static const _eventDisableTorch = 'disable_torch';
  static const _errorExistingUserDisableTorch =
      'disable_torch_error_existent_user';
  static const _errorTorchNotAvailableDisable = 'disable_torch_not_available';
  static const MethodChannel _methodChannel = MethodChannel(_channelIdentifier);

  static Timer? _periodicTimer;

  // ### isTorchAvailable()
  // This method checks if the torch (flashlight) functionality is available on the device.
  // It does this by invoking a method on the platform channel named `_eventTorchAvailable`.
  // If the method invocation is successful, it returns a boolean value indicating whether the torch is available.
  // If the invocation fails due to a `PlatformException`, it throws an `EnableFlashlightException` with an error message.
  static Future<bool> isTorchFlashlightAvailable() async {
    try {
      return await _methodChannel.invokeMethod(_eventTorchAvailable) as bool;
    } on PlatformException catch (e) {
      throw EnableFlashlightException(message: e.message);
    }
  }

  //
  // ### enableTorch()
  // The `enableTorch` method is responsible for turning on the torch (flashlight) on the device.
  // It achieves this by invoking a method on the platform channel named `_eventEnableTorch`.
  // If the invocation is successful, the torch is turned on. If an exception occurs during the invocation, the method handles it by checking the error code.
  // If the error code indicates that the torch is already enabled for the user (`_errorExistingUserEnableTorch`), it throws an `ExistingFlashlightEnableException` with an error message.
  // If the torch is not available (`_errorTorchNotAvailableEnable`), it throws an `EnableTorchNotAvailableException` with an error message.
  static Future<void> enableTorchFlashlight() async {
    try {
      await _methodChannel.invokeMethod(_eventEnableTorch);
    } on PlatformException catch (e) {
      switch (e.code) {
        case _errorExistingUserEnableTorch:
          throw ExistingFlashlightEnableException(message: e.message);
        case _errorTorchNotAvailableEnable:
          throw EnableTorchNotAvailableException(message: e.message);
        default:
          throw EnableFlashlightException(message: e.message);
      }
    }
  }

  // ### disableTorch()
  // The `disableTorch` method is responsible for turning off the torch (flashlight) on the device.
  // It achieves this by invoking a method on the platform channel named `_eventDisableTorch`.
  // If the invocation is successful, the torch is turned off.
  // If an exception occurs during the invocation, the method handles it by checking the error code.
  // If the error code indicates that the torch is already disabled for the user (`_errorExistingUserDisableTorch`), it throws a `DisableTorchExistentUserException` with an error message.
  // If the torch is not available (`_errorTorchNotAvailableDisable`), it throws a `FlashlightDisabledException` with an error message.
  static Future<void> disableTorchFlashlight() async {
    try {
      await _methodChannel.invokeMethod(_eventDisableTorch);
    } on PlatformException catch (e) {
      switch (e.code) {
        case _errorExistingUserDisableTorch:
          throw DisableTorchExistentUserException(message: e.message);
        case _errorTorchNotAvailableDisable:
          throw FlashlightDisabledException(message: e.message);
        default:
          throw FlashlightOffException(message: e.message);
      }
    }
  }

  // ### torchEnableDisablePeriodically()
  // The `torchEnableDisablePeriodically` method enables and disables the torch (flashlight) periodically. It takes several parameters:
  //
  // - `onOffInterval`: Specifies the interval between enabling and disabling the torch.
  // - `stopAfterDuration`: Specifies the duration after which the torch should be automatically disabled. The default is 1 hour.
  // - `disableTorchRandomlyInSeconds`, `disableTorchRandomlyInMinutes`, `disableTorchRandomlyInHours`: These flags allow the torch to be randomly disabled after a certain time in seconds, minutes, or hours, respectively.
  //
  // The method sets up a timer to toggle the torch state at the specified `onOffInterval`. It also sets up a timer to stop the periodic toggling after `stopAfterDuration`. Additionally, it includes logic to randomly disable the torch if the corresponding flags are set to `true`.
  // - Random disabling in seconds takes priority over random disabling in minutes and hours.
  // - Random disabling in minutes takes priority over random disabling in hours.
  //
  // If all `disableTorchRandomlyInSeconds`, `disableTorchRandomlyInMinutes`, and `disableTorchRandomlyInHours` are set to `true`, the priority is as follows:
  // Overall, the `TorchFlashlight` class provides a comprehensive set of methods to manage the torch (flashlight) functionality on the device, including checking availability, enabling, disabling, and toggling the torch periodically.

  static Future<void> torchFlashlightEnableDisablePeriodically({
    required Duration onOffInterval,
    Duration stopAfterDuration = const Duration(hours: 1),
    bool disableTorchRandomlyInSeconds = false,
    bool disableTorchRandomlyInMinutes = false,
    bool disableTorchRandomlyInHours = false,
  }) async {
    _periodicTimer?.cancel();
    bool isTorchEnabled = false;
    int randomSeconds = Random().nextInt(60);
    int randomMinutes = Random().nextInt(60);
    int randomHours = Random().nextInt(24);

    print('randomSeconds: $randomSeconds');
    print('randomMinutes: $randomMinutes');
    print('randomHours: $randomHours');

    void toggleTorch() {
      if (isTorchEnabled) {
        disableTorchFlashlight().catchError(
            (e) => FlashlightOffException(message: 'Error disabling torch: $e'));
      } else {
        enableTorchFlashlight().catchError(
            (e) => FlashlightOffException(message: 'Error enabling torch: $e'));
      }
      isTorchEnabled = !isTorchEnabled;
    }

    _periodicTimer = Timer.periodic(onOffInterval, (timer) {
      toggleTorch();
    });

    Timer(stopAfterDuration, () {
      _periodicTimer?.cancel();
      if (isTorchEnabled) {
        disableTorchFlashlight().catchError(
            (e) => FlashlightOffException(message: 'Error disabling torch: $e'));
        isTorchEnabled = false;
      }
    });

    List<Future> futures = [];

    if (disableTorchRandomlyInSeconds) {
      futures.add(Future.delayed(Duration(seconds: randomSeconds)));
    }

    if (disableTorchRandomlyInMinutes) {
      futures.add(Future.delayed(Duration(minutes: randomMinutes)));
    }

    if (disableTorchRandomlyInHours) {
      futures.add(Future.delayed(Duration(hours: randomHours)));
    }

    if (futures.isNotEmpty) {
      await Future.any(futures);
      _periodicTimer?.cancel();
      if (isTorchEnabled) {
        disableTorchFlashlight().catchError(
            (e) => FlashlightOffException(message: 'Error disabling torch: $e'));
        isTorchEnabled = false;
      }
    }
  }

  /// Stops the torch flashlight from flashing periodically by canceling any existing timer.
  /// If disabling the torch flashlight encounters an error, it throws a custom `FlashlightOffException`.
  static Future<void> stopTorchFlashlightPeriodically() async {
    try {
      // Cancel any existing periodic timer.
      _periodicTimer?.cancel();

      // Attempt to disable the torch flashlight, catching any errors and throwing a custom exception.
      disableTorchFlashlight().catchError(
              (e) => FlashlightOffException(message: 'Error disabling torch: $e'));
    } catch (e) {
      // If an error occurs, throw a custom exception with the error message.
      throw FlashlightOffException(message: e.toString());
    }
  }

}
