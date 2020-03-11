import UIKit
import RevoFoundation

class ViewController: UIViewController, ContentStatusActionDelegate {

    @IBOutlet weak var asyncButton: AsyncButton!
    @IBOutlet weak var stateTableView: ContentStatusTableView!
    @IBOutlet weak var stateView: ContentStatusView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onAsyncButtonPressed(_ sender: Any) {
        asyncButton.animateProgress()
                
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [unowned self] in
            self.asyncButton.animateFailed()
            //self.asyncButton.animateSuccess()
            self.stateTableView.state = .empty(image:nil, title:"Empty", description:"Add Something", actionTitle:"Do Something", delegate:self)
            self.stateView.state      = .content
        }
        
        stateTableView.state = .loading(text: "Loading...")
        stateView.state      = .loading(text: "Loading2...")
    }
    
    func onContentStatusAction(_ sender:UIButton){
        onAsyncButtonPressed(sender)
    }
    
    @IBAction func onAlertPressed(_ sender: Any) {
        let a = Alert(alert: "hola", "que tal", okText: "Ok", cancelText: "No") { result in
            print(result)
        }
        present(a, animated: true)
    }
    
    @IBAction func onShowPinPressed(_ sender: Any) {
        let pin = PinViewController()
        pin.isPinValid = { $0 == "0000" }
        self.present(pin, animated: true, completion: nil)
    }
}

