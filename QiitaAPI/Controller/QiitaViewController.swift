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
        guard let url = URL(string: "https://qiita.com/api/v2/items?page=1&per_page=5") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                fatalError("\(error)")
            }
            if let data = data {
                do {
                    let qiita = try JSONDecoder().decode([Qiita].self, from: data)
                    self.qiitas = qiita
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } catch {
                    fatalError("\(error)")
                }
                
            }
        }
        task.resume()
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
