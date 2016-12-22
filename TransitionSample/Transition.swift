//
//  Transition.swift
//  TransitionSample
//
//  Created by Junnosuke Matsumoto on 2016/12/17.
//  Copyright © 2016年 Junnosuke Matsumoto. All rights reserved.
//

import UIKit

class Transition: NSObject {
    var isPresent = true
}


// MARK: - UIViewControllerAnimatedTransitioning

extension Transition: UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresent {
            animateTransitionForPresent(using: transitionContext)
        } else {
            animateTransitionForDismiss(using: transitionContext)
        }
    }

    private func animateTransitionForPresent(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromProtocol = getTransitionProtocol(viewController: fromVC),
            let toProtocol = getTransitionProtocol(viewController: toVC),
            let fromView = fromVC.view,
            let toView = toVC.view else {
                transitionContext.completeTransition(false)
                return
        }

        //遷移元、遷移先のUIImageViewのコピーを用意
        let fromImageView = fromProtocol.transitionImageView()
        let toImageView = toProtocol.transitionImageView()

        //fromImageViewの設定
        fromImageView.contentMode = .scaleAspectFill

        //containerViewの設定
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, aboveSubview: fromView)
        containerView.addSubview(fromImageView)
        toView.frame = fromView.frame

        //toViewの設定
        toView.alpha = 0.0

        //遷移の間は各ViewControllerのUIImageViewを非表示にする
        fromProtocol.trnasitionImageView(isHidden: true)
        toProtocol.trnasitionImageView(isHidden: true)

        //アニメーションの処理
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        toView.alpha = 1.0
                        fromImageView.frame.size = toImageView.imageSize ?? CGSize()
                        fromImageView.center = toImageView.center
        },completion: { (finished) -> Void in
            fromProtocol.trnasitionImageView(isHidden: false)
            toProtocol.trnasitionImageView(isHidden: false)
            fromImageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }

    private func animateTransitionForDismiss(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let fromProtocol = getTransitionProtocol(viewController: fromVC),
            let toProtocol = getTransitionProtocol(viewController: toVC),
            let fromView = fromVC.view,
            let toView = toVC.view else {
                transitionContext.completeTransition(false)
                return
        }

        //遷移元、遷移先のUIImageViewのコピーを用意
        let fromImageView = fromProtocol.transitionImageView()
        let toImageView = toProtocol.transitionImageView()

        //fromImageViewの設定
        fromImageView.contentMode = .scaleAspectFill
        let center = fromImageView.center
        fromImageView.frame.size = fromImageView.imageSize ?? CGSize()
        fromImageView.center = center

        //containerViewの設定
        let containerView = transitionContext.containerView
        containerView.insertSubview(toView, aboveSubview: fromView)
        containerView.addSubview(fromImageView)

        //toViewの設定
        toView.frame = fromView.frame
        toView.alpha = 0.0

        //遷移の間は各ViewControllerのUIImageViewを非表示にする
        fromProtocol.trnasitionImageView(isHidden: true)
        toProtocol.trnasitionImageView(isHidden: true)

        //アニメーションの処理
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        toView.alpha = 1.0
                        fromImageView.frame = toImageView.frame
        },completion: { (finished) -> Void in
            fromProtocol.trnasitionImageView(isHidden: false)
            toProtocol.trnasitionImageView(isHidden: false)
            fromImageView.removeFromSuperview()
            transitionContext.completeTransition(true)
        })
    }

    private func getTransitionProtocol(viewController: UIViewController?) -> TransitionProtocol? {
        guard var viewController = viewController else { return nil }

        while (viewController as? TransitionProtocol) == nil {
            if let tab = viewController as? UITabBarController {
                viewController = tab.selectedViewController!
            } else if let navi = viewController as? UINavigationController {
                let viewControllers = navi.childViewControllers
                viewController = navi.childViewControllers[viewControllers.count - 1]
            } else if let page = viewController as? UIPageViewController {
                viewController = page.viewControllers!.first!
            } else {
                return nil
            }
        }
        return viewController as? TransitionProtocol
    }
}


// MARK: - UIViewControllerTransitioningDelegate

extension Transition: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return self
    }
}
