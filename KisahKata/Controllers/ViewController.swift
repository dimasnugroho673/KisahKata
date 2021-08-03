//
//  ViewController.swift
//  KisahKata
//
//  Created by Dimas Putro on 29/07/21.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var bgBlurJudul: UIVisualEffectView!
    @IBOutlet weak var temaLabel: UILabel!
    @IBOutlet weak var judulCollectionView: UICollectionView!
    
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet var BlurView: UIVisualEffectView!
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    let userDefault = UserDefaults()
    
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
    
    private let nextFloatingButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 30
        button.backgroundColor = UIColor.init(named: "buttonColorBlue")
        
        
        let image = UIImage(systemName: "arrow.right.circle.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 32, weight: .medium))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _checkUserIsLogged()
        // Do any additional setup after loading the view.
        let cellNib = UINib(nibName: "homeCollectionViewCell", bundle: nil)
        self.homeCollectionView.register(cellNib, forCellWithReuseIdentifier: "temaCell")
        let cellNibJudul = UINib(nibName: "JudulCollectionViewCell", bundle: nil)
        self.judulCollectionView.register(cellNibJudul, forCellWithReuseIdentifier: "judulCell")
        
        //Pengaturan flowlayout CollectionView di halaman utama
        let flowLayout = UPCarouselFlowLayout()
        flowLayout.itemSize = CGSize(width: 200, height: 245)
        flowLayout.scrollDirection = .vertical
        flowLayout.sideItemShift = 0.3
        flowLayout.sideItemAlpha = 0.3
        flowLayout.spacingMode = .fixed(spacing: 20)
        //flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        homeCollectionView.collectionViewLayout = flowLayout
        
        //Pengaturan flowlayout Judul CollectionView di BlurView
        let flowLayoutJudul = UPCarouselFlowLayout()
        flowLayoutJudul.itemSize = CGSize(width: 300, height: 67)
        flowLayoutJudul.scrollDirection = .vertical
        flowLayoutJudul.sideItemShift = 0.3
        flowLayoutJudul.sideItemAlpha = 0.3
        flowLayoutJudul.spacingMode = .fixed(spacing: 10)
        flowLayoutJudul.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        judulCollectionView.collectionViewLayout = flowLayoutJudul
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        BlurView.bounds = self.view.bounds
        
        
        
//        view.addSubview(nextFloatingButton)
//        nextFloatingButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        
    }
    private func _animateIn(desiredView: UIView) {
        let backgroundView = self.view!
        
        // attach our desired view to the screen
        backgroundView.addSubview(desiredView)
        
        // set view to scalling to be 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
           
        })
    }
    
    private func _animateOut(desiredView: UIView) {
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: {_ in
            desiredView.removeFromSuperview()
        })
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeCollectionView {
            return dataTema.count
        }else {
            return dataJudul.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == homeCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "temaCell", for: indexPath)as! homeCollectionViewCell
            let tema = dataTema[indexPath.row]
            cell.temaImage.image = tema.picture
            cell.temaLabel.text = tema.nama
            
            if indexPath.row < 1 {
                //cell.lockImage.image = UIImage(named: "img_star2")
                print("Item Terbuka")
            } else {
                cell.lockImage.image = UIImage(named: "ic_lock")
            }
            
            return cell
        }else {
            let cellJudul = collectionView.dequeueReusableCell(withReuseIdentifier: "judulCell", for: indexPath)as! JudulCollectionViewCell
            let judul = dataJudul[indexPath.row]
            cellJudul.judulLabel.text = judul.nama
            
            if indexPath.row < 1 {
                cellJudul.scoreImage.image = UIImage(named: "img_star-0")
            }else {
                cellJudul.scoreImage.image = UIImage(named: "ic_lock")
            }
            
            return cellJudul
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == homeCollectionView && indexPath.row < 1 {
            _animateIn(desiredView: bgBlurJudul)
            
            print("Cell \(indexPath.row) ditekan")
        } else {
            var dialogMessage = UIAlertController(title: "Cerita masih terkunci", message: "Cerita masih terkunci, kamu harus menyelesaikan tema sebelumnya untuk membuka cerita ini", preferredStyle: .alert)
            
            let ok = UIAlertAction(title: "OK", style: .default, handler: {(action) -> Void in
            })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
        
        
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let layout = self.homeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
        let pageSide = (layout.scrollDirection == .vertical) ? self.pageSize.width : self.pageSize.height
        let offset = (layout.scrollDirection == .vertical) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
    
    }
    
    
    private func _animateIn(desiredView: UIView) {
        let backgroundView = self.view!
        
        // attach our desired view to the screen
        backgroundView.addSubview(desiredView)
        
        // set view to scalling to be 120%
        desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        desiredView.alpha = 0
        desiredView.center = backgroundView.center
        
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            desiredView.alpha = 1
           
        })
    }
    
    private func _animateOut(desiredView: UIView) {
        // animate the effect
        UIView.animate(withDuration: 0.3, animations: {
            desiredView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            desiredView.alpha = 0
        }, completion: {_ in
            desiredView.removeFromSuperview()
        })
    }
    
    
    private func _checkUserIsLogged() {
        let username: String = UserDefaults.standard.string(forKey: "username") ?? ""
        
        if username == "" {
            self.performSegue(withIdentifier: "loginScreen", sender: nil)
//            let controller = TesViewController()
//            controller.modalPresentationStyle = .fullScreen
//            controller.modalTransitionStyle = .coverVertical
//            self.present(controller, animated: true, completion: nil)
        }
    }
    
}
