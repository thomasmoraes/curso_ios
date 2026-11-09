//
//  PacoteViagem.swift
//  MyApp
//
//  Created by Moraes, Thomas Pozzer on 09/11/26.
//

import Foundation

struct PacoteViagem: Identifiable, Hashable {

let id = UUID()

let titulo: String
let diarias: Int
let local: String
let dataPartida: String
let dataChegada: String
let informacoesHotel: String
let imagemNome: String
let preco: Double
}
