//
//  ViewController.swift
//  DomasticAminalFinder
//
//  Created by Arhab Muhammad on 16/03/22.
//

import UIKit
import CoreML
import Vision
class ViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate
{

    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var classificationResult : [VNClassificationObservation] = []

    let imagePicker = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
    }
    func detect(image : CIImage) {



    guard let model = try? VNCoreMLModel(for: AnimalClassifer_1().model) else {

    fatalError("can't load ML model")

    }



    let request = VNCoreMLRequest(model: model) { request, error in

    guard let results = request.results as? [VNClassificationObservation],

    let topResult = results.first

    else {

    fatalError("unexpected result type from VNCoreMLRequest")

    }



    print(topResult)

    print(topResult.identifier)



    if topResult.identifier == ("Doosh") {

    DispatchQueue.main.async {

        self.nameLabel.text = "DOOSH 😍"

    }

    }

    else if topResult.identifier.contains("Leen") {

    DispatchQueue.main.async {

    self.nameLabel.text = "Leen 🤮"

    }

    }

    }



    let handler = VNImageRequestHandler(ciImage: image)



    do {

    try handler.perform([request])

    }

    catch {

    print(error)

    }



    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {



    if let image = info[.originalImage] as? UIImage {



    imageView.image = image

    imagePicker.dismiss(animated: true, completion: nil)

    guard let ciImage = CIImage(image: image) else {

    fatalError("couldn't convert uiimage to CIImage")

    }

    detect(image: ciImage)

    }

    }

    @IBAction func cameraButtonPressed(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .camera

        imagePicker.allowsEditing = false

        present(imagePicker, animated: true, completion: nil)


    }
    
}

