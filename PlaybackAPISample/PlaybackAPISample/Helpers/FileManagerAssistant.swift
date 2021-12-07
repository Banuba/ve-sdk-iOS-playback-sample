//
//  FileManagerAssistant.swift
//  ExportAPISample
//
//  Created by Gleb Markin on 1.09.21.
//

import Foundation

// MARK: - FileManager helpers
extension ViewController {
  /// Prepare folder url for sequence container
  func prepareSequenceFolderURL() -> URL {
    let videosDirectoryName = "Videos"
    let name = UUID().uuidString

    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    let videosDirectory = documentsDirectory.appendingPathComponent(videosDirectoryName)
    
    let folderURL = videosDirectory.appendingPathComponent(name)
    
    return folderURL
  }
}
