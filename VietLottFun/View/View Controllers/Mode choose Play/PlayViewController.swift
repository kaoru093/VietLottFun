
//
//  PlayViewController.swift
//  VietLottFun
//
//  Created by kaorupuka on 9/24/20.
//

import UIKit
import CoreData

class PlayViewController: UIViewController {
    
    var type: TypeK?
    var resultString = [String]()
    var resultInt = [Int]()
    let vietLottResult = VietLottResult()
    

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
    
    let topStack : UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private let midView : UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let generateButton : MyButton = {
        let button = MyButton()
        button.setTitle("Generate Number", for: .normal)
        return button
    }()
    
    var collectionView : UICollectionView = {
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
    
    private let showStatsButton : MyButton = {
        let button = MyButton()
        button.setTitle("Recent Results", for: .normal)
        button.backgroundColor = .none
        return button
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        welcomeText.text = type?.name
        descriptionText.text = type?.definition
        
        view.backgroundColor = K.Color().pinkOrange
        view.addSubview(topStack)
        view.addSubview(midView)
        view.addSubview(bottomStack)
        setupTopStack()
        setupMidView()
        setupBottomStack()
        setupNavBar()
        
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.updateViewConstraints()
    }
    
    private func setupNavBar() {
        title = type?.name
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 16)!]
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed(_:)))
        navigationItem.rightBarButtonItem = addButton
    }
    
    //MARK: - Setup View
    func setupTopStack() {
        topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        topStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
        topStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20).isActive = true
        topStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35).isActive = true
        
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.addArrangedSubview(welcomeText)
        topStack.addArrangedSubview(descriptionText)
        setupPickerStack()
    }
    
    func setupPickerStack() { }
    
    func setupMidView() {
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
    func setupBottomStack() {
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        bottomStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        bottomStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.2).isActive = true
        
        
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
        showStatsButton.heightAnchor.constraint(equalTo: generateButton.heightAnchor, multiplier: 0.7).isActive = true
        showStatsButton.widthAnchor.constraint(equalTo: generateButton.widthAnchor, multiplier: 0.7).isActive = true
        showStatsButton.translatesAutoresizingMaskIntoConstraints = false
        showStatsButton.addTarget(self, action: #selector(showStatsButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func generatePressed(_ sender: MyButton!) {
        sender.pulsate()
        if let startNum = type?.startNum,
           let endNum = type?.endNum,
           let genNum = type?.genNum {
            randomNumber(startNum: startNum, endNum: endNum, genNum: genNum)
        }
        collectionView.reloadData()
        
        print(resultString)
    }
    
    @objc func showStatsButtonPressed(_ sender: MyButton!) {
        sender.pulsate()
        let recentVC = RecentResultsTableVC()
        recentVC.type = type
        navigationController?.pushViewController(recentVC, animated: true)
    }
    
    @objc func addButtonPressed(_ sender: UIBarButtonItem!) {
        let alert = UIAlertController(title: "Save Numbers", message: "Do you want to save your numbers?", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (save) in
            let numberArray = Numbers(context: self.vietLottResult.context)
            numberArray.date = Date()
            numberArray.resultInt = self.resultInt
            numberArray.resultString = self.resultString
            numberArray.type = self.type?.name
            self.vietLottResult.savedNumbers.append(numberArray)
            
            self.vietLottResult.saveNumber()
        }
        alert.addAction(saveAction)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (cancel) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(cancelAction)
        let showStats = UIAlertAction(title: "Show Stats", style: .default) { (show) in
            let saveVC = SavedResultsViewController()
            saveVC.type = self.type
            self.navigationController?.present(saveVC, animated: true, completion: nil)
            
        }
        alert.addAction(showStats)
        present(alert, animated: true, completion: nil)
    }
    
    
    
    func randomNumber(startNum: Int, endNum: Int, genNum: Int) {
        resultString.removeAll()
        resultInt.removeAll()
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
                resultInt.append(number)
                let value = String(format:"%02d", number)
                resultString.append(value)
            }
        case .max3D:
            let number = Int.random(in: startNum...endNum)
            resultInt.append(number)
            let value = String(format: "%03d", number)
            for char in value {
                resultString.append(String(char))
            }
        case .max4D:
            let number = Int.random(in: startNum...endNum)
            resultInt.append(number)
            let value = String(format: "%04d", number)
            for char in value {
                resultString.append(String(char))
            }
        case .none:
            return resultString.removeAll()
        }
    }
}
//MARK: - EXT - CollectionView
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
            if self.resultString.count == 0 {
                cell.number.text = "00"
            } else {
                cell.number.text = self.resultString[indexPath.item]
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width = CGFloat()
        var height = CGFloat()
        switch type {
        case .mega, .max3D, .jackPot:
            width = [collectionView.frame.width/4,collectionView.frame.height/2].min()!
            height = width
        default:
            width = [collectionView.frame.width/5,collectionView.frame.height/2].min()!
            height = width
        }
        return CGSize(width: width, height: height)
    }
}
