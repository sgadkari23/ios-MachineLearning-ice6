//
//  ViewController.swift
//  ImageRecognition
//
//  Created by Supriya G on 3/28/21.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewDescription: UILabel!
    
   
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let imagePath = Bundle.main.path(forResource: "car", ofType: "jpeg")
        
        
        let imageURL = NSURL.fileURL(withPath: imagePath!)
        
        let modelFile = MobileNetV2()
        
        let model = try! VNCoreMLModel(for: modelFile.model)
    
        let handler = VNImageRequestHandler(url: imageURL)
        
        let request = VNCoreMLRequest(model: model, completionHandler: findResults)
        
        try! handler.perform([request])
    }
        
       
    func findResults(request: VNRequest, error: Error?) {

            guard let results = request.results as? [VNClassificationObservation] else {

                fatalError("Unable to get results")

            }
     

            var bestGuess = ""

            var bestConfidence: VNConfidence = 0
     

            for classification in results {

                if (classification.confidence > bestConfidence) {

                    bestConfidence = classification.confidence

                    bestGuess = classification.identifier

                }

            }


        imageViewDescription.text = "Image is: \(bestGuess) with confidence \(bestConfidence) out of 1"

        }

}

