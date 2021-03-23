//
//  QiitaTableViewCell.swift
//  QiitaAPI
//
//  Created by 大西玲音 on 2021/03/23.
//

import UIKit

class QiitaTableViewCell: UITableViewCell {

    @IBOutlet weak var qiitaLabel: UILabel!
    @IBOutlet weak var qiitaImageView: UIImageView!
    
    var qiita: Qiita? {
        didSet {
            qiitaLabel.text = qiita?.title
            guard let url = URL(string: qiita?.user.profileImageUrl ?? "") else { return }
            do {
                let data = try Data(contentsOf: url)
                let image = UIImage(data: data)
                qiitaImageView.image = image
            } catch {
                fatalError("\(error)")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
