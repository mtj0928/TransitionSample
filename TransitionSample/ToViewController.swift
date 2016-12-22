//
//  ToViewController.swift
//  TransitionSample
//
//  Created by Junnosuke Matsumoto on 2016/12/17.
//  Copyright © 2016年 Junnosuke Matsumoto. All rights reserved.
//

import UIKit

class ToViewController: UIViewController {

    @IBOutlet fileprivate weak var imageView: UIImageView!
    private var transition = Transition()
    var image: UIImage?

    override func viewDidLoad() {
        super.viewDidLoad()

        transitioningDelegate = transition
        imageView.image = image
    }

    @IBAction func tapButton(_ sender: Any) {
        transition.isPresent = false
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - TransitionProtocol

extension ToViewController: TransitionProtocol {

    func transitionImageView() -> UIImageView {
        let copyImageView = UIImageView(frame: imageView.frame)
        copyImageView.contentMode = imageView.contentMode
        copyImageView.clipsToBounds = true
        copyImageView.image = imageView.image
        return copyImageView
    }

    func trnasitionImageView(isHidden: Bool) {
        imageView?.isHidden = isHidden
    }
}
