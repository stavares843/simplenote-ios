import UIKit

final class ExtensionTransitioningManager: NSObject {
    var presentDirection = Direction.bottom
    var dismissDirection = Direction.bottom
}

// MARK: - UIViewControllerTransitioningDelegate Conformance

//
extension ExtensionTransitioningManager: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source _: UIViewController) -> UIPresentationController? {
        let presentationController = ExtensionPresentationController(presentedViewController: presented,
                                                                     presenting: presenting,
                                                                     presentDirection: presentDirection,
                                                                     dismissDirection: dismissDirection)
        return presentationController
    }

    func animationController(forPresented _: UIViewController,
                             presenting _: UIViewController,
                             source _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ExtensionPresentationAnimator(direction: presentDirection, isPresentation: true)
    }

    func animationController(forDismissed _: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ExtensionPresentationAnimator(direction: dismissDirection, isPresentation: false)
    }
}
