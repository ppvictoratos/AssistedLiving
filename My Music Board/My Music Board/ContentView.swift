//
//  ContentView.swift
//  My Music Board
//
//  Created by Petie Positivo on 5/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var isSpinning = false //state for spinning wheel
    @State private var isSongCardVisible = false
    @State private var isProfileVisible = false
    @State private var isFlipped = false //state for settings modal
    @State private var profile: Profile = Profile(
        name: "Johnny Boy",
        genres: ["Rock", "Pop", "Rap"],
        message: "Whaddup I like Cheese",
        isSpinning: false
    )
    
    let songs: [Song] = [
        Song(title: "Sunflower Seeds",
             artist: "Yung Nudy",
             features: "",
             description: "Smooth",
             album: "Sli'merre",
             albumArtURL: URL(string: ""),
             releaseYear: "2018",
             spotifyTrackID: "",
             spotifyPreviewURL: URL(string: "")
            )
    ]
    
    
    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Spacer()
                    
                    BannerView(text: "Current Song Playing Title")
                        .offset(x: UIScreen.main.bounds.width * 0.5)
                    
                    Spacer()
                    
                    BannerView(text: "User Profile Name")
                        .offset(x: UIScreen.main.bounds.width * 0.8)
                    
                    Spacer()
                }
            }
            
            Spacer()
            
            ZStack {
                CircleView()
                
                if isProfileVisible {
                    ProfileView()
                        .opacity(isProfileVisible ? 1.0 : 0.0)
                        .animation(.spring())
                }
            }
            
            Spacer()
            
            Button(action: {
                isSongCardVisible.toggle()
            }, label: {
                Image(systemName: "person.circle")
                    .font(.system(size: 80))
                    .padding(30)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .clipShape(Circle())
            })
            .padding()
            
            if isSongCardVisible {
                SongCardView(song: songs[0])
                    .onTapGesture {
                        isSongCardVisible = false
                    }
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut)
            }
        }
    }
}

struct BannerView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
    }
}

struct CircleView: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 240, height: 240)
                .foregroundColor(.gray)
            
            ForEach(0..<7) { index in
                    Circle()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.gray)
                        .position(
                            x: 120 + 100 * cos((Double(index) * 2 * 2 .pi / 7) - .pi / 2),
                            y: 120 + 100 * sin((Double(index) * 2 * 2 .pi / 7) - .pi / 2)
                        )
            }
        }
        .padding()
    }
}

struct ProfileView: View {
    var body: some View {
        VStack{
            Image(systemName: "person.crop.circle")
                .font(.system(size: 120))
                .foregroundColor(.gray)
            
            Text("User Name")
                .font(.headline)
                .padding(.top, 10)
            
            Text("A short message about why I love music")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
        }
        .padding()
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
