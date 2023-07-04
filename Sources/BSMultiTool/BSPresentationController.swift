//
//  BSPresentationController.swift
//  
//
//  Created by Александр Александрович on 27.05.2023.
//

import UIKit
import SnapKit

final public class BSPresentationController: UIPresentationController {

    override public var shouldPresentInFullscreen: Bool {
        false
    }

    private lazy var dimmView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.addGestureRecognizer(tapRecognizer)
        return view
    }()

    private lazy var tapRecognizer: UITapGestureRecognizer = {
        let recognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(handleTap)
        )
        return recognizer
    }()

    override public func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()

        guard let containerView = containerView,
              let presentedView = presentedView
        else { return }

        containerView.addSubview(dimmView)
        containerView.addSubview(presentedView)

        dimmView.alpha = 0
        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 1
        }

       setupConstraints()
    }

    override public func presentationTransitionDidEnd(_ completed: Bool) {
        if !completed {
            dimmView.removeFromSuperview()
            presentedView?.removeFromSuperview()
        }
    }

    override public func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()

        performAlongsideTransitionIfPossible {
            self.dimmView.alpha = 0
        }
    }

    private func performAlongsideTransitionIfPossible(_ animation: @escaping () -> Void ) {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            animation()
            return
        }

        coordinator.animate { _ in
            animation()
        }
    }

    private func setupConstraints() {
        dimmView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        presentedView?.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.lessThanOrEqualToSuperview().offset(-(containerView?.safeAreaInsets.top ?? 00))
        }
    }

    @objc
    private func handleTap(_ sender: UITapGestureRecognizer) {
        presentingViewController.dismiss(animated: true)
    }
}
