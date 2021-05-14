//
//  QiitaViewController.swift
//  QiitaAPI
//
//  Created by 大西玲音 on 2021/03/23.
//

import UIKit

final class QiitaViewController: UIViewController {
   
    @IBOutlet private weak var countLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    
    private var qiitas = [Qiita]()
    private var pageCount = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(QiitaTableViewCell.nib,
                           forCellReuseIdentifier: QiitaTableViewCell.identifier)

    }
    
    @IBAction private func decisionButtonDidTapped(_ sender: Any) {
        fetchQiitaAPI()
    }
    
    @IBAction private func pageCountStepperDidTapped(_ sender: UIStepper) {
        pageCount = Int(sender.value)
        countLabel.text = String(pageCount)
    }
    
    private func fetchQiitaAPI() {
        APIClient().fetchQiita(page: pageCount) { result in
            switch result {
            case .success(let qiitas):
                self.qiitas = qiitas
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension QiitaViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

extension QiitaViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return qiitas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QiitaTableViewCell.identifier, for: indexPath) as! QiitaTableViewCell
        let qiita = qiitas[indexPath.row]
        cell.configure(qiita: qiita)
        return cell
    }
    
}
