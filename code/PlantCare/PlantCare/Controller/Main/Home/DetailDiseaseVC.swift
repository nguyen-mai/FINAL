import UIKit

class DetailDiseaseVC: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Variables
    var model = DiseaseInfoViewEntity.Disease()
    private var arrayData = [DiseaseInfoViewEntity.ExpandedCell]()
    private var moreDetail = true
    
    var urlImage: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.backgroundColor = AppColor.GreenColor
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    private func setupUI() {
        tableView.registerCellNib(type: DiseaseInfoCell.self)
        tableView.registerCellNib(type: HeaderReferenceCell.self)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupData() {
        arrayData = [
            DiseaseInfoViewEntity.ExpandedCell(title: Localization.Result.SymptomTitle, detail: self.model.symptomInfo),
            DiseaseInfoViewEntity.ExpandedCell(title: Localization.Result.ConditionTitle, detail: self.model.conditionInfo),
            DiseaseInfoViewEntity.ExpandedCell(title: Localization.Result.PreventionTitle, detail: self.model.treatmentInfo)
        ]
    }
}

extension DetailDiseaseVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            guard let cell = tableView.dequeueReusableCellNib(type: HeaderReferenceCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            if urlImage.isEmpty {
                cell.configHeaderDiseaseInfoCell(content: model)
            } else {
                cell.configHeaderDiseaseInfoCell(content: model, urlImage: urlImage)
            }
            return cell
        case 1...arrayData.count:
            guard let cell = tableView.dequeueReusableCellNib(type: DiseaseInfoCell.self, for: indexPath) else {
                return UITableViewCell()
            }
            cell.configDiseaseInfoCell(content: arrayData[indexPath.row - 1], moreDetail: moreDetail)
            cell.delegate = self
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension DetailDiseaseVC: DiseaseInfoCellDelegate {
    func tapExpandedButton(cell: DiseaseInfoCell) {
        moreDetail = !moreDetail
        guard let index = self.tableView.indexPath(for: cell) else {
            return
        }
        tableView.reloadRows(at: [index], with: .automatic)
    }
}
