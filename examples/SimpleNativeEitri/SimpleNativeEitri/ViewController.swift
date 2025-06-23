import UIKit
import Eitri

/**
 * This is a simple example of how to use Eitri in a native iOS application.
 * It creates a button that, when tapped, runs the "eitri-doctor" eitri-app.
 * eitri-doctor is a tool that helps you diagnose and fix issues with your Eitri setup.
 * It is a part of the Eitri framework and is used to ensure that your Eitri setup is working correctly.
 */
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let button = UIButton(type: .system)
        button.setTitle("eitri-doctor", for: .normal)
        button.backgroundColor = UIColor(red: 163/255, green: 217/255, blue: 65/255, alpha: 1.0)
        button.layer.cornerRadius = 25
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            button.widthAnchor.constraint(equalToConstant: 200),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    @objc func buttonTapped() {
        let eitriService = MainAppService.shared.eitriService
        eitriService.runOnTop(RunInput(
            slug: "eitri-doctor",
            navControllerToPush: EitriViewControllerUtils.topView()?.navigationController
        ))
    }

}
