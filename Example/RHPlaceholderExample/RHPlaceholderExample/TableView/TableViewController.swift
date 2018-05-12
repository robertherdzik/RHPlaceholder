
import UIKit
import RHPlaceholder

class TableViewController: UITableViewController {
    
    private var dataLoaded = false
    private let placeholderMarker = Placeholder()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupVC()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.dataLoaded = true
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 333 // TODO [🌶]: get height from cell
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as! MyCell
        
        if dataLoaded {
            placeholderMarker.remove()
        } else {
            placeholderMarker.register(cell.getAnimableSubviews())
            placeholderMarker.startAnimation()
        }
        
        return cell
    }
    
    private func setupVC() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .automatic
    }
}
