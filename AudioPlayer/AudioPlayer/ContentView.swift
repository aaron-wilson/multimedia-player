//
//  ContentView.swift
//  AudioPlayer
//
//  Created by Admin on 6/6/20.
//  Copyright © 2020 Admin. All rights reserved.
//

import SwiftUI

var mc = MediaController()

struct ContentView: View {
    @EnvironmentObject var mediaData: MediaData
    
    var body: some View {
        ZStack {
            Color
                .black
                .edgesIgnoringSafeArea(.all)
            VStack {
                Spacer()
                
                HStack {
                    Text("Media Player")
                        .font(.system(size: 48))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                HStack {
                    Spacer()
                    
                    // play button
                    Button(action: {
                        mc.playMedia(filename: self.mediaData.title)
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
                        mc.pauseMedia(filename: self.mediaData.title)
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
                    Text(self.mediaData.title)
                        .font(.system(size: 24))
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                }
                
                Spacer()
            }
        }
        .onAppear {
            self.mediaData.title = mc.loadMedia(fileURLWithPath: "alright-radio-edit-kendrick-lamar", ofType: "mp3")!
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
