//
//  ContentView.swift
//  AudioPlayer
//
//  Created by Admin on 6/6/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftUI
import AVKit
import MediaPlayer

struct ContentView: View {
    @State var player: AVAudioPlayer!
    // Initialize
    let commandCenter = MPRemoteCommandCenter.shared()
    let infoCenter = MPNowPlayingInfoCenter.default()
    
    var body: some View {
        ZStack {
            Color
                .black
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Media Player")
                        .font(.system(size: 45))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                HStack {
                    Spacer()
                    
                    // play button
                    Button(action: {
                        self.player.play()
                        self.player.rate = 1.0
                        
                        var nowPlayingInfo = [String : Any]()
                        nowPlayingInfo[MPMediaItemPropertyTitle] = "Media"
                        if let image = UIImage(named: "lockscreen") {
                            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                                return image
                            }
                        }
                        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.player.currentTime
                        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.player.duration
                        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.player.rate
                        self.infoCenter.nowPlayingInfo = nowPlayingInfo
                        
                        print(self.infoCenter.nowPlayingInfo!)
                    }) {
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // pause button
                    Button(action: {
                        self.player.pause()
                        self.player.rate = 0.0
                        
                        var nowPlayingInfo = [String : Any]()
                        nowPlayingInfo[MPMediaItemPropertyTitle] = "Media"
                        if let image = UIImage(named: "lockscreen") {
                            nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                                return image
                            }
                        }
                        nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.player.currentTime
                        nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.player.duration
                        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.player.rate
                        self.infoCenter.nowPlayingInfo = nowPlayingInfo
                        
                        print(self.infoCenter.nowPlayingInfo!)
                    }) {
                        Image(systemName: "pause.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                }
                
            }
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "alright-radio-edit-kendrick-lamar", ofType: "mp3")
            
            let sharedInstance = AVAudioSession.sharedInstance()
            
            do {
                try sharedInstance.setMode(.default)
                try sharedInstance.setActive(true, options: .notifyOthersOnDeactivation)
                try sharedInstance.setCategory(AVAudioSession.Category.playback)
                
                self.player = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
            } catch {
                print("error occurred")
            }
            
            // Add handler for Play Command
            self.commandCenter.playCommand.addTarget { _ in
                //                if self.player.rate == 0.0 {
                self.player.play()
                self.player.rate = 1.0
                
                var nowPlayingInfo = [String : Any]()
                nowPlayingInfo[MPMediaItemPropertyTitle] = "Media"
                if let image = UIImage(named: "lockscreen") {
                    nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                        return image
                    }
                }
                nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.player.currentTime
                nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.player.duration
                nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.player.rate
                self.infoCenter.nowPlayingInfo = nowPlayingInfo
                
                print(self.infoCenter.nowPlayingInfo!)
                
                //                    _ = try? sharedInstance.setActive(true)
                
                
                
                return .success
                //                }
                //                return .commandFailed
            }
            
            // Add handler for Pause Command
            self.commandCenter.pauseCommand.addTarget { _ in
                //                if self.player.rate == 1.0 {
                self.player.pause()
                self.player.rate = 0.0
                
                var nowPlayingInfo = [String : Any]()
                nowPlayingInfo[MPMediaItemPropertyTitle] = "Media"
                if let image = UIImage(named: "lockscreen") {
                    nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                        return image
                    }
                }
                nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.player.currentTime
                nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.player.duration
                nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.player.rate
                self.infoCenter.nowPlayingInfo = nowPlayingInfo
                
                print(self.infoCenter.nowPlayingInfo!)
                
                //                    _ = try? sharedInstance.setActive(false)
                
                return .success
                //                }
                //                return .commandFailed
            }
            
            var nowPlayingInfo = [String : Any]()
            nowPlayingInfo[MPMediaItemPropertyTitle] = "Media"
            if let image = UIImage(named: "lockscreen") {
                nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { size in
                    return image
                }
            }
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = self.player.currentTime
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self.player.duration
            nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = self.player.rate
            self.infoCenter.nowPlayingInfo = nowPlayingInfo
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
