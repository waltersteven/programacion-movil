//
//  FiguritasManager.swift
//  FiguritasApp
//
//  Created by E4401 on 4/27/18.
//  Copyright © 2018 Universidad de Lima. All rights reserved.
//

import Foundation

class Jugador{
    var imagen: String
    var numero: String
    
    init(conImagen imagen: String, conNumero numero: String) {
        self.imagen = imagen
        self.numero = numero
    }
}

struct FiguritasManager{
    var paqueteJugadores: [Jugador] = []
    var indiceJugadorActual: Int = 0
    
    init(){
        self.paqueteJugadores.append(Jugador(conImagen: "neymar", conNumero: "100"))
        self.paqueteJugadores.append(Jugador(conImagen: "messi", conNumero: "200"))
    }
    
    mutating func nextJugador(){
        if indiceJugadorActual < paqueteJugadores.count - 1{
            indiceJugadorActual += 1
        }
    }
    
    mutating func prevJugador(){
        if indiceJugadorActual >= 1{
            indiceJugadorActual -= 1
        }
    }
}





