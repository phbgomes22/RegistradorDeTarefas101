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
    
    /// Array com os dados de tarefas a serem utilizados pela UITableView.
    /// Para essa versão inicial, mantivemos esses dados na ViewController.
    /// Idealmente, esse array seria carregado a partir de uma chamada de API, ou descrito
    /// em outra classe.
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
    
    
    
    func criaCelula(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        
        let tarefa = self.tarefas[indexPath.row]
        
        let celulaCustomizada = tableView.dequeueReusableCell(
            withIdentifier: CelulaCustomizada.identificador,
            for: indexPath ) as? CelulaCustomizada
        
        guard let novaCelula = celulaCustomizada else {
            return UITableViewCell()
        }
        
        celulaCustomizada?.popular(com: tarefa)
        
        return novaCelula
    }
    
    
    func criaCelulaAdicionar(_ tableView: UITableView, for indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: self.identificadorCelula, for: indexPath)
        
        var configuration = celula.defaultContentConfiguration()
        configuration.text = "Adicionar"
        configuration.secondaryText = "Uma nova tarefa"
        configuration.textProperties.color = UIColor.systemBlue
    
        celula.contentConfiguration = configuration
        
        return celula
    }
    
    func atualizaLista(tarefa: Tarefa) {
        self.tarefas.append(tarefa)
        self.tarefasTableView.reloadData()
    }
    
}


/// Funções do protocolo UITableViewDelegate
extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == ultimoIndiceTabela {
            
            /// Jeito 1 -> Segue
            //performSegue(withIdentifier: "apresentaNovaTarefa", sender: nil)
            
            
            /// Jeito 2 -> Instanciando a ViewController
            guard let novaTarefaVC = storyboard?.instantiateViewController(
                withIdentifier: NovaTarefaViewController.storyboardID
            ) as? NovaTarefaViewController else { return }
            
            novaTarefaVC.funcaoAoTerminar = atualizaLista
            self.present(novaTarefaVC, animated: true, completion: nil)
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tarefas.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}
