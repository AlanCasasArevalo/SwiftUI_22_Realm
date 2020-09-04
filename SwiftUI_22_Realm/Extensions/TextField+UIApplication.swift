
import UIKit

extension UIApplication {
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
