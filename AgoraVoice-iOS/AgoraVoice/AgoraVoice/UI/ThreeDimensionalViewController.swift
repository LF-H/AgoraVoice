//
//  ThreeDimensionalViewController.swift
//  AgoraVoice
//
//  Created by CavanSu on 2020/9/8.
//  Copyright © 2020 Agora. All rights reserved.
//

import UIKit

class ThreeDimensionalViewController: RxViewController {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ableSwitch: UISwitch!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var backButton: UIButton!
    
    var audioEffectVM: AudioEffectVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = AudioEffectsLocalizable.threeDimensionalVoice()
        descriptionLabel.text = AudioEffectsLocalizable.threeDimensionalVoiceDescription() + "(\(AudioEffectsLocalizable.threeDimensionalVoiceDescription2()))"
        
        backButton.rx.tap.subscribe(onNext: { [unowned self] in
            self.navigationController?.popViewController(animated: true)
        }).disposed(by: bag)
                
        ableSwitch.isOn = (audioEffectVM.selectedAudioSpace.value == .threeDimensionalVoice)
        
        ableSwitch.rx.controlEvent(.valueChanged).map { [unowned self] (_) -> AudioSpace in
            return self.ableSwitch.isOn ? .threeDimensionalVoice : .disable
        }.bind(to: audioEffectVM.selectedAudioSpace).disposed(by: bag)
        
        ableSwitch.rx.isOn.bind(to: slider.rx.isEnabled).disposed(by: bag)
        
        slider.value = Float(audioEffectVM.selectedThreeDimensionalVoice.value)
        
        slider.rx.value.subscribe(onNext: { [unowned self] (value) in
            self.audioEffectVM.selectedThreeDimensionalVoice.accept(Int(value))
        }).disposed(by: bag)
    }
}
