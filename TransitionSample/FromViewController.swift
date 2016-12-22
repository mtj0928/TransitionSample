//
//  FromViewController.swift
//  TransitionSample
//
//  Created by Junnosuke Matsumoto on 2016/12/17.
//  Copyright © 2016年 Junnosuke Matsumoto. All rights reserved.
//

import UIKit

class FromViewController: UIViewController {

    @IBOutlet private weak var leftImageView: UIImageView!
    @IBOutlet private weak var rightImageView: UIImageView!
    fileprivate weak var selectedImageView: UIImageView?

    override func viewDidLoad() {
        super.viewDidLoad()

        setupImageView()
    }

    private func setupImageView() {
        [leftImageView, rightImageView].forEach { imageView in
            let gesture = UITapGestureRecognizer(target: self, action: #selector(FromViewController.tapImageView(sender:)))
            imageView?.addGestureRecognizer(gesture)
        }
    }

    @objc private func tapImageView(sender: UITapGestureRecognizer) {
        guard let imageView = sender.view as? UIImageView else { return }

        selectedImageView = imageView
        guard let toViewController = storyboard?.instantiateViewController(withIdentifier: "next") as? ToViewController else { return }

        toViewController.image = selectedImageView?.image
        present(toViewController, animated: true, completion: nil)
    }
}


// MARK: - TransitionProtocol

extension FromViewController: TransitionProtocol {

    func transitionImageView() -> UIImageView {
        guard let selectedImageView = selectedImageView else { return UIImageView() }

        let copyImageView = UIImageView(frame: selectedImageView.frame)
        copyImageView.contentMode = selectedImageView.contentMode
        copyImageView.image = selectedImageView.image
        copyImageView.clipsToBounds = true
        return copyImageView
    }

    func trnasitionImageView(isHidden: Bool) {
        selectedImageView?.isHidden = isHidden
    }
}
