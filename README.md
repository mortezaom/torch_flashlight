# torch_flashlight

A Flutter plugin for controlling the torch (flashlight) on/off functionality in mobile devices.

[![pub package](https://img.shields.io/pub/v/torch_flashlight.svg)](https://pub.dev/packages/torch_flashlight)


## Features

### Check Torch Availability

Determines if the torch functionality is available on the device. This feature allows your app to check whether the device has a torch (flashlight) and whether it's accessible for use.

### Enable Torch

Enables the torch (flashlight) on the device. This feature turns on the torch, allowing users to utilize their device's flashlight functionality within your app.

### Disable Torch

Disables the torch (flashlight) on the device. This feature turns off the torch, ensuring that the flashlight functionality is no longer active within your app.

### Toggle Torch Periodically

Toggles the torch (flashlight) periodically at specified intervals. This feature allows your app to automatically turn the torch on and off at regular intervals, providing a flashing effect. It can be useful for creating attention-grabbing visual effects or for signaling purposes.

## Installation

Add `torch_flashlight` to your `pubspec.yaml` file:

```yaml
dependencies:
  torch_flashlight: ^0.0.2
```

Install the package by running:

```dart
flutter pub get
```

Import the package in your Dart code:

```dart
import 'package:torch_flashlight/torch_flashlight.dart';
```

## Usage

### Check Torch Availability

To check if the torch functionality is available on the device:

```dart
  bool isAvailable = await TorchFlashlight.isTorchFlashlightAvailable();
```

### Enable Torch

To enable the torch (flashlight) on the device:

```dart
  await TorchFlashlight.enableTorchFlashlight();
```

### Disable Torch

To disable the torch (flashlight) on the device:

```dart
  await TorchFlashlight.disableTorchFlashlight();
```

### Toggle Torch Periodically

To toggle the torch (flashlight) periodically:

```dart

  await TorchFlashlight.torchFlashlightEnableDisablePeriodically(
    onOffInterval: Duration(seconds: 1),
    disableTorchRandomlyInSeconds: true,
  );
```

### Stop Torch Toggling

To stop the torch (flashlight) from toggling periodically:

```dart
  await TorchFlashlight.stopTorchFlashlightPeriodically();
```

## API Reference

Please refer to the [API Reference](https://pub.dev/documentation/torch_flashlight/latest/) for detailed information on each method.

## Support

For help on usage or to report issues, please [open an issue](https://github.com/shirsh94/torch_flashlight/issues).

## License

The MIT License (MIT) Copyright (c) 2024 Shirsh Shukla

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
associated documentation files (the "Software"), to deal in the Software without restriction,
including without limitation the rights to use, copy, modify, merge, publish, distribute,
sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial
portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT
NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES
OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.