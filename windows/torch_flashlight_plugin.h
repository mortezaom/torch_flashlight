#ifndef FLUTTER_PLUGIN_TORCH_FLASHLIGHT_PLUGIN_H_
#define FLUTTER_PLUGIN_TORCH_FLASHLIGHT_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace torch_flashlight {

class TorchFlashlightPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  TorchFlashlightPlugin();

  virtual ~TorchFlashlightPlugin();

  // Disallow copy and assign.
  TorchFlashlightPlugin(const TorchFlashlightPlugin&) = delete;
  TorchFlashlightPlugin& operator=(const TorchFlashlightPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace torch_flashlight

#endif  // FLUTTER_PLUGIN_TORCH_FLASHLIGHT_PLUGIN_H_
