#import "TorchLightPlugin.h"

@implementation TorchLightPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftTorchLightPlugin registerWithRegistrar:registrar];
}
@end