//
//  KenoViewController.swift
//  VietLottFun
//
//  Created by kaorupuka on 9/24/20.
//

import UIKit

class KenoViewController: UIViewController {
    
    var type: TypeK?
    private var results = [String]()
    private var genNumber = 0
    //    var numberArray = [Int]()
    //    var maxArray = [Character]()
    private let welcomeText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        return label
    }()
    
    private let descriptionText: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Italic", size: 14)
        label.textColor = UIColor.white
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        return label
    }()
    
    private let pickerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let topStack : UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private let midView : UIView = {
        let view = UIView()
        
        return view
    }()
    private var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let bottomStack : UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let generateButton : MyButton = {
        let button = MyButton()
        button.setTitle("Generate Number", for: .normal)
        return button
    }()
    
    private let showStatsButton : MyButton = {
        let button = MyButton()
        button.setTitle("Recent Results", for: .normal)
        return button
    }()
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        welcomeText.text = type?.name
        descriptionText.text = type?.definition
        title = type?.name
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
                                                                   NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 16)!]
        view.backgroundColor = K.Color().pinkOrange
        view.addSubview(topStack)
        view.addSubview(midView)
        view.addSubview(bottomStack)
        setupTopStack()
        setupMidView()
        setupBottomStack()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.updateViewConstraints()
    }
    //MARK: - TOP
    private func setupTopStack() {
        print("topStack installed")
        topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        topStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        topStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        topStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35).isActive = true
        setupPickerStack()
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.addArrangedSubview(welcomeText)
        topStack.addArrangedSubview(descriptionText)
        topStack.addArrangedSubview(pickerStack)
    }
    //MARK: - PICKER
    private func setupPickerStack() {
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
    //MARK: - CollectionView & LayOut
    private func setupMidView() {
        print("midView installed")
        midView.translatesAutoresizingMaskIntoConstraints = false
        midView.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 0).isActive = true
        midView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        midView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        midView.bottomAnchor.constraint(equalTo: bottomStack.topAnchor, constant: 0).isActive = true
        
        collectionView.frame = midView.frame
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        midView.addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: midView.topAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: midView.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: midView.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: midView.trailingAnchor, constant: 0).isActive = true
        collectionView.backgroundColor = K.Color().pinkOrange
        
        
    }
   //MARK: - Generate Button
    private func setupBottomStack() {
        print("bottomStack installed")
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        bottomStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        bottomStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        bottomStack.addSubview(generateButton)
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        generateButton.centerXAnchor.constraint(equalTo: bottomStack.centerXAnchor).isActive = true
        generateButton.centerYAnchor.constraint(equalTo: bottomStack.centerYAnchor).isActive = true
        generateButton.heightAnchor.constraint(equalTo: bottomStack.heightAnchor, multiplier: 0.4).isActive = true
        generateButton.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, multiplier: 0.5).isActive = true
        generateButton.backgroundColor = .none
        generateButton.addTarget(self, action: #selector(generatePressed(_:)), for: .touchUpInside)
        generateButton.setNeedsUpdateConstraints()
        bottomStack.addSubview(showStatsButton)
        showStatsButton.centerXAnchor.constraint(equalTo: bottomStack.centerXAnchor).isActive = true
        showStatsButton.topAnchor.constraint(equalTo: generateButton.bottomAnchor, constant: 20).isActive = true
        showStatsButton.heightAnchor.constraint(equalTo: generateButton.heightAnchor, multiplier: 0.5).isActive = true
        showStatsButton.widthAnchor.constraint(equalTo: generateButton.widthAnchor, multiplier: 0.5).isActive = true
        showStatsButton.translatesAutoresizingMaskIntoConstraints = false
        showStatsButton.addTarget(self, action: #selector(showStatsButtonPressed(_:)), for: .touchUpInside)
        generateButton.setNeedsUpdateConstraints()
        
    }
    
    @objc func generatePressed(_ sender: MyButton!) {
        sender.pulsate()
        if let startNum = type?.startNum,
           let endNum = type?.endNum {
            randomNumber(startNum: startNum, endNum: endNum, genNum: genNumber)
        }
        collectionView.reloadData()
        
        print(results)
    }
    
    @objc func showStatsButtonPressed(_ sender: MyButton!) {
        sender.pulsate()
        let recentVC = RecentResultsTableVC()
        recentVC.type = type
        navigationController?.pushViewController(recentVC, animated: true)
    }
    
    
    func randomNumber(startNum: Int, endNum: Int, genNum: Int) {
        results.removeAll()
            var numberArray = [Int]()
            while numberArray.count < genNum {
                let number = Int.random(in: startNum...endNum)
                if !numberArray.contains(number) {
                    numberArray.append(number)
                }
            }
            numberArray.sort()
            for number in numberArray {
                let value = String(format:"%02d", number)
                results.append(value)
            }
    }
}

//MARK: - EXTENSION - CollectionView
extension KenoViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension KenoViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return genNumber
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? CollectionViewCell else {fatalError("Cannot cast UICollectionViewCell as type")}
        DispatchQueue.main.async {
            if self.results.count == 0 {
                cell.number.text = "00"
            } else {
                cell.number.text = self.results[indexPath.item]
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
        results.removeAll()
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
