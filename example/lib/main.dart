import 'package:flutter/material.dart';
import 'dart:async';
import 'package:torch_flashlight/torch_flashlight.dart';

void main() {
  runApp(TorchApp());
}

class TorchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TorchController(),
    );
  }
}

class TorchController extends StatefulWidget {
  @override
  _TorchControllerState createState() => _TorchControllerState();
}

class _TorchControllerState extends State<TorchController> {
  bool isTorchOn = false;
  Timer? _timer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Torch App'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            child: FutureBuilder<bool>(
              future: _isTorchAvailable(),
              builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData && snapshot.data!) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 100,
                          icon: Icon(
                            isTorchOn
                                ? Icons.flashlight_on
                                : Icons.flashlight_off,
                            color: isTorchOn ? Colors.yellow : Colors.grey,
                          ),
                          onPressed: _toggleTorch,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(child: Text('No torch available.'));
                }
              },
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            icon: Icon(Icons.flash_on),
            label: const Text('Enable Torch'),
            onPressed: () => _enableTorch(),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: Icon(Icons.flash_off),
            label: const Text('Disable Torch'),
            onPressed: () => _disableTorch(),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: Icon(Icons.timer),
            label: const Text('Torch Enable Periodically'),
            onPressed: () => _torchEnablePeriodically(),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            icon: Icon(Icons.timer),
            label: const Text('Stop Torch Enable Periodically'),
            onPressed: () => _torchDisablePeriodically(),
          ),
        ],
      ),
    );
  }

  Future<bool> _isTorchAvailable() async {
    try {
      return await TorchFlashlight.isTorchFlashlightAvailable();
    } catch (e) {
      _showMessage('Could not check if the device has an available torch');
      return false;
    }
  }

  Future<void> _toggleTorch() async {
    if (isTorchOn) {
      await _disableTorch();
    } else {
      await _enableTorch();
    }
  }

  Future<void> _enableTorch() async {
    try {
      await TorchFlashlight.enableTorchFlashlight();
      setState(() {
        isTorchOn = true;
      });
    } catch (e) {
      _showMessage('Could not enable torch');
    }
  }

  Future<void> _disableTorch() async {
    try {
      await TorchFlashlight.disableTorchFlashlight();
      setState(() {
        isTorchOn = false;
      });
    } catch (e) {
      _showMessage('Could not disable torch');
    }
  }

  Future<void> _torchEnablePeriodically() async {
    try {
      await TorchFlashlight.torchFlashlightEnableDisablePeriodically(
        onOffInterval: const Duration(milliseconds: 300),
        disableTorchRandomlyInSeconds: true,
      );
    } catch (e) {
      _showMessage('Could not enable torch periodically');
    }
  }

  Future<void> _torchDisablePeriodically() async {
    await TorchFlashlight.stopTorchFlashlightPeriodically();
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
