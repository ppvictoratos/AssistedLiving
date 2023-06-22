//
//  ContentViewModel.swift
//  NINEMUSES
//
//  Created by Petie Positivo on 6/22/23.
//

import Foundation
import Combine

class ContentViewModel: ObservableObject {
    @Published var isAuthenticated = false
    var authenticationViewModel: AuthenticationViewModel
    var likedSongsViewModel: LikedSongsViewModel

    private var cancellables = Set<AnyCancellable>()

    init(authenticationService: AuthenticationService, spotifyService: SpotifyService) {
        self.authenticationViewModel = AuthenticationViewModel(authenticationService: authenticationService)
        self.likedSongsViewModel = LikedSongsViewModel(spotifyService: spotifyService)

        // Combine the authentication state from the authentication view model
        // to update the isAuthenticated property in the ContentViewModel
        authenticationViewModel.$isLoggedIn
            .assign(to: &$isAuthenticated)

        // Additional setup or dependencies can be passed to the view models here
    }

    func onViewAppear() {
        // Perform any necessary setup or actions when the view appears
    }
}
