//
//  SearchViewCell.swift
//  ItunesSearch
//
//  Created by Michael Aidoo on 2018-07-29.
//  Copyright © 2018 Michael Aidoo. All rights reserved.
//

import UIKit

class SearchViewCell: UITableViewCell {
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var songNameLabel: UILabel!
    
    @IBOutlet weak var songCoverImageView: UIImageView!
    
    static let cellIdentifier = "SearchCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(with song: Song) {
        artistNameLabel.text = song.artistName
        songNameLabel.text = song.songName
        songCoverImageView.loadImageCache(with: song.songPosterImageUrl.absoluteString, completion: nil)
    }
    
}
