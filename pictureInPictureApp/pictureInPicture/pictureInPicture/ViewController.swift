//
//  ViewController.swift
//  pictureInPicture
//
//  Created by Clemens Stift on 19.11.18.
//  Copyright © 2018 Clemens Stift. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    // Image Upload Feature Fields
    @IBOutlet weak var imageField: UIImageView!
    let imagePickerView: UIImagePickerController = UIImagePickerController()
    @IBOutlet weak var recordButton: UIButton!
    
    // Audio recording feature fields
    let fileMgr = FileManager.default
    let recordSettings = [
        AVEncoderAudioQualityKey: AVAudioQuality.min.rawValue,
        AVEncoderBitRateKey: 16,
        AVNumberOfChannelsKey: 2,
        AVSampleRateKey: 44100.0
        ] as [String: Any]
    var audioRecorder : AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        imagePickerView.sourceType = .photoLibrary
        imagePickerView.delegate = self
        
        // Setup for Audio
        let dirPaths = fileMgr.urls(for: .documentDirectory, in: .userDomainMask)
        let soundFileURL = dirPaths[0].appendingPathComponent("recording.caf")
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
        } catch {
            print("Mistakes were made setting a category for the audio session.")
        }
        // Creating Audio recorder
        do {
            try audioRecorder = AVAudioRecorder(url: soundFileURL, settings: recordSettings)
                audioRecorder!.prepareToRecord()
        } catch {
            print("Mistakes were made creating an audio recorder.")
        }
    }
    
    @IBAction func startRecording(_ sender: Any) {
        if (!audioRecorder!.isRecording){
            audioRecorder!.record();
            recordButton.setTitle("Stop", for: .normal)
        }
        
        if(audioRecorder!.isRecording){
            audioRecorder!.stop()
            recordButton.setTitle("Record", for: .normal)
        }
    }
    
    @IBAction func uploadButton(_ sender: Any) {
        self.present(imagePickerView, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imagePickerView.dismiss(animated:true, completion: nil)
        imageField.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
}
