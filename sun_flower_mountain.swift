import UIKit

class ConnectionViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var alternativeButton: UIButton!
    
    // MARK: - Properties
    var connection: Connection?
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set button title
        alternativeButton.setTitle("Connect", for: .normal)
    }
    
    // MARK: - Actions
    @IBAction func alternativeButtonTapped(_ sender: UIButton) {
        // show activity indicator
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        
        // attempt to establish connection
        if let connection = connection {
            
            connection.establish() { [weak self] result in
                
                // hide activity indicator
                activityIndicator.removeFromSuperview()
                
                switch result {
                case .success(_):
                    self?.showSuccessAlert()
                    
                case .failure(let error):
                    self?.showFailureAlert(reason: error.localizedDescription)
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    private func showSuccessAlert() {
        let alert = UIAlertController(title: "Connection Established", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: nil))
        present(alert, animated: true)
    }
    
    private func showFailureAlert(reason: String) {
        let alert = UIAlertController(title: "Connection Failed", message: reason, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true)
    }
}