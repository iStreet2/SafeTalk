//
//  GravarAudioViewController.swift
//  SafeTalk
//
//  Created by Gabriel Vicentin Negro on 21/05/24.
//

import UIKit
import AVFoundation

class GravarAudioViewController: UIViewController, AVAudioRecorderDelegate, AVAudioPlayerDelegate  {
    
    //MARK: Variáveis do CoreData
    var gravacao: Gravacao?
    
    //MARK: Variáveis
    
    var recordButton: UIButton = {
        
        let recordButton = UIButton()
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        recordButton.setTitle("Tap to Record", for: .normal)
        recordButton.titleLabel?.font = UIFont.preferredFont(forTextStyle: .title1)
        
        return recordButton
    }()
    
    var recordingSession: AVAudioSession!
    
    var audioRecorder: AVAudioRecorder!
    
    var audioPlayer: AVAudioPlayer!
    
    var playAudioButton: UIButton = {
        
        var button = UIButton()
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Play", for: .normal)
        return button
    }()
    
    //MARK: Componentes
    let image: UIImageView = {
        var image = UIImageView(image: UIImage(named: "BackgroundShapes"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    //MARK: Ciclo de vida
    override func viewDidLoad() {
        super.viewDidLoad()
        record()
        setElements()
    }

    
    //MARK: Funçoes de Componentes
    
    func setElements(){
        initBackground()
    }
    
    
    func initBackground(){
        //Adiciono minha imagem ao fundo da tela e aplico os constraints
        self.view.addSubview(image)
        self.view.backgroundColor = .background
        //Aplicar as constraints
        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            image.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            image.topAnchor.constraint(equalTo: self.view.topAnchor)
        ])
        //Mandar uma layer abaixo
        image.layer.zPosition = -1
        
    }
    
    func loadRecordingUI() {
        view.addSubview(recordButton)
        recordButton.addTarget(self, action: #selector(recordTapped), for: .touchUpInside)
        NSLayoutConstraint.activate([
            recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    func loadFailUI() {
        let failLabel = UILabel()
        failLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        failLabel.text = "Recording failed: please ensure the app has access to your microphone."
        failLabel.numberOfLines = 0
        view.addSubview(failLabel)
        NSLayoutConstraint.activate([
            failLabel.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 10)
        ])
    }
    
    func loadPlayButton(){
        view.addSubview(playAudioButton)
        playAudioButton.addTarget(self, action: #selector(playSound), for: .touchUpInside)
        NSLayoutConstraint.activate([
            playAudioButton.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 20)
        ])
    }
    
    
    //MARK: Funçoes de lógica
    
    func record(){
        recordingSession = AVAudioSession.sharedInstance()
       
        do {
            try recordingSession.setActive(true)
            try recordingSession.setCategory(.playAndRecord,mode: .default,options: [.allowAirPlay,.allowBluetoothA2DP,.mixWithOthers,.defaultToSpeaker])
            
            recordingSession.requestRecordPermission() { [unowned self] allowed in
                DispatchQueue.main.async {
                    if allowed {
                        self.loadRecordingUI()
                        self.loadPlayButton()
                    } else {
                        self.loadFailUI()
                    }
                }
            }
        } catch {
            self.loadFailUI()
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }

    func getAudioURL() -> URL {
        return getDocumentsDirectory().appendingPathComponent(getAudioName())
    }
    
    func startRecording() {

        recordButton.setTitle("Tap to Stop", for: .normal)

        let audioURL = getAudioURL()
        print(audioURL.absoluteString)

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]

        do {
            audioRecorder = try AVAudioRecorder(url: audioURL, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
        } catch {
            finishRecording(success: false)
        }
    }
    
    func finishRecording(success: Bool) {
        audioRecorder.stop()
        audioRecorder = nil

        if success {
            recordButton.setTitle("Tap to Re-record", for: .normal)
        } else {
            recordButton.setTitle("Tap to Record", for: .normal)

            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your whistle; please try again.", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "OK", style: .default))
            present(ac, animated: true)
        }
    }
    
    @objc func recordTapped() {
        if audioRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    @objc func playSound(){
        
        if playAudioButton.titleLabel?.text == "Play" {
            
            recordButton.isEnabled = false
            playAudioButton.setTitle("Stop", for: .normal)
            
            preparePlayer()
            audioPlayer.play()
            
        }else {
            
            audioPlayer.stop()
            playAudioButton.setTitle("Play", for: .normal)
            
        }
        
        
    }
    
    func preparePlayer(){
        
        let url = getAudioURL()
        
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url)
        } catch {
            print(error)
        }
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = 1
    }
    
    func createAudioCoreData(){
        //Aqui eu vou criar no coreData um arquivo String que contem o nome do audio que eu estou guardando
    }
    
    func getAudioName() -> String{
        //Aqui eu vou ver no CoreData quais são todos os nomes que tem, todos os numeros
        //A partir disso, eu vou definir qual o nome do meu audio
        
        return "audio.m4a"
    }
    
    //MARK: Funçoes do Delegate
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
        recordButton.isEnabled = true
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        
        playAudioButton.isEnabled = true
        playAudioButton.setTitle("Play", for: .normal)
        recordButton.isEnabled = true
    }

}

@available(iOS 17, *)
#Preview{
    return GravarAudioViewController()
}
