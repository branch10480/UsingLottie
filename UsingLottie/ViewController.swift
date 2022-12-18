//
//  ViewController.swift
//  UsingLottie
//
//  Created by Toshiharu Imaeda on 2022/12/18.
//

import UIKit
import Lottie
import SnapKit

class ViewController: UIViewController {
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var segmentControl: UISegmentedControl!

    private let animationView = LottieAnimationView()
    private var animationName: AnimationName = .lottie

    private enum AnimationName: String {
        case lottie
        case dotLottie
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupAnimation()
    }

    @IBAction private func didChangeSegmentControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: animationName = .lottie
        default: animationName = .dotLottie
        }
        setupAnimation()
    }
}

private extension ViewController {
    func setup() {
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop

        animationView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(animationView)
        animationView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    func setupAnimation() {
        if let animation = LottieAnimation.named(animationName.rawValue) {
            animationView.animation = animation
            animationView.play()
            return
        }

        DotLottieFile.named(animationName.rawValue) { [weak self] result in
            guard case Result.success(let lottie) = result else { return }
            self?.animationView.loadAnimation(from: lottie)
            self?.animationView.play()
        }
    }
}

