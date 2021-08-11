//
//  ViewController.swift
//  KisahKata
//
//  Created by Dimas Putro on 29/07/21.
//

import UIKit
import CoreData

class ViewController: UIViewController, SaveUserDataDelegate {

    @IBOutlet var bgBlurJudul: UIVisualEffectView!
    @IBOutlet weak var temaLabel: UILabel!
    @IBOutlet weak var judulCollectionView: UICollectionView!
    
    @IBOutlet weak var haloLabel: UILabel!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet var BlurView: UIVisualEffectView!
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    let userDefault = UserDefaults()
    fileprivate var items = dataJudul
    fileprivate var tema = dataTema
    
//    private var temaCerita : [TemaCerita] = []
//    private var ceritas: [Cerita] = []
//    var tema : TemaCerita?
    
//    var tema: TemaCerita?
    var kosakatas = [Kosakata]()
    
    var manageObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    fileprivate var currentPage: Int = 0 {
        didSet {
            let preview = self.items[self.currentPage]
            self.previewImage.image = preview.preview
            print("page at centre = \(currentPage)")
        }
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
        
        // CoreData config
        manageObjectContext = appDelegate?.persistentContainer.viewContext as! NSManagedObjectContext
        
        _checkData()
        _checkUserIsLogged()
        
        let namaTema = self.items[self.currentPage]
        self.temaLabel.text = namaTema.nama
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
        
        haloLabel.font = UIFont(name: "Ubuntu-Bold", size: 30)
        userLabel.font = UIFont(name: "Ubuntu-Bold", size: 36)
        userLabel.text = UserDefaults.standard.string(forKey: "username") ?? ""
        
        let config = UIImage.SymbolConfiguration(
            pointSize: 25, weight: .medium, scale: .default)
        let image = UIImage(systemName: "xmark.circle.fill", withConfiguration: config)
        backButton.setImage(image, for: .normal)
        backButton.tintColor = .white
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        judulCollectionView.delegate = self
        judulCollectionView.dataSource = self
        
    }
    
    // CoreData Config
    private func _addData() {
        let entity = NSEntityDescription.entity(forEntityName: "Kosakata", in: self.manageObjectContext)
        let newKosakata = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata2 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata3 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata4 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata5 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata6 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata7 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        let newKosakata8 = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
        
        newKosakata.setValue("Selamat pagi", forKey: "kata")
        newKosakata.setValue("sibi_selamatpagi.mp4", forKey: "urlVideo")
        newKosakata.setValue("Mudah-mudahan selamat pada pagi hari (ini)", forKey: "deskripsi")
        newKosakata.setValue(0, forKey: "sudahDipelajari")
        
        newKosakata2.setValue("memperkenalkan", forKey: "kata")
        newKosakata2.setValue("sibi_memperkenalkan.mp4", forKey: "urlVideo")
        newKosakata2.setValue("Memberitahukan (nama dan sebagainya) supaya saling ", forKey: "deskripsi")
        newKosakata2.setValue(0, forKey: "sudahDipelajari")
        
        newKosakata3.setValue("panggil", forKey: "kata")
        newKosakata3.setValue("sibi_panggil.mp4", forKey: "urlVideo")
        newKosakata3.setValue("Mengajak (meminta) datang (kembali, mendekat, dan sebagainya)", forKey: "deskripsi")
        newKosakata3.setValue(0, forKey: "sudahDipelajari")
        
        newKosakata4.setValue("bersaudara", forKey: "kata")
        newKosakata4.setValue("sibi_bersaudara.mp4", forKey: "urlVideo")
        newKosakata4.setValue("Mempunyai saudara", forKey: "deskripsi")
        newKosakata4.setValue(0, forKey: "sudahDipelajari")
        
        newKosakata5.setValue("olahraga", forKey: "kata")
        newKosakata5.setValue("sibi_olahraga.mp4", forKey: "urlVideo")
        newKosakata5.setValue("Gerak badan untuk menguatkan dan menyehatkan tubuh (seperti sepak bola, berenang, lempar lembing)", forKey: "deskripsi")
        newKosakata5.setValue(0, forKey: "sudahDipelajari")
        
        newKosakata6.setValue("bermain", forKey: "kata")
        newKosakata6.setValue("sibi_bermain.mp4", forKey: "urlVideo")
        newKosakata6.setValue("Melakukan sesuatu untuk bersenang-senang", forKey: "deskripsi")
        newKosakata6.setValue(0, forKey: "sudahDipelajari")
        
        newKosakata7.setValue("cita-cita", forKey: "kata")
        newKosakata7.setValue("sibi_cita-cita.mp4", forKey: "urlVideo")
        newKosakata7.setValue("Keinginan (kehendak) yang selalu ada di dalam pikiran | tujuan yang sempurna (yang akan dicapai atau dilaksanakan)", forKey: "deskripsi")
        newKosakata7.setValue(0, forKey: "sudahDipelajari")
        
        newKosakata8.setValue("membanggakan", forKey: "kata")
        newKosakata8.setValue("sibi_membanggakan.mp4", forKey: "urlVideo")
        newKosakata8.setValue("Menimbulkan perasaan bangga", forKey: "deskripsi")
        newKosakata8.setValue(0, forKey: "sudahDipelajari")
        
        do {
            try manageObjectContext.save()
            print("data has been dump!")
        }catch let error as NSError{
            print("Gagal save, \(error)")
        }
    }
    
    @IBAction func closeButtonBlurView(_ sender: Any) {
        _animateOut(desiredView: bgBlurJudul)
    }
    
    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: judulCollectionView.contentOffset, size: judulCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = judulCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        
        return getCurrentPage()
    }
    
    func didSaveUserData(username: String) {
        userLabel.text = username
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let introVC = segue.destination as? IntroViewController {
            /// call delegate in IntroViewController ad assign with this class
            introVC.delegate = self
        }
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == homeCollectionView {
            return dataTema.count
            print(dataTema)
            
        }else {
//            load()
            return dataJudul.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (collectionView == homeCollectionView){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "temaCell", for: indexPath)as! homeCollectionViewCell
            let tema = dataTema[indexPath.row]
            cell.temaImage.image = tema.picture
            cell.temaLabel.text = tema.nama
//            cell.setDataIntoCell(tema: tema)
            
            if indexPath.row < 1 {
                cell.lockImage.image = UIImage(named: "")
                print("Item Terbuka")
            } else {
                cell.lockImage.image = UIImage(named: "ic_lock")
            }
            return cell
        }else
        {
            let cellJudul = collectionView.dequeueReusableCell(withReuseIdentifier: "judulCell", for: indexPath)as! JudulCollectionViewCell
            let judul = dataJudul[indexPath.row]
            cellJudul.judulLabel.text = judul.nama

//            cellJudul.setDataIntoCell(ceritas: judul)
            
            if indexPath.row < 1 {
                cellJudul.scoreImage.image = UIImage(named: "img_star-0")
            }else {
                
                cellJudul.scoreImage.image = UIImage(named: "ic_lock")
            }
            
            return cellJudul
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let tema = temaCerita[indexPath.row]
//        temaLabel.text = tema.title
        if collectionView == homeCollectionView && indexPath.row < 1 {
            _animateIn(desiredView: bgBlurJudul)
            
            print("Cell \(indexPath.row) ditekan")
        } else if collectionView == judulCollectionView && indexPath.row < 1{
            
            performSegue(withIdentifier: "goToStoryOverview", sender: nil)
            
            print("Cell judul \(indexPath.row) ditekan")
        } else{
            let alert = AlertLockItemService()
            let alertVC = alert.alert(title: "Cerita terkunci", message: "Cerita masih terkunci, selesaikan cerita sebelumnya untuk membuka cerita baru")
            present(alertVC, animated: true)
        }
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let layoutA = self.judulCollectionView.collectionViewLayout as! UPCarouselFlowLayout
//        _ = (layoutA.scrollDirection == .vertical) ? self.pageSize.width : self.pageSize.height
//        _ = (layoutA.scrollDirection == .vertical) ? scrollView.contentOffset.x : scrollView.contentOffset.y
//        let layout = self.homeCollectionView.collectionViewLayout as! UPCarouselFlowLayout
//        let pageSide = (layout.scrollDirection == .vertical) ? self.pageSize.width : self.pageSize.height
//        let offset = (layout.scrollDirection == .vertical) ? scrollView.contentOffset.x : scrollView.contentOffset.y
//        currentPage = Int(floor((offset - pageSide / 2) / pageSide) + 1)
        currentPage = getCurrentPage()
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
          /// segue ke IntroViewController
            performSegue(withIdentifier: "goToIntro", sender: nil)
        }
    }
    
//    private func _addData () {
//
//        _temaData()
//        _storiesData()
//
//    }
    
    private func _temaData() {
        
        
//        let entity = NSEntityDescription.entity(forEntityName: "TemaCerita", in: self.manageObjectContext)
//        let newKosakata = NSManagedObject(entity: entity!, insertInto: self.manageObjectContext)
//
//
//
//        newKosakata.setValue("Selamat pagi", forKey: "title")
//        newKosakata.setValue(true, forKey: "lock")
//
//        PersistenceManager.shared.save()
        
        let title1 = "Perkenalan"
        let lock1 = true
        let temaImage1 = ""
        
        let title2 = "Pertemanan"
        let lock2 = false
        let temaImage2 = ""
        
        let title3 = "Keluarga"
        let lock3 = false
        let temaImage3 = ""
        
        PersistenceManager.shared.setTemaCerita(lock: lock1, title: title1, temaImage: temaImage1)
        PersistenceManager.shared.setTemaCerita(lock: lock2, title: title2, temaImage: temaImage2)
        PersistenceManager.shared.setTemaCerita(lock: lock3, title: title3, temaImage: temaImage3)
    
        
        
    }
    
    private func _storiesData() {
        
        let title = "Selamat Pagi"
        let coverImage = ""
        let lock = true
        
        PersistenceManager.shared.setCerita(coverImage: coverImage, lock: lock, title: title)
        
        
    }
    
    
    private func _checkData() {
        let dataExist: Bool = UserDefaults.standard.bool(forKey: "dataExist")

        if dataExist != true {
            self._addData()

            UserDefaults.standard.setValue(true, forKey: "dataExist")
            print("data has been dump!")
        } else {
            print("data exist!")
        }
    }
    
//    private func _loadData() {
//
////        guard let tema = tema else {
////            print("error author")
////            return
////        }
//        temaCerita = PersistenceManager.shared.fetchTemaCerita()
////        ceritas = PersistenceManager.shared.fetchCerita(tema: tema)
//        homeCollectionView.reloadData()
//
//        print(temaCerita)
//    }
//
//    private func load(){
//
//        guard let tema  = tema else {
//            print("error cerita data")
//            return
//        }
//
//        ceritas = PersistenceManager.shared.fetchCerita(tema: tema)
//        judulCollectionView.reloadData()
////
//    }


//extension ViewController : LoginSelectionDelegate {
//    func didTapChoice(name: String) {
//        userLabel.text = name
//    }


}
