//
//  MediaController.swift
//  MultimediaPlayer
//
//  Created by admin on 6/6/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import AVKit
import MediaPlayer

struct MediaController {
    
    var player: AVPlayer?
    let commandCenter: MPRemoteCommandCenter = MPRemoteCommandCenter.shared()
    let infoCenter: MPNowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    func playMedia(filename: String) {
        player?.play()
        player?.rate = 1.0
        
        update(filename: filename)
    }
    
    func pauseMedia(filename: String) {
        player?.pause()
        player?.rate = 0.0
        
        update(filename: filename)
    }
    
    func playInfoCenterHandler(filename: String?) {
        // handler for InfoCenter play
        commandCenter.playCommand.removeTarget(nil)
        commandCenter.playCommand.addTarget { _ in
            self.player?.play()
            self.player?.rate = 1.0
            
            self.update(filename: filename)
            
            return .success
        }
    }
    
    func pauseInfoCenterHandler(filename: String?) {
        // handler for InfoCenter pause
        commandCenter.pauseCommand.removeTarget(nil)
        commandCenter.pauseCommand.addTarget { _ in
            self.player?.pause()
            self.player?.rate = 0.0
            
            self.update(filename: filename)
            
            return .success
        }
    }
    
    mutating func loadMedia(url: URL?) -> String? {
        player?.pause()
        
        let sharedInstance = AVAudioSession.sharedInstance()
        
        do {
            try sharedInstance.setMode(.default)
            try sharedInstance.setActive(true, options: .notifyOthersOnDeactivation)
            try sharedInstance.setCategory(AVAudioSession.Category.playback)
            
            player = AVPlayer(url: url!)
            
            let filename = url?.lastPathComponent
            update(filename: filename)
            playInfoCenterHandler(filename: filename)
            pauseInfoCenterHandler(filename: filename)
            
            return filename
        } catch {
            print("error")
        }
        
        return nil
    }
    
    mutating func loadMedia(fileURLWithPath: String, ofType: String?) -> String? {
        let media = Bundle.main.url(forResource: fileURLWithPath, withExtension: ofType)
        
        return loadMedia(url: media)
    }
    
    func update(filename: String?) {
        var nowPlayingInfo = [String : Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = filename
        if let image = UIImage(named: "lockscreen") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { _ in
                return image
            }
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player?.currentTime().seconds
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player?.currentItem?.asset.duration.seconds
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player?.rate
        
        infoCenter.nowPlayingInfo = nowPlayingInfo
        
        // print(infoCenter.nowPlayingInfo!)
    }
    
}
