//
//  ViewModel.swift
//  Factumex
//
//  Created by Macbook on 26/03/22.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

protocol ViewModelDelegate {
    func didFinishWithResult(documentId: String)
    func didFinishWithError(err: String)
}

class ViewModelViewController {
    
    private var db = Firestore.firestore()
    var delegate: ViewModelDelegate?
    
    func uploadFirebasePhotography(_takeImage: UIImage) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        let userPhoto = UIImageView()
        userPhoto.image = _takeImage
        var data = NSData()
        
        if (userPhoto.image == nil) {
            print("Alert imagen vacia")
        } else {
            data = userPhoto.image!.jpegData(compressionQuality: 0.8)! as NSData
            let filePath = "\(NSUUID().uuidString)/\("photo")"
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            storageRef.child(filePath).putData(data as Data, metadata: metaData){(metaData,error) in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }else{}
            }
        }
    }
    
    func uploadFirebaseUsername(name: String) {
        var ref: DocumentReference? = nil
        ref = db.collection("information").addDocument(data: [
            "name": name
        ]) { [weak self] (err) in
            guard let ref = ref else { return }
            guard let self = self else { return }
            if let err = err {
                self.delegate?.didFinishWithError(err: err.localizedDescription)
            } else {
                self.delegate?.didFinishWithResult(documentId: ref.documentID)
            }
        }
    }
}
