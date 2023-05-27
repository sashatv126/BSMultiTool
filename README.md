# BSMultiTool

## Instalation 

To install this package, import 'url' in SPM

##Usage example

```swift 

class ViewController: UIViewController {

    private let customTransitioningDelegate = BSTransitioningDelegate()

    private func openBS() {
        let bottosSheetVC = BottomSheetVC()
        bottosSheetVC.transitioningDelegate = customTransitioningDelegate
        bottosSheetVC.modalPresentationStyle = .custom
        navigationController.present(vc)
    }
}

```
## PS.

inside SnapKit
