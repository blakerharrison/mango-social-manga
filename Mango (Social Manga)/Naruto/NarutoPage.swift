//
//  NarutoPage.swift
//  Mango (Social Manga)
//
//  Created by Blake Harrison on 4/8/18.
//  Copyright © 2018 Blake Harrison. All rights reserved.
//

import UIKit

class NarutoPage: UIPageViewController, UIPageViewControllerDataSource {
    
    var pref: UserDefaults = UserDefaults.standard
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

         lazy var viewControllerList: [UIViewController] = {
    
            let sb = UIStoryboard(name: "Main", bundle: nil)
            
            let vc1 = sb.instantiateViewController(withIdentifier: "Page1")
            let vc2 = sb.instantiateViewController(withIdentifier: "Page2")
            let vc3 = sb.instantiateViewController(withIdentifier: "Page3")
            let vc4 = sb.instantiateViewController(withIdentifier: "Page4")
            let vc5 = sb.instantiateViewController(withIdentifier: "Page5")
            let vc6 = sb.instantiateViewController(withIdentifier: "Page6")
            let vc7 = sb.instantiateViewController(withIdentifier: "Page7")
            let vc8 = sb.instantiateViewController(withIdentifier: "Page8")
            let vc9 = sb.instantiateViewController(withIdentifier: "Page9")
            let vc10 = sb.instantiateViewController(withIdentifier: "Page10")
            let vc11 = sb.instantiateViewController(withIdentifier: "Page11")
            let vc12 = sb.instantiateViewController(withIdentifier: "Page12")
            let vc13 = sb.instantiateViewController(withIdentifier: "Page13")
            let vc14 = sb.instantiateViewController(withIdentifier: "Page14")
            let vc15 = sb.instantiateViewController(withIdentifier: "Page15")
            let vc16 = sb.instantiateViewController(withIdentifier: "Page16")
            let vc17 = sb.instantiateViewController(withIdentifier: "Page17")
            let vc18 = sb.instantiateViewController(withIdentifier: "Page18")
            let vc19 = sb.instantiateViewController(withIdentifier: "Page19")
            let vc20 = sb.instantiateViewController(withIdentifier: "Page20")
            let vc21 = sb.instantiateViewController(withIdentifier: "Page21")
            let vc22 = sb.instantiateViewController(withIdentifier: "Page22")
            let vc23 = sb.instantiateViewController(withIdentifier: "Page23")
            let vc24 = sb.instantiateViewController(withIdentifier: "Page24")
            let vc25 = sb.instantiateViewController(withIdentifier: "Page25")
            let vc26 = sb.instantiateViewController(withIdentifier: "Page26")
            let vc27 = sb.instantiateViewController(withIdentifier: "Page27")
            let vc28 = sb.instantiateViewController(withIdentifier: "Page28")
            let vc29 = sb.instantiateViewController(withIdentifier: "Page29")
            let vc30 = sb.instantiateViewController(withIdentifier: "Page30")
            let vc31 = sb.instantiateViewController(withIdentifier: "Page31")
            let vc32 = sb.instantiateViewController(withIdentifier: "Page32")
            let vc33 = sb.instantiateViewController(withIdentifier: "Page33")
            let vc34 = sb.instantiateViewController(withIdentifier: "Page34")
            let vc35 = sb.instantiateViewController(withIdentifier: "Page35")
            let vc36 = sb.instantiateViewController(withIdentifier: "Page36")
            let vc37 = sb.instantiateViewController(withIdentifier: "Page37")
            let vc38 = sb.instantiateViewController(withIdentifier: "Page38")
            let vc39 = sb.instantiateViewController(withIdentifier: "Page39")
            let vc40 = sb.instantiateViewController(withIdentifier: "Page40")
            let vc41 = sb.instantiateViewController(withIdentifier: "Page41")
            let vc42 = sb.instantiateViewController(withIdentifier: "Page42")
            let vc43 = sb.instantiateViewController(withIdentifier: "Page43")
            let vc44 = sb.instantiateViewController(withIdentifier: "Page44")
            let vc45 = sb.instantiateViewController(withIdentifier: "Page45")
            let vc46 = sb.instantiateViewController(withIdentifier: "Page46")
            let vc47 = sb.instantiateViewController(withIdentifier: "Page47")
            let vc48 = sb.instantiateViewController(withIdentifier: "Page48")
            let vc49 = sb.instantiateViewController(withIdentifier: "Page49")
            let vc50 = sb.instantiateViewController(withIdentifier: "Page50")
            let vc51 = sb.instantiateViewController(withIdentifier: "Page51")
            let vc52 = sb.instantiateViewController(withIdentifier: "Page52")
            let vc53 = sb.instantiateViewController(withIdentifier: "Page53")
            let vc54 = sb.instantiateViewController(withIdentifier: "Page54")
            let vc55 = sb.instantiateViewController(withIdentifier: "Page55")
            let vc56 = sb.instantiateViewController(withIdentifier: "Page56")
            let vc57 = sb.instantiateViewController(withIdentifier: "Page57")
            let vc58 = sb.instantiateViewController(withIdentifier: "Page58")
            let vc59 = sb.instantiateViewController(withIdentifier: "Page59")
            let vc60 = sb.instantiateViewController(withIdentifier: "Page60")
    
            return [vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8, vc9, vc10, vc11, vc12, vc13, vc14, vc15, vc16, vc17, vc18, vc19, vc20, vc21, vc22, vc23, vc24, vc25, vc26, vc27, vc28, vc29, vc30, vc31, vc32, vc33, vc34, vc35, vc36, vc37, vc38, vc39, vc40, vc41, vc42, vc43, vc44, vc45, vc46, vc47, vc48, vc49, vc50, vc51, vc52, vc53, vc54, vc55, vc56, vc57, vc58, vc59, vc60]
        }()

    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let firstViewController = viewControllerList.first {
            self.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
            
            self.navigationController?.navigationBar.isHidden = false;
            
            // Makes a translucent navigation bar.
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.isTranslucent = true
            
            self.dataSource = self
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //Book Number of View Controller Algorithms
        let Chapter = pref.integer(forKey: "Naruto")
        let totalPages = 60 - pagesContainedInChapter(manga: "Naruto", chapter: Chapter)
        print(totalPages)
        
        guard totalPages == 0 else {
            for _ in 1...totalPages {
                viewControllerList.removeLast()
            }
            return
        }
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex = viewControllerList.index(of: viewController) else {return nil}
        
        let previousIndex = vcIndex - 1
        
        guard previousIndex >= 0 else {return nil}
        
        guard viewControllerList.count > previousIndex else {return nil}
        
        return viewControllerList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let vcIndex =  viewControllerList.index(of: viewController) else {return nil}
        
        let nextIndex = vcIndex + 1
        
        guard viewControllerList.count != nextIndex else {return nil}
        
        guard viewControllerList.count > nextIndex else {return nil}
        
        return viewControllerList[nextIndex]
    }
}

