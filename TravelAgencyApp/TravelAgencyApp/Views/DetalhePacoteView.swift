//
//  DeatlhePacoteView.swift
//  MyApp
//
//  Created by Moraes, Thomas Pozzer on 09/11/26.
//

import SwiftUI
 
struct DetalhePacoteView: View {
 
let pacote: PacoteViagem
 
@EnvironmentObject var favoritosVM: FavoritosViewModel
 
var body: some View {
 
ScrollView {
 
VStack(alignment: .leading, spacing: 18) {
 
Image(pacote.imagemNome)
.resizable()
.scaledToFill()
.frame(height: 250)
.clipped()
 
VStack(alignment: .leading, spacing: 10) {
 
Text(pacote.titulo)
.font(.largeTitle)
.bold()
 
Label(
pacote.local,
systemImage: "location.fill"
)

Text("Partida: \(pacote.dataPartida)")
Text("Retorno: \(pacote.dataChegada)")
Text("Duração: \(pacote.diarias) diárias")

Divider()

Text("Hospedagem")
.font(.title3)
.bold()

Text(pacote.informacoesHotel)

Button {

favoritosVM.alternarFavorito(pacote)

} label: {

Label(
favoritosVM.ehFavorito(pacote)
? "Remover dos Favoritos"
: "Adicionar aos Favoritos",
systemImage:
favoritosVM.ehFavorito(pacote)
? "heart.fill"
: "heart"
)
.frame(maxWidth: .infinity)
}
.buttonStyle(.borderedProminent)

Button {

} label: {

Text(
"Reservar • \(pacote.preco.formatted(.currency(code: "BRL")))"
)
.frame(maxWidth: .infinity)
}
.buttonStyle(.borderedProminent)
.tint(.green)
}
.padding()
}
}
.navigationTitle("Detalhes")
.navigationBarTitleDisplayMode(.inline)
}
}
