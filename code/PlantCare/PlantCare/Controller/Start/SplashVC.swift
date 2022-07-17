import UIKit

class SplashVC: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            
            let onboardingVC = UIStoryboard(name: NameConstant.Storyboard.Start, bundle: nil)
                .instantiateVC(OnboardingVC.self)
            self.navigationController?.pushViewController(onboardingVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        view.backgroundColor = AppColor.GreenColor
        animate()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func animate() {
        UIView.animate(withDuration: 0, delay: 0, options: [], animations: {
            self.titleLabel.alpha = 0
        }, completion: { _ in
            UIView.animate(withDuration: 5, delay: 0.5, options: [], animations: {
                self.titleLabel.alpha = 1
            }, completion: nil)
        })
    }
}
