import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var TimerTitle: UILabel!
    @IBOutlet weak var TimerBar: UIProgressView!
    
    let eggTime = [
        "Soft" : 3,
        "Medium" : 4,
        "Hard" : 7
    ]
    
    var player: AVAudioPlayer!
    var totalTime = 0
    var secPassed = 0
    var timer = Timer()
    
    @IBAction func HardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        TimerTitle.text = "How do you like your eggs?"
        let hardness = sender.currentTitle!
        
        totalTime = eggTime[hardness]!
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    @objc func updateCounter() {
        if secPassed < totalTime {
            secPassed += 1
            let percentageProgress = Float(secPassed) / Float(totalTime)
            TimerBar.progress = percentageProgress
            
        }else {
            timer.invalidate()
            secPassed = 0
            totalTime = 0
            playSound(AlarmVoice: "alarm_sound")
            TimerTitle.text = "Done!"
        }
    }
    
    func playSound(AlarmVoice: String){
        let url = Bundle.main.url(forResource: AlarmVoice, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
    

}
