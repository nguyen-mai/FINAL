import UIKit
import AVKit
import Vision

class CameraVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    private let identifierLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: AppImage.Icon.Back)?.withTintColor(AppColor.GreenColor!), for: .normal)
        button.addTarget(self, action: #selector(leftBtnTapped), for: .touchUpInside)
        return button
    }()
    
    private var result: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupIdentifierConfidenceLabel()
        setupBackButton()
        
        tabBarController?.tabBar.isHidden = true
        view.backgroundColor = AppColor.WhiteColor
    
        let captureSession = AVCaptureSession()
        captureSession.sessionPreset = .photo
        
        guard let captureDevice = AVCaptureDevice.default(for: .video) else {
            return
        }
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else {
            return
        }
        captureSession.addInput(input)
        captureSession.startRunning()
        
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        view.layer.addSublayer(previewLayer)
        previewLayer.frame = view.frame
        
        let dataOutput = AVCaptureVideoDataOutput()
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let tabBarController = self.tabBarController as! BaseTabBarController
        tabBarController.showTabBar()
    }
    
    @objc func leftBtnTapped() {
        tabBarController?.selectedIndex = 0
    }
    
    private func setupIdentifierConfidenceLabel() {
        view.addSubview(identifierLabel)
        identifierLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -32).isActive = true
        identifierLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        identifierLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        identifierLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func setupBackButton() {
        view.addSubviews(backButton)
        backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 25).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        backButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
    }
    
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else {
            return
        }
        guard let model = try? VNCoreMLModel(for: ClassifierModel(configuration: MLModelConfiguration()).model) else {
            return
        }
        let request = VNCoreMLRequest(model: model) { (finishReq, err) in
            // perhaps check error
            guard let results = finishReq.results as? [VNClassificationObservation] else {
                return
            }
            guard let firstObservation = results.first else {
                return
            }
            print(firstObservation.identifier, firstObservation.confidence)
            switch firstObservation.identifier {
            case "Apple___Apple_scab":
                self.result = "Apple Scab"
                
            case "Apple___Black_rot":
                self.result = "Apple Black Rot"
                
            case "Apple___Cedar_apple_rust":
                self.result = "Apple Cedar Rust"
                
            case "Apple___healthy", "Blueberry___healthy", "Cherry_(including_sour)___healthy", "Corn_(maize)___healthy", "Grape___healthy", "Peach___healthy", "Pepper,_bell___healthy", "Potato___healthy", "Raspberry___healthy", "Soybean___healthy", "Strawberry___healthy", "Tomato___healthy":
                self.result = "Healthy"
                
            case "Cherry_(including_sour)___Powdery_mildew":
                self.result = "Cherry Powdery Mildew"
                
            case "Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot":
                self.result = ""
                
            case "Corn_(maize)___Common_rust_":
                self.result = ""
                
            case "Corn_(maize)___Northern_Leaf_Blight":
                self.result = ""
                
            case "Grape___Black_rot":
                self.result = ""
                
            case "Grape___Esca_(Black_Measles)":
                self.result = ""
                
            case "Grape___Leaf_blight_(Isariopsis_Leaf_Spot)":
                self.result = ""
                
            case "Orange___Haunglongbing_(Citrus_greening)":
                self.result = ""
                
            case "Peach___Bacterial_spot":
                self.result = ""
                
            case "Pepper,_bell___Bacterial_spot":
                self.result = ""
                
            case "Potato___Early_blight":
                self.result = ""
                
            case "Potato___Late_blight":
                self.result = ""
                
            case "Squash___Powdery_mildew":
                self.result = ""
                
            case "Strawberry___Leaf_scorch":
                self.result = ""
                
            case "Tomato___Bacterial_spot":
                self.result = ""
                
            case "Tomato___Early_blight":
                self.result = ""
                
            case "Tomato___Late_blight":
                self.result = ""
                
            case "Tomato___Leaf_Mold":
                self.result = "Tomato Leaf Mold"
                
            case "Tomato___Septoria_leaf_spot":
                self.result = "Tomato Septoria Leaf Spot"
                
            case "Tomato___Spider_mites Two-spotted_spider_mite":
                self.result = "Tomato Spider Mites"
                
            case "Tomato___Target_Spot":
                self.result = "Tomato Target Spot"
                
            case "Tomato___Tomato_Yellow_Leaf_Curl_Virus":
                self.result = "Tomato Yellow Leaf Curl Virus"
                
            case "Tomato___Tomato_mosaic_virus":
                self.result = "Tomato Mosaic Virus"
                
            default:
                self.result = Localization.Result.NoResult.localized()
            }
            let confidence = String(format: "%.2f", firstObservation.confidence)
            DispatchQueue.main.async {
                self.identifierLabel.text = "\(self.result.localized()) \(confidence)"
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
}
