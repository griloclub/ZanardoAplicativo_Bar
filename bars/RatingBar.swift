//
//  RatingBar.swift
//  Bar
//
//  Created by Eduarda on 31/01/20.
//  Copyright © 2020 hbsis. All rights reserved.
//

import UIKit

@IBDesignable class RatingBar : UIStackView {
    
    //Propriedades
    private var ratingButtons = [UIButton]()
    
    var rating = 0 {
        didSet{
            updateButtonSelectionStates()
        }
    }
    
    var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons();
        }
    }
    var starCount : Int = 5 {
        didSet {
            setupButtons();
        }
    }
    // Inicializador
    
    //Inicializa as estrelas
    override init(frame: CGRect) {
        super.init(frame : frame)
        setupButtons()
    }
    //Inicializa as estrelas já setadas com uma classificação, no caso ultilizado qaundo já está salvo
    required init(coder : NSCoder) {
        super.init(coder : coder)
        setupButtons()
    }
    //Ação do botão
    //@objc ultilizado para partes do codigo em objetive C
    @objc func ratingButtonTapped(button : UIButton){
        guard let index = ratingButtons.index(of: button)
            else{
                fatalError("O Botão, \(button) ")
                
        }
        //Calcula as estrelas selecionadas no botão
        
        let selectedRating = index + 1
        
        if selectedRating == rating {
            rating = 0
            
        } else {
            rating = selectedRating
            
        }
    }
   
    private func setupButtons() {
        
        //Limpando os botões
        
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        //Carregando Imagens
        
        let bundle = Bundle(for: type(of: self))
        
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
  
        
        for _ in 0..<starCount {
            
            //Criando Botão
            let button = UIButton()
            
            //Criando o botão a partir do que o usuario clicar
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
        
            //Adiciona contraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant:  starSize.width).isActive = true
            
            //Definindo a ação do botão
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        updateButtonSelectionStates();
        
    }
  
    private func updateButtonSelectionStates(){
        for(index, button) in ratingButtons.enumerated(){
            button.isSelected = index < rating
            print(button.isSelected,index)
        }
    }
}
