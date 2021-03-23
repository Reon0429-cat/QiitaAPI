//
//  QiitaViewController.swift
//  QiitaAPI
//
//  Created by 大西玲音 on 2021/03/23.
//

import UIKit

class QiitaViewController: UIViewController {
    
    private var qiitas = [Qiita]()
    private let cellId = String(describing: QiitaTableViewCell.self)
   
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        tableView.delegate = self
        tableView.dataSource = self
        let nibName = String(describing: QiitaTableViewCell.self)
        let nib = UINib(nibName: nibName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
   
        fetchQiitaAPI()
    }
    
    private func fetchQiitaAPI() {
        QiitaAPI.shared.fetchQiitaAPI { result in
            switch result {
            case .success(let qiitas):
                self.qiitas = qiitas
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QiitaTableViewCell
        cell.qiita = qiitas[indexPath.row]
        return cell
    }
    
}
