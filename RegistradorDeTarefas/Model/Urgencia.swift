//
//  Urgencia.swift
//  RegistradorDeTarefas
//
//  Created by Pedro Gomes on 15/10/21.
//

import Foundation

enum Urgencia {
    case minima
    case normal
    case maxima
    
    static func titulo(para index: Int) -> String {
        switch index {
        case 0:
            return "Mínima"
        case 1:
            return "Normal"
        case 2:
            return "Máxima"
        default:
            return ""
        }
    }
    
    static func urgencia(para index: Int) -> Urgencia {
        switch index {
        case 0:
            return .minima
        case 1:
            return .normal
        case 2:
            return .maxima
        default:
            return .normal
        }
    }
}
