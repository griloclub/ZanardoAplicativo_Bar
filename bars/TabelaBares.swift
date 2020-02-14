//
//  TabelaBares.swift
//  Bar
//
//  Created by Eduarda on 04/02/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit
/*Classe ultilizada como uma view para mostra os bares na tabela
 *Não apresenta nenhum metodo
 *Mas todas as views que serão vistas na tela será declarado aqui
 */
class TabelaBares: UITableViewCell {
    
    //MARK: Propriedades
    
    @IBOutlet weak var Classifcacao: RatingBar!
    
    @IBOutlet weak var NomeBar: UILabel!
    
    @IBOutlet weak var FtBar: UIImageView!
    
   
    //MARK: Override funções
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
