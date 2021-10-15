//
//  ViewController.swift
//  RegistradorDeTarefas
//
//  Created by Pedro Gomes on 15/10/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tarefasTableView: UITableView!
    
    private var identificadorCelula: String = "celulaPadrao"
    
    var ultimoIndiceTabela: Int {
        return tarefasTableView.numberOfRows(inSection: 0) - 1
    }
    
    var tarefas: [Tarefa] = [
        Tarefa(descricao: "Alimentar meu gato", urgencia: .maxima),
        Tarefa(descricao: "Regar as plantas", urgencia: .normal),
        Tarefa(descricao: "Ir no mercado", urgencia: .minima),
        Tarefa(descricao: "Lavar a roupa", urgencia: .normal),
        Tarefa(descricao: "Fazer o almoço", urgencia: .normal),
        Tarefa(descricao: "Ir na academia", urgencia: .minima),
        Tarefa(descricao: "Estudar Swift", urgencia: .maxima)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Fazendo o link entre nossa ViewController e os delegates
        tarefasTableView.delegate = self
        tarefasTableView.dataSource = self
        
        // Registrando uma celula customizada com xib
        let nibCelulaCustomizada = UINib(nibName: CelulaCustomizada.nomeNib, bundle: nil)
        tarefasTableView.register(
            nibCelulaCustomizada,
            forCellReuseIdentifier: CelulaCustomizada.identificador
        )
        
        // Registrando uma celula customizada sem xib
        /*
         tarefasTableView.register(
             CelulaCustomizada.self,
             forCellReuseIdentifier: CelulaCustomizada.identificador
         )
         */
    }

}


/// Funções do protocolo UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == ultimoIndiceTabela {
            performSegue(withIdentifier: "apresentaNovaTarefa", sender: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tarefas.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

/// Funções do protocolo UITableViewDataSource
extension ViewController: UITableViewDataSource {
    
    /// Determina o número de seções que nossa tabela terá
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /// Determina o número de linhas que *cada* seção terá
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tarefas.count + 1
    }
    
    /// Determina qual célula aparecerá para cada linha de cada seção
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == ultimoIndiceTabela {
            let celulaAdicionar = criaCelulaAdicionar(tableView, for: indexPath)
            return celulaAdicionar
        }
        
        let celula = criaCelula(tableView, for: indexPath)
    
        return celula
    }
    
    func criaCelula(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        
        let tarefa = self.tarefas[indexPath.row]
        
        let celulaCustomizada = tableView.dequeueReusableCell(
            withIdentifier: CelulaCustomizada.identificador,
            for: indexPath ) as? CelulaCustomizada
        
        if let novaCelula = celulaCustomizada {
            
            celulaCustomizada?.popular(com: tarefa)

            return novaCelula
        }
        
        return UITableViewCell()
        
    }
    
    
    func criaCelulaAdicionar(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: self.identificadorCelula, for: indexPath)
        
        var configuration = celula.defaultContentConfiguration()
        configuration.text = "Adicionar"
        configuration.textProperties.color = UIColor.systemBlue
    
        celula.contentConfiguration = configuration
        
        return celula
    }
    
    
}
