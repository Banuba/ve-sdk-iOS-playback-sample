//
//  ExportFunctionality .swift
//  ExportAPISample
//
//  Created by Gleb Markin on 1.09.21.
//

import Foundation

// Banuba Modules
import VideoEditor
import VEEffectsSDK

// MARK: - Processing Helpers
extension ViewController {
  func processVideo(videoFileURL: URL) {
    guard let videoEditorService = self.videoEditorService else {
      return
    }
    
    // Get sequence folder url
    let folderURL = prepareSequenceFolderURL()
    
    // Add video to the sequence
    let videoSequence = VideoSequence(folderURL: folderURL)
    videoSequence.addVideo(
      at: videoFileURL,
      isSlideShow: false,
      transition: .normal
    )
    
    // Get video resolution configuration
    let videoResolutionConfiguration = prepareVideoResolutionConfiguration()
    
    // Create VideoEditorAsset from relevant sequence
    let videoEditorAsset = VideoEditorAsset(
      sequence: videoSequence,
      isGalleryAssets: true,
      isSlideShow: false,
      videoResolutionConfiguration: videoResolutionConfiguration
    )
    
    // Set cuurent video asset to video editor service
    videoEditorService.setCurrentAsset(videoEditorAsset)

    // Expected non-zero video aspect ratio constructor. Apply transform effect after adding required asset.
    // Apply temporary original rotation.
    let originalRotation: AssetRotation = .rotate90
    effectApplicator?.addTransformEffect(atStartTime: .zero, end: .indefinite, rotation: originalRotation, isVideoFitsAspect: false)
    
    // Apply gif effect after transforming and adding relevant video editor asset
    applyOverlayEffect(withType: .gif)
    applyOverlayEffect(withType: .text)
    
    // Apply color effect
    applyColorEffect()
    // Apply visual effect
    applyVisualEffect(withType: .vhs)
    // Apply speed effect
    applySpeedEffect(withType: .slowmo)
  }
}
