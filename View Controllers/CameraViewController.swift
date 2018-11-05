//
//  CameraViewController.swift
//  sample-app
//
//  Created by Takudzwa Mhonde on 2018-10-30.
//  Copyright © 2018 Takudzwa Mhonde. All rights reserved.
//

import UIKit
import AVFoundation // for camera
class CameraViewController: UIViewController {

    var captureSession = AVCaptureSession()
    var frontCamera: AVCaptureDevice?
    var backCamera: AVCaptureDevice?
    var currentCamera: AVCaptureDevice?
    var photoOutput: AVCapturePhotoOutput?
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    var image: UIImage?
    // double tap to switch from back to facing camera
    var toggleCameraGestureRecognizer =  UITapGestureRecognizer()
    
    // var camera = Camera()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        startRunningCaptureSession()
        toggleCameraSetup()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cameraBtnPressed_TouchUpInside(_ sender: Any){
        let settings = AVCapturePhotoSettings()
        photoOutput?.capturePhoto(with: settings, delegate: self)
        performSegue(withIdentifier: "PhotoPreviewSegue", sender: nil)
    }
    
    @IBAction func backBtnPressed_TouchUpInside(_ sender: Any){
        dismiss(animated: true, completion: nil)
    }
    
    // put in class
    
    func setupCaptureSession() {
        //preset prop to specify res and quality
        captureSession.sessionPreset = AVCaptureSession.Preset.photo // full res
    }
    func setupDevice() {
        // discovery session - used to specify the device to be used
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        // find out camera devices
        let devices = deviceDiscoverySession.devices
        for device in devices {
            if device.position == AVCaptureDevice.Position.back{
                backCamera = device
            }
            else if device.position == AVCaptureDevice.Position.front
            {
                frontCamera = device
            }
        }
        // default state
        currentCamera = backCamera
    }
    func setupInputOutput(){
        // check if device has a camera
        do {
            let captureDeviceInput =  try AVCaptureDeviceInput(device: currentCamera!)
            captureSession.addInput(captureDeviceInput)
            photoOutput = AVCapturePhotoOutput()
            photoOutput?.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        }
        catch let error {
            print(error)
        }
    }
    
    func setupPreviewLayer(){
        // create camera preview layer -- session has input and output of device
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // indicate the aspect ratio or viewmode of video -- aspect fill
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        //
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        // set a frame of the layer
        cameraPreviewLayer?.frame = self.view.frame
        //
        self.view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
    func startRunningCaptureSession(){
        // to get an image from the camera
        captureSession.startRunning()
    }
    func toggleCameraSetup() {
        //toggle the camera
        toggleCameraGestureRecognizer.numberOfTapsRequired = 2
        // class instance will trigger action
        toggleCameraGestureRecognizer.addTarget(self, action: #selector (toggleCamera))
        // add a gesture to the screen
        view.addGestureRecognizer(toggleCameraGestureRecognizer)
    }
    // need objc object
    @objc private func toggleCamera () {
        // begin new configuration
        captureSession.beginConfiguration()
        let newCamera = (currentCamera?.position == .back) ? frontCamera : backCamera
        
        for inputCapture in captureSession.inputs {
            captureSession.removeInput(inputCapture as! AVCaptureDeviceInput)
        }
        do {
            let cameraInput = try AVCaptureDeviceInput(device: newCamera!)
            // might cause interesting error
            if captureSession.canAddInput(cameraInput){
                captureSession.addInput(cameraInput)
                currentCamera = newCamera
                // make the new camera the new device
                captureSession.commitConfiguration()
            }
        }
        catch let error {
            print(error)
            return
        }
        // try to move if ... here
    }
    
    // stays in here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PhotoPreviewSegue" {
            // might make this a class obj in the ppVC
            if let photoPreviewViewController = segue.destination as? PhotoPreviewViewController{
                photoPreviewViewController.image = self.image
            }
        }
    }
    
   

}

// extension file
extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        // process photo variable
        if let imageData = photo.fileDataRepresentation() {
           
            image = UIImage(data: imageData)
            performSegue(withIdentifier: "PhotoPreviewSegue", sender: nil)
            // if saved, push to the global gallery.imagesArray
        }
    }
}
