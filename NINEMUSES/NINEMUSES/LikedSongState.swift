//
//  LikedSongState.swift
//  NINEMUSES
//
//  Created by Petie Positivo on 6/21/23.
//  Generated by ChatGPT
//

import Foundation
import ComposableArchitecture

struct LikedSongsState: Equatable {
    var songs: [Song] = []
    var selectedSong: Song?
}

enum LikedSongsAction {
    case fetchSongs
    case songsFetched(Result<[Song], Error>)
    case selectSong(Song)
}

let likedSongsReducer = Reducer<LikedSongsState, LikedSongsAction, AppEnvironment> { state, action, environment in
    switch action {
    case .fetchSongs:
        return environment.spotifyService.fetchLikedSongs()
            .map { .songsFetched($0) }
            .eraseToEffect()
        
    case let .songsFetched(.success(songs)):
        state.songs = songs
        return .none
        
    case let .songsFetched(.failure(error)):
        // Handle the error when fetching songs
        return .none
        
    case let .selectSong(song):
        state.selectedSong = song
        return .none
    }
}