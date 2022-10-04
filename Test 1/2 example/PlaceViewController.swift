//
//  PlaceViewController.swift
//  Test 1
//
//  Created by Nazar Lykashik on 26.08.22.
//

import UIKit
import Alamofire

class PlaceViewController: UIViewController {
    @IBOutlet var imageOfPlace: UIImageView!
    @IBOutlet var nameOfPlace: UILabel!
    @IBOutlet var voiseDescription: UIButton!
    @IBOutlet var descriptionOfPlace: UILabel!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    
    var name: String = ""
    var photo: String = ""
    var text: String = ""
    var sound: String = ""
    var creation_date: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameOfPlace.text = name
        descriptionOfPlace.text = text.html2String
        fetchImage()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
    }
    
    private func fetchImage(){
        guard let url = URL(string: photo) else {return}
        
        //MARK: - method with URLSession
        
//        let session = URLSession.shared
//
//        session.dataTask(with: url) { (data, responce, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            if let responce = responce{
//                print(responce)
//            }
//            if let data = data, let image = UIImage(data: data) {
//                DispatchQueue.main.async {
//                    self.activityIndicator.stopAnimating()
//                    self.imageOfPlace.image = image
//                }
//            }
//        }.resume()

        //MARK: - method with Alamofire
        AF.request(url).validate().responseData { dataResponse in
            switch dataResponse.result{
            case .success(let data):
                self.imageOfPlace.image = UIImage(data: data, scale:1)
                self.activityIndicator.stopAnimating()
            case .failure(let error):
                print(error)
            }
        }
    }
}

//MARK: -  delate html simbols
extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}
extension StringProtocol {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}
