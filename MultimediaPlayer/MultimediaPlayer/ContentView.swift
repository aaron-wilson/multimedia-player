//
//  ContentView.swift
//  MultimediaPlayer
//
//  Created by Admin on 6/6/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftUI

var mc = MediaController()
let appTitle = "Multimedia Player"

struct ContentView: View {
    @EnvironmentObject var mediaData: MediaData
    @State var showPlayerView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color
                    .black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    NavigationLink(destination: PlayerView(videoPlayer: mediaData.videoPlayer), isActive: $showPlayerView) {
                        EmptyView()
                    }
                    
                    HStack {
                        Text(appTitle)
                            .font(.system(size: 40))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                            .padding(.top, 60)
                    }
                    
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        // play button
                        Button(action: {
                            if (self.mediaData.videoPlayer != nil) {
                                self.showPlayerView = true
                            } else {
                                self.showPlayerView = false
                                mc.playMedia(filename: self.mediaData.title!)
                            }
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
                            mc.pauseMedia(filename: self.mediaData.title!)
                        }) {
                            Image(systemName: "pause.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    
                    Spacer()
                    
                    HStack {
                        if (mediaData.title != nil) {
                            Text(mediaData.title!)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                }
            }
            .onAppear {
                if (self.mediaData.title == nil) {
                    self.mediaData.title = mc.loadMedia(fileURLWithPath: "alright-radio-edit-kendrick-lamar", ofType: "mp3")!
                }
            }
        }
    }
}

struct PlayerView: View {
    var videoPlayer: VideoPlayer?
    
    var body: some View {
        VStack {
            videoPlayer!
                .frame(height: UIScreen.main.bounds.height / 2.6, alignment: .center)
            
            Spacer()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
