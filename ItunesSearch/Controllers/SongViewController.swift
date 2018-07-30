//
//  SongViewController.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation

class SongViewController: UIViewController {
    
    @IBOutlet weak var songImageView: UIImageView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    private var player: AVPlayer?
    
    var song: Song?

    override func viewDidLoad() {
        super.viewDidLoad()
        handleUI()
    }
    
    private func handleUI() {
        songImageView.loadImageCache(with: song?.songPosterImageUrl.absoluteString ?? "", completion: nil)
        artistNameLabel.text = song?.artistName
        songNameLabel.text = song?.songName
    }
    
    @IBAction func playButtonTapped(_ sender: Any) {
        guard let url = song?.songPreviewUrl else {
            return
        }
        player = AVPlayer(url: url)
        player?.play()
    }
    
    @IBAction func stopButtonTapped(_ sender: Any) {
        player = nil
    }
    
}
