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
    let commandCenter: MPRemoteCommandCenter = MPRemoteCommandCenter.shared()
    let infoCenter: MPNowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
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
                        
                        update(player: self.player, infoCenter: self.infoCenter)
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
                        
                        update(player: self.player, infoCenter: self.infoCenter)
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
            self.player = initialize()
            
            // handler for InfoCenter play
            self.commandCenter.playCommand.addTarget { _ in
                //                if self.player.rate == 0.0 {
                self.player.play()
                self.player.rate = 1.0
                
                update(player: self.player, infoCenter: self.infoCenter)
                
                return .success
                //                return .commandFailed
            }
            
            // handler for InfoCenter pause
            self.commandCenter.pauseCommand.addTarget { _ in
                self.player.pause()
                self.player.rate = 0.0
                
                update(player: self.player, infoCenter: self.infoCenter)
                
                return .success
                //                return .commandFailed
            }
            
            update(player: self.player, infoCenter: self.infoCenter)
        }
    }
}

func initialize() -> AVAudioPlayer? {
    let sound = Bundle.main.path(forResource: "alright-radio-edit-kendrick-lamar", ofType: "mp3")
    
    let sharedInstance = AVAudioSession.sharedInstance()
    
    do {
        try sharedInstance.setMode(.default)
        try sharedInstance.setActive(true, options: .notifyOthersOnDeactivation)
        try sharedInstance.setCategory(AVAudioSession.Category.playback)
        
        return try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
    } catch {
        print("error")
    }
    
    return nil
}

func update(player: AVAudioPlayer, infoCenter: MPNowPlayingInfoCenter) {
    var nowPlayingInfo = [String : Any]()
    
    nowPlayingInfo[MPMediaItemPropertyTitle] = "Media"
    if let image = UIImage(named: "lockscreen") {
        nowPlayingInfo[MPMediaItemPropertyArtwork] = MPMediaItemArtwork(boundsSize: image.size) { _ in
            return image
        }
    }
    nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = player.currentTime
    nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = player.duration
    nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player.rate
    
    infoCenter.nowPlayingInfo = nowPlayingInfo
    
    print(infoCenter.nowPlayingInfo!)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
