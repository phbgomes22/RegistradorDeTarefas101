//
//  CelulaCustomizada.swift
//  RegistradorDeTarefas
//
//  Created by Pedro Gomes on 15/10/21.
//

import UIKit

class CelulaCustomizada: UITableViewCell {
    
    static let identificador = "celulaCustomizada"
    static let nomeNib = "CelulaCustomizada"
    
    @IBOutlet weak var labelDescricao: UILabel!
    @IBOutlet weak var viewUrgencia: UIView!
    @IBOutlet weak var feitoSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func popular(com tarefa: Tarefa) {
        self.labelDescricao.text = tarefa.descricao
        
        var corDeFundo: UIColor = .clear
        switch tarefa.urgencia {
        case .minima:
            corDeFundo = UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1.0)
        case .normal:
            corDeFundo = .yellow
        case .maxima:
            corDeFundo = .red
        }
        self.viewUrgencia.backgroundColor = corDeFundo
        self.feitoSwitch.isOn = false
    }
    
}
