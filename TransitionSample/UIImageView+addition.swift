//
//  UIImageView+addition.swift
//  TransitionSample
//
//  Created by Junnosuke Matsumoto on 2016/12/18.
//  Copyright © 2016年 Junnosuke Matsumoto. All rights reserved.
//

import UIKit
import AVFoundation

extension UIImageView {

    var imageSize: CGSize? {
        guard let image = image else { return nil }

        return AVMakeRect(aspectRatio: image.size, insideRect: bounds).size
    }
}
