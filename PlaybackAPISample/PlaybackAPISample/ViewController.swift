//
//  ViewController.swift
//  PlaybackAPISample
//
//  Created by Gleb Markin on 7.12.21.
//

import UIKit
import VideoEditor
import VEPlaybackSDK
import VEEffectsSDK
import BanubaUtilities

class ViewController: UIViewController {
  
  // MARK: - Player container
  @IBOutlet weak var playerContainerView: UIView!
  
  // MARK: - Video editor service instance
  var videoEditorService: VideoEditorService?
  
  // MARK: - EffectApplicator instance
  var effectApplicator: EffectApplicator?
  
  // MARK: - VEPlayback
  var playbackAPI: VEPlayback?
  
  // MARK: - VideoPlayableView
  var playableView: VideoPlayableView?

  // MARK: - AppStateObserver
  var appStateObserver: AppStateObserver?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    playerContainerView.isHidden = true
    // Initialize VideoEditorService with input params
    initializeVideoEditorService()
    // Sign app state observer delegate
    setupAppStateHandler()
  }
}

// MARK: - Actions
extension ViewController {
  @IBAction func openVideoButtonTapped(_ sender: UIButton) {
    openGallery() { [weak self] videoFileURL in
      self?.playerContainerView.isHidden = false
      
      self?.processVideo(videoFileURL: videoFileURL)
      self?.setupPlaybackView()
    }
  }
}
