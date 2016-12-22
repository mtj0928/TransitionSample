//
//  TransitionDelegate.swift
//  TransitionSample
//
//  Created by Junnosuke Matsumoto on 2016/12/17.
//  Copyright © 2016年 Junnosuke Matsumoto. All rights reserved.
//

import UIKit

protocol TransitionProtocol {
    func transitionImageView() -> UIImageView
    func trnasitionImageView(isHidden: Bool)
}
