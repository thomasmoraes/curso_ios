import SwiftUI

@main struct MyApp: App {
     
    @StateObject var favoritosVM = FavoritosViewModel()
     
    var body: some Scene {
     
    WindowGroup {
     
    HomeView()
    .environmentObject(favoritosVM)
    }
    }
    }
