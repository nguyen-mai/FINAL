import UIKit

class DiseasesListVC: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    private let data: BlogViewEntity = BlogViewEntity()
    private var filteredData = [BlogViewEntity.Blog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = AppColor.LightGrayColor1
        table.backgroundColor = AppColor.LightGrayColor1
        
        filteredData = data.array
        configTable()
        setupSearchBar()
    }
    
    private func setupSearchBar() {
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = Localization.Home.Search.localized()
        searchBar.showsCancelButton = true
        searchBar.becomeFirstResponder()
        searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.hidesBottomBarWhenPushed = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
                
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func configTable() {
        table.delegate = self
        table.dataSource = self
    }
}

extension DiseasesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellNib(type: DiseaseCell.self, for: indexPath) else {
            return UITableViewCell()
        }
        let item = filteredData[indexPath.row]
        cell.configDiseaseCell(with: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: NameConstant.Storyboard.Home,
                              bundle: nil).instantiateVC(DetailDiseaseVC.self)
        let item = filteredData[indexPath.row]
        guard let urlImg = item.urlImg else {
            return
        }
        vc.img = urlImg
        vc.lbl = urlImg
        vc.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension DiseasesListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        
        if searchText == "" {
            filteredData = data.array
        }
        else {
            let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
            for name in data.array {
                if name.diseaseName.lowercased().contains(text) {
                    filteredData.append(name)
                }
            }
            
        }
        self.table.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

