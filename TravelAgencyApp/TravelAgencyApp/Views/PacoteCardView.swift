//
//  PacoteCardView.swift
//  MyApp
//
//  Created by Moraes, Thomas Pozzer on 09/11/26.
//

import SwiftUI

struct PacoteCardView: View {

let pacote: PacoteViagem

@EnvironmentObject var favoritosVM: FavoritosViewModel

var body: some View {

HStack(spacing: 15) {

Image(pacote.imagemNome)
.resizable()
.scaledToFill()
.frame(width: 120, height: 90)
.clipped()
.cornerRadius(12)

VStack(alignment: .leading, spacing: 6) {

Text(pacote.titulo)
.font(.headline)

Text(pacote.local)
.foregroundColor(.secondary)

Text("\(pacote.diarias) diárias")
.font(.subheadline)

Text(
pacote.preco,
format: .currency(code: "BRL")
)
.font(.headline)
.foregroundColor(.blue)
}

Spacer()

Button {

favoritosVM.alternarFavorito(pacote)

} label: {

Image(
systemName:
favoritosVM.ehFavorito(pacote)
? "heart.fill"
: "heart"
)
.foregroundColor(.red)
.font(.title2)
}
}
.padding()
.background(Color(.systemBackground))
.cornerRadius(15)
.shadow(radius: 2)
}
}
