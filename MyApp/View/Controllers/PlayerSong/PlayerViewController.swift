//
//  ScreenPlayerSongViewController.swift
//  MyApp
//
//  Created by Tran Dinh Nhan on 6/14/18.
//  Copyright © 2018 Nhan Tran. All rights reserved.
//

import UIKit
import SafariServices
import AVFoundation
import SDWebImage
import RealmSwift

final class PlayerViewController: UIViewController, SPTAudioStreamingDelegate, SPTAudioStreamingPlaybackDelegate {

    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var nameSong: UILabel!
    @IBOutlet weak var imageBackgound: UIImageView!
    @IBOutlet weak var singerSong: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var runningTimeLable: UILabel!
    // Variables
    var auth = SPTAuth.defaultInstance()
    var session: SPTSession!
    // Player
    var player: SPTAudioStreamingController?
    var loginUrl: URL?
    var viewModel: PlayerViewModel?
    var isChangingProgress: Bool?
    var avAudio: AVAudioPlayer!
    var favorite = FavoriteSongViewModel()
    var playlists = [SPTPartialPlaylist]()
    var position = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpScreen()
        updateView()
        updateAfterFirstLogin()
    }

    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didChange metadata: SPTPlaybackMetadata!) {
        updateView()
    }

    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didChangePosition position: TimeInterval) {
        guard let progress = progressSlider else { return }
        guard let duration = player?.metadata.currentTrack?.duration else { return }
        progress.value = Float(position / duration)
        convertTimingToText(duration, label: durationLabel)
        convertTimingToText(position, label: runningTimeLable)
        imageView.rotate()
    }
    // Play background:
    func audioStreaming(_ audioStreaming: SPTAudioStreamingController!, didChangePlaybackStatus isPlaying: Bool) {
        if isPlaying {
            self.activateAudioSession()
        } else {
            self.deactivateAudioSession()
        }
    }

    func activateAudioSession() {
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback)
        try? AVAudioSession.sharedInstance().setActive(true)
    }

    // MARK: Deactivate audio session
    func deactivateAudioSession() {
        try? AVAudioSession.sharedInstance().setActive(false)
    }

    func setUpScreen() {
        progressSlider.setThumbImage(#imageLiteral(resourceName: "circle_y"), for: .normal)
        progressSlider.value = 0
        imageView.layer.cornerRadius = imageView.bounds.width / 2
        imageView.clipsToBounds = true
    }

    func initializaPlayer(authSession: SPTSession) {
        if self.player == nil {
            self.player = SPTAudioStreamingController.sharedInstance()
            self.player?.playbackDelegate = self
            self.player?.delegate = self
            try? player?.start(withClientId: auth?.clientID)
            self.player?.login(withAccessToken: authSession.accessToken)
        }
    }

    func updateAfterFirstLogin() {
        let userDefaults = UserDefaults.standard
        if let sessionObj: AnyObject = userDefaults.object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as? Data
            guard let sessionDataObj1 = sessionDataObj else { return }
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj1) as? SPTSession
            self.session = firstTimeSession
            initializaPlayer(authSession: session)
        }
    }

    func audioStreamingDidLogin(_ audioStreaming: SPTAudioStreamingController!) {
        beginPlayingSong()
    }

    func beginPlayingSong() {
        self.player?.playSpotifyURI(viewModel?.dataPlays[position].uri, startingWith: 0, startingWithPosition: TimeInterval(position), callback: { (error) in
            if error != nil {
                print("play..............")
                self.setUpScreen()
            } else {
                print("Not play -------------")
                self.actionPlaySong(true)
                self.imageView.rotate()
            }
        })

    }

    var isPlaying: Bool = false {
        didSet {
            changeButtonImage(isPlaying)
        }
    }
    
    @IBAction func backScreenButton(_ sender: Any) {
        dismiss(animated: true)
    }

    @IBAction func shufflePlaySongButton(_ sender: Any) {
        guard let sender = sender as? SPTErrorableOperationCallback else { return }
        self.player?.setShuffle(true, callback: sender)
    }

    @IBAction func nextButton(_ sender: Any) {
        player?.skipNext(nil)
        actionPlaySong(!isPlaying)
        favoriteButton.setImage(#imageLiteral(resourceName: "ic_favorite_white_48dp"), for: .normal)
        guard let positionMax = viewModel?.dataPlays.count else { return }
        position += 1
        if position >= positionMax {
            position = 0
            beginPlayingSong()
        } else {
            beginPlayingSong()
        }
    }

    @IBAction func backButton(_ sender: Any) {
        player?.skipPrevious(nil)
        actionPlaySong(!isPlaying)
        favoriteButton.setImage(#imageLiteral(resourceName: "ic_favorite_white_48dp"), for: .normal)
        guard let positionMax = viewModel?.dataPlays.count else { return }
        print(positionMax)
        position += 1
        if position < 0 {
            position = positionMax - 1
            beginPlayingSong()
        } else {
            beginPlayingSong()
        }
    }

    @IBAction func playButton(_ sender: Any) {
        if let isPlaying = player?.playbackState.isPlaying {
            actionPlaySong(!isPlaying)
        }
    }

    @IBAction func seekValueChanged(_ sender: Any) {
        isChangingProgress = false
        guard let duration = player?.metadata.currentTrack?.duration else { return }
        let dest = Float(duration) * self.progressSlider.value
        print(progressSlider.value)
        player?.seek(to: TimeInterval(dest), callback: nil)
    }

    @IBAction func proggressTouchDown(_ sender: Any) {
        isChangingProgress = true
    }

    @IBAction func addPlaylistAlbumButton(_ sender: Any) {
        addAlbum()
    }

    @IBAction func favoriteButton(_ sender: Any) {
        addFavorite()
    }

    func addAlbum() {
        let alert = UIAlertController(title: "★★★★★ HELLO ★★★★★", message: "Do you want add this song to my album?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                guard let player = self.player else { return }
                self.viewModel?.addObjectAlbum(data: player)
            case .cancel:
                break
            case .destructive:
                break
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func addFavorite() {
        let alert = UIAlertController(title: "★★★★★ HELLO ★★★★★", message: "Do you want add this song to favorite playlist?", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                guard let player = self.player else { return }
                self.viewModel?.addOject(data: player)
                self.favoriteButton.setImage(#imageLiteral(resourceName: "ic_favorite_red_48dp"), for: .normal)
            case .cancel:
                break
            case .destructive:
                break
            }
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }

    func changeButtonImage(_ playing: Bool) {
        playButton.setImage(playing ? #imageLiteral(resourceName: "ic_play"): #imageLiteral(resourceName: "ic_pause"), for: .normal)
    }

    private func updateView() {
        guard let viewModel = viewModel else { return }
        position = viewModel.indexSelected
        guard let player = player else { return }
        nameSong.text = player.metadata.currentTrack?.name
        singerSong.text = player.metadata.currentTrack?.artistName
        if let urlThumb = player.metadata.currentTrack?.albumCoverArtURL {
            imageView.sd_setImage(with: URL(string: urlThumb))
            imageBackgound.sd_setImage(with: URL(string: urlThumb))
        }
    }

    func actionPlaySong(_ playing: Bool) {
        if playing {
            self.player?.setIsPlaying(true, callback: nil)
            isPlaying = false
            print("--------------------Play------------------")
            imageView.resumeRotateCD()
        } else {
            self.player?.setIsPlaying(false, callback: nil)
            isPlaying = true
            print("--------------------------Not Play------------------")
            imageView.pauseRotateCD()
        }
    }

    func convertTimingToText(_ time: Double, label: UILabel) {
        let minute = Int(time / 60)
        let seconds = Int(time - Double(minute * 60))
        setTimingSongForLabel(minute, seconds: seconds, label: label)
    }

    func setTimingSongForLabel(_ minute: Int, seconds: Int, label: UILabel) {
        let mStr = minute > 9 ? "\(minute)" : "0\(minute)"
        let sStr = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        label.text = "\(mStr) : \(sStr)"
    }
}
