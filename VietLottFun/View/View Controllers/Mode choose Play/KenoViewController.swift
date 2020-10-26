//
//  KenoViewController.swift
//  VietLottFun
//
//  Created by kaorupuka on 9/24/20.
//

import UIKit

class KenoViewController: PlayViewController {
    
    private var genNumber = 0
    
    private let pickerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.updateViewConstraints()
    }
    //MARK: - PICKER
    override func setupPickerStack() {
        topStack.addArrangedSubview(pickerStack)
        let detailLabel : UILabel = {
            let label = UILabel()
            label.text = "Choose up to 10 numbers to play"
            label.font = UIFont(name: "Helvetica-Light", size: 16)
            label.textColor = .white
            label.textAlignment = .justified
            label.numberOfLines = 0
            label.contentMode = .scaleAspectFit
            return label
        }()
        
        let pickerView : UIPickerView = {
            let picker = UIPickerView()
            picker.backgroundColor = .white
            picker.dataSource = self
            picker.delegate = self
            
            return picker
        }()
        
        pickerStack.translatesAutoresizingMaskIntoConstraints = false
        pickerStack.alignment = .center
        pickerStack.distribution = .fill
        
        pickerStack.addArrangedSubview(detailLabel)
        pickerStack.addArrangedSubview(pickerView)
        pickerView.widthAnchor.constraint(equalTo: pickerStack.widthAnchor, multiplier: 0.2).isActive = true
        pickerView.heightAnchor.constraint(equalTo: pickerStack.heightAnchor, multiplier: 1).isActive = true
        pickerView.clipsToBounds = true
        pickerView.layer.cornerRadius = 7
    }

//MARK: - EXTENSION - CollectionView
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }



    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genNumber
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = CGFloat()
        var height = CGFloat()
        switch genNumber {
        case 1,2,3,6,9:
            width = [collectionView.frame.width/4,collectionView.frame.height/2].min()!
            height = width
        case 4,7,8:
            width = [collectionView.frame.width/5,collectionView.frame.height/2].min()!
            height = width
        case 10:
            width = [collectionView.frame.width/6,collectionView.frame.height/2].min()!
            height = width
        default:
            width = [collectionView.frame.width/4,collectionView.frame.height/2].min()!
            height = width
        }
        return CGSize(width: width, height: height)
    }
}

//MARK: - EXTENSION - UIPickerView

extension KenoViewController : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return pickerView.frame.height
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return pickerView.frame.width
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genNumber = row
        resultString.removeAll()
        collectionView.reloadData()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let view : UILabel = {
            let view = UILabel()
            view.backgroundColor = .white
            if row == 0 {
                view.text = "--"
            } else {
                view.text = String(row)
            }
            view.textAlignment = .center
            view.contentMode = .scaleToFill
            view.textColor = K.Color().pinkOrange
            view.font = UIFont(name: "Helvetica-Bold", size: 14)
            return view
        }()
        return view
    }
    
}

extension KenoViewController : UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        11
    }
}
