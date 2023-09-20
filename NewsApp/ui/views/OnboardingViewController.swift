//
//  OnBoardingViewController.swift
//  NewsApp
//
//  Created by Asya Atpulat on 5.09.2023.
//

import UIKit

class OnboardingViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var slides: [OnboardingSlide] = []
    var currentPage = 0 {
        didSet{
            pageControl.currentPage = currentPage
            if currentPage == slides.count - 1 {
                nextButton.setTitle("Get Started", for: .normal)
                UserDefaults.standard.set(true, forKey: "openedapp")
            }
            else {
                nextButton.setTitle("Next", for: .normal)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        slides = [OnboardingSlide(title: "Discover Breaking News", description: "Stay updated with the latest headlines, breaking news, and trending stories from around the world.", image: UIImage(named: "media")!),
                  OnboardingSlide(title: "Tailor Your News Feed", description: "Customize your news feed by choosing your favorite categories and interests. Get news that matters to you.", image:  UIImage(named: "media")!),
                  OnboardingSlide(title:"Take Control of Your Experience", description: "Access your profile, settings, and preferences all in one place. Manage your news sources, notifications, and more.", image:  UIImage(named: "media")!)
                  
        ]
    }
    

    @IBAction func nextButtonClicked(_ sender: Any) {
        if currentPage == slides.count - 1 {
            let authStoryboard = UIStoryboard(name: "Auth", bundle: nil)
                  
                  // Auth.storyboard'dan UINavigationController'ı alın
                  if let authNavigationController = authStoryboard.instantiateInitialViewController() as? UINavigationController {
                      
                      // UINavigationController'ı tam ekran olarak görüntüleyin
                      authNavigationController.modalPresentationStyle = .fullScreen
                      
                      // Onboarding ekranından auth ekranına geçiş yapın
                      self.present(authNavigationController, animated: true, completion: nil)
                  }
              

               
            
        }else{
            collectionView.isPagingEnabled = false
            currentPage += 1
            let indexPath = IndexPath(item: currentPage, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            collectionView.isPagingEnabled = true
        }
    }

}

extension OnboardingViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as! OnboardingCollectionViewCell
        cell.setup(slides[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) ->
    CGSize{
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
}
