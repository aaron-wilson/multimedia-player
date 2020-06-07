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
    
    var player: AVAudioPlayer?
    let commandCenter: MPRemoteCommandCenter = MPRemoteCommandCenter.shared()
    let infoCenter: MPNowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    func playMedia(filename: String) {
        self.player?.play()
        self.player?.rate = 1.0
        
        update(filename: filename)
    }
    
    func pauseMedia(filename: String) {
        self.player?.pause()
        self.player?.rate = 0.0
        
        update(filename: filename)
    }
    
    func playInfoCenterHandler(filename: String?) {
        // handler for InfoCenter play
        commandCenter.playCommand.removeTarget(nil)
        self.commandCenter.playCommand.addTarget { _ in
            self.player?.play()
            self.player?.rate = 1.0
            
            self.update(filename: filename)
            
            return .success
        }
    }
    
    func pauseInfoCenterHandler(filename: String?) {
        // handler for InfoCenter pause
        commandCenter.pauseCommand.removeTarget(nil)
        self.commandCenter.pauseCommand.addTarget { _ in
            self.player?.pause()
            self.player?.rate = 0.0
            
            self.update(filename: filename)
            
            return .success
        }
    }
    
    mutating func loadMedia(url: URL?) -> String? {
        self.player?.pause()
        
        let sharedInstance = AVAudioSession.sharedInstance()
        
        do {
            try sharedInstance.setMode(.default)
            try sharedInstance.setActive(true, options: .notifyOthersOnDeactivation)
            try sharedInstance.setCategory(AVAudioSession.Category.playback)
            
            self.player = try? AVAudioPlayer(contentsOf: url!)
            
            let filename = url?.lastPathComponent
            self.update(filename: filename)
            self.playInfoCenterHandler(filename: filename)
            self.pauseInfoCenterHandler(filename: filename)
            
            return filename
        } catch {
            print("error")
        }
        
        return nil
    }
    
    mutating func loadMedia(fileURLWithPath: String, ofType: String?) -> String? {
        let media = Bundle.main.url(forResource: fileURLWithPath, withExtension: ofType)
        
        return self.loadMedia(url: media)
    }
    
    func update(filename: String?) {
        var nowPlayingInfo = [String : Any]()
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = filename
        if let image = UIImage(named: "lockscreen") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { _ in
                return image
            }
        }
        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.player?.currentTime
        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.player?.duration
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.player?.rate
        
        self.infoCenter.nowPlayingInfo = nowPlayingInfo
        
        // print(self.infoCenter.nowPlayingInfo!)
    }
    
}
