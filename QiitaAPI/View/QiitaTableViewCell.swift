//
//  QiitaTableViewCell.swift
//  QiitaAPI
//
//  Created by 大西玲音 on 2021/03/23.
//

import UIKit

final class QiitaTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var userImageView: UIImageView!
    
    static var identifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: String(describing: self), bundle: nil) }
    
}

extension QiitaTableViewCell {
    
    func configure(qiita: Qiita) {
        titleLabel.text = qiita.title
        guard let url = URL(string: qiita.user.profileImageUrl) else { return }
        do {
            let data = try Data(contentsOf: url)
            let image = UIImage(data: data)
            userImageView.image = image
        } catch {
            fatalError("\(error)")
        }
    }
    
}
