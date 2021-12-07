//
//  PlaybackDelegate.swift
//  PlaybackAPISample
//
//  Created by Gleb Markin on 7.12.21.
//

import Foundation
import AVFoundation
import VEPlaybackSDK

// MARK: - VideoEditorPlayerDelegate
extension ViewController: VideoEditorPlayerDelegate {
  func playerPlaysFrame(_ player: VideoEditorPlayable, atTime time: CMTime) {
    print(time.seconds)
  }
  
  func playerDidEndPlaying(_ player: VideoEditorPlayable) {
    print("Did end playing")
  }
}
