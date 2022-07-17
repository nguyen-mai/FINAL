import UIKit

class OnboardingVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var pageControl: UIPageControl!
    @IBOutlet private weak var skipButton: UIButton!
    @IBOutlet private weak var nextButton: UIButton!
    
    // MARK: - Variables
    private let slides: OnboardingViewEntity = OnboardingViewEntity()
    private var language: String = AppPreferences.shared.language.rawValue
    private var isVnLanguage: Bool = true
    private var currentPage: Int = 0 {
        didSet {
            pageControl.currentPage = currentPage
            if currentPage == slides.array.count - 1 {
                nextButton.setTitle(Localization.Onboarding.GetStarted.localized(), for: .normal)
            } else {
                nextButton.setTitle(Localization.Onboarding.Next.localized(), for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.navigationItem.hidesBackButton = true
    }
}

// MARK: - Handle UI
extension OnboardingVC {
    private func setupUI() {
        setupNavBar()
        setupButton()
        setupCollectionView()
        setupPageControl()
    }
    
    private func setupNavBar() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        if language.contains("vi") {
            isVnLanguage = true
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: Localization.Language.Vietnamese.localized(),
                style: .done,
                target: self,
                action: #selector(changeLanguageTap))
        } else {
            isVnLanguage = false
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: Localization.Language.English.localized(),
                style: .plain,
                target: self,
                action: #selector(changeLanguageTap))
        }
       
    }
    
    private func setupButton() {
        nextButton.setTitle(Localization.Onboarding.Next.localized(), for: .normal)
        nextButton.layer.cornerRadius = 20
        nextButton.tintColor = AppColor.WhiteColor
        nextButton.backgroundColor = AppColor.GreenColor
        nextButton.addTarget(self, action: #selector(nextBtnTap), for: .touchUpInside)
        
        skipButton.setTitle(Localization.Onboarding.Skip.localized(), for: .normal)
        skipButton.layer.cornerRadius = 20
        skipButton.layer.borderColor = AppColor.GreenColor!.cgColor
        skipButton.layer.borderWidth = 2
        skipButton.tintColor = AppColor.GreenColor
        skipButton.backgroundColor = AppColor.WhiteColor
        skipButton.addTarget(self, action: #selector(skipBtnTap), for: .touchUpInside)
    }
    
    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.registerCellNib(type: OnboardingCollectionViewCell.self)
    }
    
    private func setupPageControl() {
        pageControl.numberOfPages = slides.array.count
    }
}

// MARK: - Handle actions
extension OnboardingVC {
    @objc private func skipBtnTap(_ sender: Any) {
        let tabBarController = BaseTabBarController()
        UIApplication.shared.windows.first?.rootViewController = tabBarController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        UserDefaults.standard.set(EnumConstant.OnboardingStatus.Home.rawValue,
                                  forKey: NameConstant.UserDefaults.HasOnboarding)
    }
    
    @objc private func nextBtnTap(_ sender: Any) {
        if currentPage == slides.array.count - 1 {
            let loginVC = UIStoryboard(name: NameConstant.Storyboard.Authenticate,
                                       bundle: nil).instantiateVC(LoginVC.self)
            self.navigationController?.pushViewController(loginVC, animated: true)
            UserDefaults.standard.set(EnumConstant.OnboardingStatus.LoggedIn.rawValue,
                                      forKey: NameConstant.UserDefaults.HasOnboarding)
        } else {
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
    @objc private func changeLanguageTap() {
        isVnLanguage = !isVnLanguage
        if isVnLanguage == true {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: Localization.Language.Vietnamese.localized(),
                style: .done,
                target: self,
                action: #selector(changeLanguageTap))
            AppPreferences.shared.setLanguage(EnumConstant.Language.vietnamese)
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(
                title: Localization.Language.English.localized(),
                style: .plain,
                target: self,
                action: #selector(changeLanguageTap))
            AppPreferences.shared.setLanguage(EnumConstant.Language.english)
        }
        refresh()
    }
    
    private func refresh() {
        let onboardingVC = UIStoryboard(name: NameConstant.Storyboard.Start, bundle: nil).instantiateVC(OnboardingVC.self)
        let onboardingNavVC = BaseNavigationController(rootViewController: onboardingVC)
        UIApplication.shared.windows.first?.rootViewController = onboardingNavVC
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}

// MARK: - Show UI Collection View
extension OnboardingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCellNib(type: OnboardingCollectionViewCell.self, for: indexPath) else {
            return UICollectionViewCell()
        }
        cell.config(slides.array[indexPath.row])
        return cell
    }
}

// MARK: - Handle Actions Collection View
extension OnboardingVC: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width,
               height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
}

