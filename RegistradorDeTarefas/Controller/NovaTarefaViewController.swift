//
//  NovaTarefaViewController.swift
//  RegistradorDeTarefas
//
//  Created by Pedro Gomes on 15/10/21.
//

import UIKit

class NovaTarefaViewController: UIViewController {
    
    @IBOutlet weak var descricaoTextField: UITextField!
    
    @IBOutlet weak var urgenciaTableView: UITableView!
    
    private var identificadorCelula: String =  "celulaNovaTarefa"
    
    private var urgenciaSelecionada: Urgencia = .normal
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        urgenciaTableView.delegate = self
        urgenciaTableView.dataSource = self
    }
    
    
    @IBAction func apertouPronto(_ sender: UIButton) {
        
        let descricaoTarefa = descricaoTextField.text ?? "Sem Nome"
        
        let novaTarefa = Tarefa(
            descricao: descricaoTarefa,
            urgencia: urgenciaSelecionada
        )
        
        if let viewControllerPai = self.presentingViewController as? ViewController {
            viewControllerPai.tarefas.append(novaTarefa)
            viewControllerPai.tarefasTableView.reloadData()
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
}


extension NovaTarefaViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        self.urgenciaSelecionada = Urgencia.urgencia(para: indexPath.row)
    }
}

extension NovaTarefaViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = tableView.dequeueReusableCell(withIdentifier: self.identificadorCelula, for: indexPath)
        
        var configuration = celula.defaultContentConfiguration()
        configuration.text = Urgencia.titulo(para: indexPath.row)
       
        celula.contentConfiguration = configuration
        
        return celula
    }
}
