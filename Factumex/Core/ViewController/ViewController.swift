//
//  ViewController.swift
//  Factumex
//
//  Created by Macbook on 26/03/22.
//

import UIKit
import PhotosUI

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate & UINavigationControllerDelegate, UITextFieldDelegate {
    
    var responseData: InformationResponse?
    var apiServices = ApiServices()
    var viewModel: ViewModelViewController!
    
    var tableCustom: UITableView!
    var takeImage = UIImage()
    var strUserName: String = ""
    var imagePicker: UIImagePickerController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiServices.delegate = self
        initComponents()
    }
    
    func initComponents() {
        viewModel = ViewModelViewController()
        viewModel.delegate = self
        apiServices.fetchGraphics()
        addComponents()
        sendInformation()
        hideKeyboardWhenTappedAround()
    }
    
    func addComponents() {
        view.backgroundColor = .white
        tableCustom = UITableView(frame: CGRect(x: 0, y: 80, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        tableCustom.backgroundColor = .green
        let nib = UINib.init(nibName: "TextFieldCell", bundle: nil)
        tableCustom.register(nib, forCellReuseIdentifier: "textCell")
        
        let nibButtonCell = UINib.init(nibName: "ButtonCell", bundle: nil)
        tableCustom.register(nibButtonCell, forCellReuseIdentifier: "buttonCell")
        
        let nibAnyChartCell = UINib.init(nibName: "AnyChartCell", bundle: nil)
        tableCustom.register(nibAnyChartCell, forCellReuseIdentifier: "anyChartCell")
        
        tableCustom.isUserInteractionEnabled = true
        tableCustom.dataSource = self
        tableCustom.delegate = self
        tableCustom.layer.cornerRadius = 0
        tableCustom.backgroundColor = .white
        tableCustom.showsVerticalScrollIndicator = false
        tableCustom.allowsSelection = true
        tableCustom.isScrollEnabled = false
        tableCustom.separatorStyle = .singleLine
        view.addSubview(tableCustom)
    }
}



extension ViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell: TextFieldCell = (tableView.dequeueReusableCell(withIdentifier: "textCell", for: indexPath) as? TextFieldCell)!
            cell.txtUserName.delegate = self
            cell.backgroundColor = .white
            return cell
        }
        else if indexPath.row == 1 {
            let cell: ButtonCell = (tableView.dequeueReusableCell(withIdentifier: "buttonCell", for: indexPath) as? ButtonCell)!
            cell.btnCamera.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
            cell.btnCamera.backgroundColor = .gray
            cell.backgroundColor = .white
            cell.textLabel?.textColor = .black
            return cell
        }
        else {
            let cell: AnyChartCell = (tableView.dequeueReusableCell(withIdentifier: "anyChartCell", for: indexPath) as? AnyChartCell)!
            cell.question1.addTarget(self, action: #selector(goChart), for: .touchUpInside)
            cell.question2.addTarget(self, action: #selector(goChart), for: .touchUpInside)
            cell.question3.addTarget(self, action: #selector(goChart), for: .touchUpInside)
            cell.question4.addTarget(self, action: #selector(goChart), for: .touchUpInside)
            cell.question5.addTarget(self, action: #selector(goChart), for: .touchUpInside)
            cell.backgroundColor = .white
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        var heightRow: CGFloat = 0.0
        if indexPath.row == 0 {
            heightRow = 60.0
        } else {
            heightRow = 90.0
        }
        return heightRow
    }
    
    func sendInformation() {
        let btnUpdateInformation = UIButton(type: .custom)
        btnUpdateInformation.backgroundColor = .systemBlue
        btnUpdateInformation.setTitle(Constants.sendInformation.rawValue, for: .normal)
        btnUpdateInformation.setTitleColor(.white, for: .normal)
        btnUpdateInformation.frame = CGRect(x: 20, y: UIScreen.main.bounds.height - 220, width: UIScreen.main.bounds.width - 40, height: 80)
        btnUpdateInformation.addTarget(self, action: #selector(savedInformationFirebase), for: .touchUpInside)
        btnUpdateInformation.layer.cornerRadius = 15.0
        view.addSubview(btnUpdateInformation)
    }
    
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 250.0
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        strUserName = textField.text ?? ""
    }
    
    @objc
    func goChart(_ sender: UIButton) {
        let chartView = GraphicsViewController()
        chartView.responseData = responseData
        chartView.indexGraphic = sender.tag
        self.navigationController?.pushViewController(chartView, animated: true)
    }
    
    @objc
    func pressButton(_ sender: Any) {
        let alert = UIAlertController(title: Constants.nameBusiness.rawValue, message: Constants.selectOption.rawValue, preferredStyle: .actionSheet)
            self.imagePicker = UIImagePickerController()
            self.imagePicker.delegate = self

        let addAction = UIAlertAction(title: Constants.library.rawValue, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.imagePicker.sourceType = .photoLibrary
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        
        let saveAction = UIAlertAction(title: Constants.takePhoto.rawValue, style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.imagePicker.sourceType = .camera
            self.present(self.imagePicker, animated: true, completion: nil)
        })
        

        let cancelAction = UIAlertAction(title: Constants.cancel.rawValue, style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
        })
        
        alert.addAction(addAction)
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        takeImage = selectedImage
        dismiss(animated: true, completion: nil)
    }
    
    @objc func savedInformationFirebase() {
        viewModel.uploadFirebasePhotography(_takeImage: takeImage)
        viewModel.uploadFirebaseUsername(name: strUserName)
    }
    
    func showAlert(title: String, msg: String, msgTitleBtn: String) {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: msgTitleBtn, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

extension ViewController: ServicesDelegate {
    func didLoadWith(data: InformationResponse) {
        responseData = data
    }
    
    func didWithError(error: String) {
        showAlert(title: Constants.nameBusiness.rawValue, msg: error, msgTitleBtn: Constants.continuar.rawValue)
    }
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tapGesture = UITapGestureRecognizer(target: self,
                                                action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
}

extension ViewController: ViewModelDelegate {

    func didFinishWithResult(documentId: String) {
        showAlert(title: Constants.nameBusiness.rawValue, msg: Constants.deliverySuccessfull.rawValue + documentId, msgTitleBtn: Constants.continuar.rawValue)
    }
    
    func didFinishWithError(err: String) {
        showAlert(title: Constants.nameBusiness.rawValue, msg: Constants.deliveryFailed.rawValue + "\(err)", msgTitleBtn: Constants.continuar.rawValue)
    }
}
