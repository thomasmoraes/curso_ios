//
//  FavotirosView.swift
//  MyApp
//
//  Created by Moraes, Thomas Pozzer on 09/11/26.
//

import SwiftUI
 
struct FavoritosView: View {
 
@EnvironmentObject var favoritosVM: FavoritosViewModel
 
var body: some View {
 
Group {
 
if favoritosVM.favoritos.isEmpty {
 
ContentUnavailableView(
"Nenhum favorito",
systemImage: "heart.slash",
description: Text(
"Adicione pacotes aos favoritos."
)
)
 
} else {
 
List(favoritosVM.favoritos) { pacote in
 
NavigationLink {
 
DetalhePacoteView(
pacote: pacote
)
 
} label: {
 
PacoteCardView(
pacote: pacote
)
}
}
}
}
.navigationTitle("Meus Favoritos")
}
}
