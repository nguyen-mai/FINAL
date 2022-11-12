import UIKit

class ClassifyResultVC: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var model = DiseaseInfoViewEntity.Disease()
    private var arrayData = [DiseaseInfoViewEntity.ExpandedCell]()
    private var moreDetail = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupData() {
        arrayData = [
            DiseaseInfoViewEntity.ExpandedCell(title: Localization.Result.SymptomTitle, detail: self.model.symptomInfo),
            DiseaseInfoViewEntity.ExpandedCell(title: Localization.Result.ConditionTitle, detail: self.model.conditionInfo),
            DiseaseInfoViewEntity.ExpandedCell(title: Localization.Result.PreventionTitle, detail: self.model.treatmentInfo)
        ]
    }
    
    private func setupUI() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.registerCellNib(type: DiseaseInfoCell.self)
        tableView.registerCellNib(type: HeaderDiseaseInfoCell.self)
        tableView.registerCellNib(type: FooterDiseaseInfoCell.self)
        
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: - Handle actions
extension ClassifyResultVC {
    @objc private func dismissVC() {
        navigationController?.popViewController(animated: true)
    }
}

extension ClassifyResultVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCellNib(type: HeaderDiseaseInfoCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.configHeaderDiseaseInfoCell(content: model)
            return cell
        case 1...arrayData.count:
            guard let cell = tableView.dequeueReusableCellNib(type: DiseaseInfoCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.configDiseaseInfoCell(content: arrayData[indexPath.row - 1], moreDetail: moreDetail)
            cell.delegate = self
            return cell
        case arrayData.count + 1:
            guard let cell = tableView.dequeueReusableCellNib(type: FooterDiseaseInfoCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension ClassifyResultVC: DiseaseInfoCellDelegate, FooterDiseaseInfoCellDelegate {
    func tapExpandedButton(cell: DiseaseInfoCell) {
        moreDetail = !moreDetail
        guard let index = self.tableView.indexPath(for: cell) else {
            return
        }
        tableView.reloadRows(at: [index], with: .automatic)
    }
    
    func yesBtnTap(cell: FooterDiseaseInfoCell) {
        print("Yes")
    }
    
    func noBtnTapp(cell: FooterDiseaseInfoCell) {
        let ac = UIAlertController(title: "Label again", message: nil, preferredStyle: .alert)
        ac.addTextField(configurationHandler: nil)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(ac, animated: true, completion: nil)
    }
}
