//
//  ContentView.swift
//  MultimediaPlayer
//
//  Created by Admin on 6/6/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: Store
    @State var showPlayerView = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color
                    .black
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    NavigationLink(destination: PlayerView(videoPlayer: store.videoPlayer), isActive: $showPlayerView) {
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
                            if (self.store.videoPlayer != nil) {
                                self.showPlayerView = true
                                mc.update()
                            } else {
                                self.showPlayerView = false
                                mc.playMedia(filename: self.store.title!)
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
                            mc.pauseMedia(filename: self.store.title!)
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
                        if (store.title != nil) {
                            Text(store.title!)
                                .font(.system(size: 20))
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: HistoryView(playbacks: store.playbacks)) {
                        Text("History")
                            .font(.system(size: 20))
                            .fontWeight(.bold)
                    }
                    
                    Spacer()
                }
            }
            .onAppear {
                mc.updatePlaybacks()
//                if (self.store.title == nil) {
//                    self.store.title = mc.loadMedia(fileURLWithPath: "alright-radio-edit-kendrick-lamar", ofType: "mp3")!
//                }
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

struct HistoryView: View {
    var playbacks: [Playback]?
    
    var body: some View {
        List(playbacks ?? []) { playback in
            VStack(alignment: .leading) {
                Text(playback.filename)
                    .fontWeight(.bold)
                
                Spacer()
                
                Text("\(secondsToDuration(seconds: playback.position)) / \(secondsToDuration(seconds: playback.duration))")
            }
        }
        .navigationBarTitle("History")
        .foregroundColor(.gray)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
