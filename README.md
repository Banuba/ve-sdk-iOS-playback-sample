[![](https://www.banuba.com/hubfs/Banuba_November2018/Images/Banuba%20SDK.png)](https://www.banuba.com/video-editor-sdk)

# Video Editor SDK. Playback Integration sample for iOS.

- [Requirements](#Requirements)
- [Supported media formats](#Supported-media-formats)
- [Token](#Token)
- [Getting Started](#Getting-Started)
    + [CocoaPods](#CocoaPods)
    + [Configure edit flow](#Configure-edit-flow)
    + [Configure effects](#Configure-effects)
    + [Configure playback view](#Configure-playback-view) 
- [API Reference](#API-Reference)
    + [Playback API](#Playback-API)
    + [Effects API](#Effects-API)
    + [Core API](#Core-API)


## Requirements
This is what you need to run the AI Video Editor SDK

- iPhone devices 6+
- Swift 5+
- Xcode 13+
- iOS 12.0+
Unfortunately, It isn't optimized for iPads.

## Supported media formats
| Audio      | Video      |
| ---------- | ---------  | 
|.mp3, .aac, .wav, <br>.m4a, .flac, .aiff |.mp4, .mov, .m4v|

## Starting a free trial

You should start with getting a trial token. It will grant you **14 days** to freely play around with the AI Video Editor SDK and test its entire functionality the way you see fit.

There is nothing complicated about it - [contact us](https://www.banuba.com/video-editor-sdk) or send an email to sales@banuba.com and we will send it to you. We can also send you a sample app so you can see how it works “under the hood”.

## Token 
We offer а free 14-days trial for you could thoroughly test and assess Video Editor SDK functionality in your app. To get access to your trial, please, get in touch with us by [filling a form](https://www.banuba.com/video-editor-sdk) on our website. Our sales managers will send you the trial token.

Video Editor token should be put [here](https://github.com/Banuba/ve-sdk-iOS-playback-sample/blob/84f91009a6a9624a2752f4111d1cb172b6f766e7/PlaybackAPISample/PlaybackAPISample/Sample/VideoEditorServiceInitialization.swift#L25).

## Getting Started
### CocoaPods

In the sample project there is a division into folders, such as 'sample' and 'helpers': all the functionality inherent in the API integration is in the ['sample'](https://github.com/Banuba/ve-sdk-iOS-playback-sample/tree/master/PlaybackAPISample/PlaybackAPISample/Sample) folder, auxiliary information to support the functionality of the sample is in the ['helpers'](https://github.com/Banuba/ve-sdk-iOS-playback-sample/tree/master/PlaybackAPISample/PlaybackAPISample/Helpers) folder.

The easiest way to integrate the Video Editor SDK in your mobile app is through [CocoaPods](https://cocoapods.org). If you haven’t used this dependency manager before, see the [Getting Started Guide](https://guides.cocoapods.org/using/getting-started.html).

Important: Make sure that you have CocoaPods version >= 1.11.0 installed. Check your CocoaPods version using this command [pod --version]

Please, refer to the example of [Podfile](https://github.com/Banuba/ve-sdk-iOS-playback-sample/blob/master/PlaybackAPISample/Podfile) lines which you need to add.

1. Make sure to have CocoaPods installed, e.g. via Homebrew:
   ```sh
   brew install cocoapods 
   ```
2. Initialize pods in your project folder (if you didn't do it before).
   ```sh
   pod init
   ```
3. Install the Video Editor SDK for the provided Xcode workspace with:
```sh
pod install
```
4. Open Example.xcworkspace with Xcode and run the project.  

### Configure edit flow

Before displaying playable video you need to add your video asset to existing `VideoEditorService` instance.

``` swift
    // Add video to the sequence
    let videoSequence = VideoSequence(folderURL: folderURL)
    videoSequence.addVideo(at: videoFileURL)

    // Create VideoEditorAsset from relevant sequence
    let videoEditorAsset = VideoEditorAsset(
      sequence: videoSequence,
      isGalleryAssets: true,
      isSlideShow: false,
      videoResolutionConfiguration: videoResolutionConfiguration
    )
    
    // Set cuurent video asset to video editor service
    videoEditorService.setCurrentAsset(videoEditorAsset)
```
See the sample edit video flow [here](https://github.com/Banuba/ve-sdk-iOS-playback-sample/blob/6fe21fc1f2c253c585f09ca6295f4c31a0b8b9ea/PlaybackAPISample/PlaybackAPISample/Sample/ProcessingFunctionality%20.swift#L40).

Before displaying you need to apply default rotate transform:
``` swift
    // Expected non-zero video aspect ratio constructor. Apply transform effect after adding required asset.
    // Apply temporary original rotation.
    let originalRotation: AssetRotation = .rotate90
    effectApplicator?.addTransformEffect(atStartTime: .zero, end: .indefinite, rotation: originalRotation)
```

See the example of rotate transformation [here](https://github.com/Banuba/ve-sdk-iOS-playback-sample/blob/6fe21fc1f2c253c585f09ca6295f4c31a0b8b9ea/PlaybackAPISample/PlaybackAPISample/Sample/ProcessingFunctionality%20.swift#L45).

### Configure effects

You can add an effect objects such as gif/text, viasual, speed, color to playback video. 

To be able to use following functionality you need to operate on `EffectApplicator` entity.

Please, checkout [example](https://github.com/Banuba/ve-sdk-iOS-playback-sample/blob/84f91009a6a9624a2752f4111d1cb172b6f766e7/PlaybackAPISample/PlaybackAPISample/Sample/EffectsApplicator.swift#L15)

``` swift
/// EffectApplicator allows you to add GIF and text effects to your existing VideoEditorServiсe composition
public class EffectApplicator {
  /// EffectApplicator constructor
  /// - Parameters:
  ///   - editor: Instance of existing VideoEditorService
  ///   - editor: Instance of existing EditorEffectsConfigHolder
  init(
    editor: VideoEditorServicing,
    effectConfigHolder: EffectsHolderServicing
  )
  
  /// Allows you to add visual effects with required settings.
  /// - Parameters:
  ///   - type: Describes what kind of effect needs to be added
  ///   - startTime: When effect starts
  ///   - endTime: When effect ends
  ///   - removeSameType: Remove same effect if exist
  ///   - effectId: Unic effect id
  func applyVisualEffectApplicatorType(
    _ type: VisualEffectApplicatorType,
    startTime: CMTime,
    endTime: CMTime,
    removeSameType: Bool,
    effectId: UInt
  )
  
  /// Allows you to add speed effects with required settings.
  /// - Parameters:
  ///   - type: Describes what kind of effect needs to be added
  ///   - startTime: When effect starts
  ///   - endTime: When effect ends
  ///   - removeSameType: Remove same effect if exist
  ///   - effectId: Unic effect id
  func applySpeedEffectType(
    _ type: SpeedEffectType,
    startTime: CMTime,
    endTime: CMTime,
    removeSameType: Bool,
    effectId: UInt
  )
  
  /// Allows you to add GIF or text effects with required settings.
  /// - Parameters:
  ///   - type: Describes what kind of effect needs to be added
  ///   - effectInfo: Contains all the information you need to add effects to your video.
  func applyOverlayEffectType(
    _ type: OverlayEffectApplicatorType,
    effectInfo: VideoEditorEffectInfo
  )
  
  /// Allows you to add rotation effect with required settings.
  /// - Parameters:
  ///   - atStartTime: When effect is need to be start
  ///   - end: When effect is need to be end
  ///   - rotation: Video rotation settings
  func addTransformEffect(
    atStartTime start: CMTime,
    end: CMTime,
    rotation: AssetRotation
  )
}
```

### Configure playback view

To be able to use following functionality you need to operate on `VEPlayback` entity.

`VEPlayback` consist of two public funcs, such as `getPlayer` and `getPlayableView`. First one allows you to create your own view which could be communicate with player instance. Second one allows you to get prepared view with player implementation.

``` swift
  /// Allows you to get player instance with current videoEditorService asset composition.
  /// - parameters:
  ///   - forAsset: Relevant asset. Except current videoEditorService asset composition.
  ///   - delegate: Delegation link.
  public func getPlayer(
    forExternalAsset asset: AVAsset? = nil,
    delegate: VideoEditorPlayerDelegate?
  ) -> VideoEditorPlayable
  
  /// Allows you to get playable view instance with current videoEditorService asset composition.
  /// - parameters:
  ///   - isThumbnailNeeded: Allows you to create preview thumbnail for UIImageView image reference. Default is true.
  ///   - forAsset: Relevant asset. Except current videoEditorService asset composition.
  ///   - delegate: Delegation link.
  public func getPlayableView(
    isThumbnailNeeded: Bool = true,
    forExternalAsset asset: AVAsset? = nil,
    delegate: VideoEditorPlayerDelegate?
  ) -> VideoPlayableView
```

Please, checkout [example](https://github.com/Banuba/ve-sdk-iOS-playback-sample/blob/6fe21fc1f2c253c585f09ca6295f4c31a0b8b9ea/PlaybackAPISample/PlaybackAPISample/Sample/PlaybackFunctionality.swift#L18)

## API Reference

Framework API's which implemented with playback-sample.

### Playback API

`VEPlaybackSDK` allows you to display already setuped video composition from [Core API](https://github.com/Banuba/VideoEditor-iOS) and optionally edited with [Effects API](https://github.com/Banuba/BanubaVideoEditorEffectsSDK-iOS). So [Core API](https://github.com/Banuba/VideoEditor-iOS) is requires usage for `VEPlaybackSDK`.

[API Reference](https://github.com/Banuba/VEPlaybackSDK-iOS)

### Effects API

`VEEffectsSDK` allows you to edit video composition which already setuped in [Core API](https://github.com/Banuba/VideoEditor-iOS). So [Core API](https://github.com/Banuba/VideoEditor-iOS) is requires usage for `VEEffectsSDK`.

[API Reference](https://github.com/Banuba/BanubaVideoEditorEffectsSDK-iOS)


### Core API

`VideoEditor` is a core module for interaction between playback modules, export, etc. All transformations with effects, sounds, time, trimming take place inside this module. In order to use exporting, applying effects, or getting a player, first you need to use the essence of the `VideoEditorService` entity and add the necessary video segments or assets to it.

[API Reference](https://github.com/Banuba/VideoEditor-iOS)
