import UIKit
import AVKit
import Vision

class CameraVC: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    let captureSession = AVCaptureSession()
    
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
        self.navigationController?.popViewController(animated: true)
        self.captureSession.stopRunning()
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
                self.result = Localization.AppleDisease.AppleScab.localized()
                
            case "Apple___Black_rot":
                self.result = Localization.AppleDisease.AppleBlackRot.localized()
                
            case "Apple___Cedar_apple_rust":
                self.result = Localization.AppleDisease.AppleCedar.localized()
                
            case "Apple___healthy", "Blueberry___healthy", "Cherry_(including_sour)___healthy", "Corn_(maize)___healthy", "Grape___healthy", "Peach___healthy", "Pepper,_bell___healthy", "Potato___healthy", "Raspberry___healthy", "Soybean___healthy", "Strawberry___healthy", "Tomato___healthy":
                self.result = Localization.Result.Healthy
                
            case "Cherry_(including_sour)___Powdery_mildew":
                self.result = Localization.Cherry.CherryPowderyMildew.localized()
                
            case "Corn_(maize)___Cercospora_leaf_spot Gray_leaf_spot":
                self.result = Localization.CornDisease.CornGraySpot.localized()
                
            case "Corn_(maize)___Common_rust_":
                self.result = Localization.CornDisease.CornRust.localized()
                
            case "Corn_(maize)___Northern_Leaf_Blight":
                self.result = Localization.CornDisease.CornNorthenBlight.localized()
                
            case "Grape___Black_rot":
                self.result = Localization.Grape.BlackRot.BlackRot.localized()
                
            case "Grape___Esca_(Black_Measles)":
                self.result = Localization.Grape.Esca.Esca.localized()
                
            case "Grape___Leaf_blight_(Isariopsis_Leaf_Spot)":
                self.result = Localization.Grape.GrapeLeafBlight.GrapeLeafBlight.localized()
                
            case "Orange___Haunglongbing_(Citrus_greening)":
                self.result = Localization.Orange.OrangeHaunglongbing.localized()
                
            case "Peach___Bacterial_spot":
                self.result = Localization.Peach.PeachBacterialSpot.localized()
                
            case "Pepper,_bell___Bacterial_spot":
                self.result = Localization.PepperBell.BacterialSpot.BacterialSpot.localized()
                
            case "Potato___Early_blight":
                self.result = Localization.Potato.EarlyBlight.EarlyBlight.localized()
                
            case "Potato___Late_blight":
                self.result = Localization.Potato.LateBlight.LateBlight.localized()
                
            case "Squash___Powdery_mildew":
                self.result = Localization.Squash.SquashPowderyMildew.localized()
                
            case "Strawberry___Leaf_scorch":
                self.result = Localization.Strawberry.StrawberryLeafScorch.localized()
                
            case "Tomato___Bacterial_spot":
                self.result = Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpot.localized()
                
            case "Tomato___Early_blight":
                self.result = Localization.Tomato.TomatoEarlyBlight.TomatoEarlyBlight.localized()
                
            case "Tomato___Late_blight":
                self.result = Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpot.localized()
                
            case "Tomato___Leaf_Mold":
                self.result = Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpot.localized()
                
            case "Tomato___Septoria_leaf_spot":
                self.result = Localization.Tomato.TomatoBacterialSpot.TomatoBacterialSpot.localized()
                
            case "Tomato___Spider_mites Two-spotted_spider_mite":
                self.result = Localization.Tomato.TomatoSpiderMites.TomatoSpiderMites.localized()
                
            case "Tomato___Target_Spot":
                self.result = Localization.Tomato.TomatoTargetSpot.TomatoTargetSpot.localized()
                
            case "Tomato___Tomato_Yellow_Leaf_Curl_Virus":
                self.result = Localization.Tomato.TomatoYellowLeafCurlVirus.TomatoYellowLeafCurlVirus.localized()
                
            case "Tomato___Tomato_mosaic_virus":
                self.result = Localization.Tomato.TomatoMosaicVirus.TomatoMosaicVirus.localized()
                
            default:
                self.result = Localization.Result.NoResult.localized()
            }
            let result = firstObservation.confidence * 100
            let confidence = String(format: "%.2f", result)
            DispatchQueue.main.async {
                self.identifierLabel.text = "\(self.result.localized()): \(confidence)%"
            }
        }
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
}
