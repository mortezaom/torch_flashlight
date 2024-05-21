//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <torch_flashlight/torch_flashlight_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) torch_flashlight_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "TorchFlashlightPlugin");
  torch_flashlight_plugin_register_with_registrar(torch_flashlight_registrar);
}
