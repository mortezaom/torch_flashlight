#include "include/torch_flashlight/torch_flashlight_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "torch_flashlight_plugin.h"

void TorchFlashlightPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  torch_flashlight::TorchFlashlightPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
