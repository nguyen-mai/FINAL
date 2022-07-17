import UIKit

class LanguageVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private let data: LanguageViewEntity = LanguageViewEntity()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension LanguageVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.listCountry.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: LanguageCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        let item = data.listCountry[indexPath.row]
        cell.configCell(with: item)
        return cell
    }
}

extension LanguageVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = data.listCountry[indexPath.row]
        AppPreferences.shared.setLanguage(item.id)
        let vc = UIStoryboard(name: NameConstant.Storyboard.Home, bundle: nil).instantiateVC(HomeVC.self)
        navigationController?.pushViewController(vc, animated: true)
    }
}
