//
//  FavoritosViewModel.swift
//  MyApp
//
//  Created by Moraes, Thomas Pozzer on 09/11/26.
//

import SwiftUI
public import Combine

class FavoritosViewModel: ObservableObject {
    


@Published var favoritos: [PacoteViagem] = []

func alternarFavorito(_ pacote: PacoteViagem) {

if favoritos.contains(pacote) {
favoritos.removeAll { $0.id == pacote.id }
} else {
favoritos.append(pacote)
}
}

func ehFavorito(_ pacote: PacoteViagem) -> Bool {
favoritos.contains(pacote)
}
}
