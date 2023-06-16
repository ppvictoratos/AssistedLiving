//
//  EntryFields.swift
//  9MUSES
//
//  Created by Petie Positivo on 6/12/23.
//

import SwiftUI

struct UserProfile {
    var nickname: String
    var musicService: MusicService
}

enum MusicService: String, CaseIterable {
    case spotify
    case appleMusic
    case tidal
}

struct EnterNickname: View {
    
    @State private var nickname: String = ""
    @State private var selectedMusicService: MusicService = .spotify
    //maybe take out isHappy and rely on nickname being filled or not?
    @State private var isHappy: Bool = false
    @State private var userExists: Bool = false
    @State private var containsProfanity: Bool = false
    
    let badWords: [String] = {
        guard let url = Bundle.main.url(forResource: "BadWords", withExtension: "json") else {
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let badWords = try decoder.decode(ProhibitedWords.self, from: data)
            return badWords.prohibitedWords
        } catch {
            print("Error loading bad words: \(error)")
            return []
        }
    }()
    
    var body: some View {
        VStack {
            HStack {
                TextField("Enter ur nickname", text: $nickname)
                    .padding()
                    .onChange(of: nickname) { newValue in
                        checkForProfanity()
                    }
                    .overlay(
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.black)
                            .padding(.top, 35)
                    )
                    .background(
                        Rectangle()
                            .foregroundColor(.clear)
                    )
                
                if containsProfanity {
                    Text("Bad Word!")
                        .foregroundColor(.red)
                }
                
                Text(nickname.isEmpty ? "☹️" : "🙂")
                    .font(.system(size: 40))
                    .animation(.spring())
            }
            
            Button("Save Profile") {
                saveProfile()
            }
            .padding(.top, 20)
            
        }
        .padding()
        .onAppear {
            checkProfile()
        }
    }
    
    func checkProfile() {
        //Perform local storage check for profile existence & update face values
        if UserDefaults.standard.value(forKey: "userExists") is Bool {
            self.userExists = userExists
            self.isHappy = userExists
        }
    }
    
    func saveProfile() {
        let userProfile = UserProfile(nickname: nickname, musicService: selectedMusicService)
        PersistenceController.shared.saveUserProfile(userProfile)
        UserDefaults.standard.set(true, forKey: "isProfileCreated")
        userExists = true
        isHappy = userExists
    }
    
    func checkForProfanity() {
        let words = nickname.lowercased().components(separatedBy: CharacterSet.alphanumerics.inverted)
        let profanityDetected = badWords.contains { badWord in
            words.contains(badWords.description.lowercased())
        }
        containsProfanity = profanityDetected
    }
    
    struct ProhibitedWords: Codable {
        let prohibitedWords: [String]
    }
}
