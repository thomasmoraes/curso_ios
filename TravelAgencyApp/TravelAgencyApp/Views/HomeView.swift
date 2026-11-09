//
//  HomeView.swift
//  MyApp
//
//  Created by Moraes, Thomas Pozzer on 09/11/26.
//

import SwiftUI

struct HomeView: View {

@EnvironmentObject var favoritosVM: FavoritosViewModel

let pacotes = [
PacoteViagem(
titulo: "Praias do Nordeste",
diarias: 7,
local: "Salvador - BA",
dataPartida: "10/12/2026",
dataChegada: "17/12/2026",
informacoesHotel: "Hotel 5 estrelas frente mar",
imagemNome: "salvador",
preco: 2599.90
),

PacoteViagem(
titulo: "Rio Maravilhoso",
diarias: 5,
local: "Rio de Janeiro - RJ",
dataPartida: "08/01/2027",
dataChegada: "13/01/2027",
informacoesHotel: "Copacabana Palace",
imagemNome: "rio",
preco: 3199.90
),

PacoteViagem(
titulo: "Paris Romântica",
diarias: 10,
local: "Paris - França",
dataPartida: "20/02/2027",
dataChegada: "02/03/2027",
informacoesHotel: "Hotel próximo à Torre Eiffel",
imagemNome: "paris",
preco: 9999.90
)
]

var body: some View {

NavigationStack {

List(pacotes) { pacote in

NavigationLink {

DetalhePacoteView(pacote: pacote)

} label: {

PacoteCardView(pacote: pacote)
}
}

.navigationTitle("Explorar Viagens")
 
.toolbar {
 
NavigationLink {
 
FavoritosView()
 
} label: {
 
ZStack(alignment: .topTrailing) {
 
Image(systemName: "heart.fill")
.font(.title2)
 
if !favoritosVM.favoritos.isEmpty {
 
Text("\(favoritosVM.favoritos.count)")
.font(.caption2)
.foregroundColor(.white)
.padding(5)
.background(.red)
.clipShape(Circle())
.offset(x: 10, y: -10)
}
}
}
}
}
}
}

