//
//  PlaybackFunctionality.swift
//  PlaybackAPISample
//
//  Created by Gleb Markin on 7.12.21.
//

import Foundation
import BanubaUtilities

// MARK: - Playback Helpers
extension ViewController {
  func setupPlaybackView() {
    // Check if Playable View already exist
    if let currentView = playableView {
      currentView.removeFromSuperview()
    }
    // Get playable view
    guard let view = playbackAPI?.getPlayableView(delegate: self) else {
      return
    }
    playableView = view
    // Setup view frame
    view.frame = playerContainerView.frame
    playerContainerView.addSubview(view)
    
    self.view.layoutIfNeeded()
    // Start playing
    playableView?.videoEditorPlayer?.startPlay(loop: true, fixedSpeed: false)
  }
}
