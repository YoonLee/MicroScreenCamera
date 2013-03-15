<p align="center">
<img src="https://2aq3qw.bn1.livefilestore.com/y1pa2ySJFMFU-B98mXIzSFvRF0_eA3XjiPLZVKoiT3qGunYRkJyb6_UjfstVCGckvwTlRM9OnNgOdAigirPaFoe7Q1cgy09gSZc/Demo.png">
</p>

Usage
======
```obj
// Frameworks
AudioToolBox, AssetsLibrary, AVFoundation

// Sample code.
    // MODULE!!!
    CameraModuleView *cameraModule = [[CameraModuleView alloc] initWithFrame:CGRectMake(0, 0, 220, 220)];
    [cameraModule setCenter:CGPointMake(deviceScreen().size.width / 2, 220.0f)];
    [self.view addSubview:cameraModule];
    
    // Add Observer to get notification
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionCameraModule:) name:CAMERA_SHOULD_LAUNCH_NOTIFICATION object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(actionCloseModule) name:CAMERA_SHOULD_CLOSE_NOTIFICATION object:nil];

```
