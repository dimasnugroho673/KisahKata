//
//  ViewController.swift
//  KisahKata
//
//  Created by Dimas Putro on 29/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var userLabel: UILabel!
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    
    fileprivate var currentPage: Int = 0 {
            didSet {
                print("page at centre = \(currentPage)")
            }
        }
        
        fileprivate var pageSize: CGSize {
            let layout = self.homeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
            var pageSize = layout.itemSize
            if layout.scrollDirection == .horizontal {
                pageSize.width += layout.minimumLineSpacing
            } else {
                pageSize.height += layout.minimumLineSpacing
            }
            return pageSize
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "homeCollectionViewCell", bundle: nil)
        self.homeCollectionView.register(cellNib, forCellWithReuseIdentifier: "temaCell")
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 245)
        flowLayout.scrollDirection = .vertical
        flowLayout.spacingMode = .fixed(spacing: 20)
        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        homeCollectionView.collectionViewLayout = flowLayout
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataTema.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "temaCell", for: indexPath)as! homeCollectionViewCell
        let tema = dataTema[indexPath.row]
        cell.temaImage.image = tema.picture
        cell.temaLabel.text = tema.nama
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Cell \(indexPath.row) ditekan")
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.homeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .vertical) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .vertical) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    
    }
    
    
}
