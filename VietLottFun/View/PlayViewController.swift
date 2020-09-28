
//
//  PlayViewController.swift
//  VietLottFun
//
//  Created by kaorupuka on 9/24/20.
//

import UIKit

class PlayViewController: UIViewController {
    
    var type: TypeK?
    var results = [String]()
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
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
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
    
    private func setupTopStack() {
        print("topStack installed")
        topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        topStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        topStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        topStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.22).isActive = true
        
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.addArrangedSubview(welcomeText)
        topStack.addArrangedSubview(descriptionText)
    }
    
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
    
    private func setupBottomStack() {
        print("bottomStack installed")
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        bottomStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        bottomStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
        
        let generateButton : MyButton = {
            let button = MyButton()
            button.setTitle("Generate Number", for: .normal)
            return button
        }()
        bottomStack.addSubview(generateButton)
        generateButton.translatesAutoresizingMaskIntoConstraints = false
        generateButton.centerXAnchor.constraint(equalTo: bottomStack.centerXAnchor).isActive = true
        generateButton.centerYAnchor.constraint(equalTo: bottomStack.centerYAnchor).isActive = true
        generateButton.heightAnchor.constraint(equalTo: bottomStack.heightAnchor, multiplier: 0.5).isActive = true
        generateButton.widthAnchor.constraint(equalTo: bottomStack.widthAnchor, multiplier: 0.5).isActive = true
        generateButton.backgroundColor = .none
        generateButton.addTarget(self, action: #selector(generatePressed(_:)), for: .touchUpInside)
        
    }
    
    @objc func generatePressed(_ sender: MyButton!) {
        sender.pulsate()
        if let startNum = type?.startNum,
           let endNum = type?.endNum,
           let genNum = type?.genNum {
            randomNumber(startNum: startNum, endNum: endNum, genNum: genNum)
        }
        collectionView.reloadData()
        
        print(results)
    }
    
    func randomNumber(startNum: Int, endNum: Int, genNum: Int) {
        results.removeAll()
        switch type {
        case .jackPot, .mega, .keno:
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
        case .max3D:
            let number = Int.random(in: startNum...endNum)
            let value = String(format: "%03d", number)
            for char in value {
                results.append(String(char))
            }
        case .max4D:
            let number = Int.random(in: startNum...endNum)
            let value = String(format: "%04d", number)
            for char in value {
                results.append(String(char))
            }
        case .none:
            return results.removeAll()
        }
        
//        numberArray.removeAll()
//        maxArray.removeAll()
//        while numberArray.count < genNum {
//            let number = Int.random(in: startNum...endNum)
//            if !numberArray.contains(number) {
//                numberArray.append(number)
//            }
//        }
//        numberArray.sort()
//        let value = String(numberArray[0])
//        print(value)
//        for char in value {
//            maxArray.append(char)
//        }
    }
}

extension PlayViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension PlayViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch type {
        case .jackPot, .mega: return 6
        case .max3D: return 3
        case .max4D: return 4
        case .keno: return 10
        case .none:
            return 0
        }
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
        return CGSize(width: 100, height: 100)
    }
}
