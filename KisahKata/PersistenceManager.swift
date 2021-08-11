//
//  PersistenceManager.swift
//  KisahKata
//
//  Created by Mulazi Azi on 06/08/21.
//

import Foundation
import CoreData

class PersistenceManager  {
    
    private init(){}
    static let shared = PersistenceManager()
    
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "KisahKata")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func setTemaCerita(lock: Bool, title: String, temaImage: String) {
        let temaCerita = TemaCerita(context: persistentContainer.viewContext)
        temaCerita.lock = lock
        temaCerita.title = title
        temaCerita.temaImage = temaImage
        save()
        
    }
    
    func setCerita(coverImage : String, lock : Bool, title : String) {
        let cerita = KisahKata.Cerita(context: persistentContainer.viewContext)
        cerita.coverImage = coverImage
        cerita.lock = lock
        cerita.title = title
        save()
    }
    
    func fetchTemaCerita() -> [TemaCerita] {
        let request : NSFetchRequest<TemaCerita> = TemaCerita.fetchRequest()
        
        var temaCerita : [TemaCerita] = []
        
        do {
            temaCerita = try persistentContainer.viewContext.fetch(request)
        } catch {
            print("Error fetching tema")
        }
        
        return temaCerita
    }
    
    func fetchCerita(tema: TemaCerita) -> [Cerita] {
        let request: NSFetchRequest<Cerita> =  Cerita.fetchRequest()
        
        request.predicate = NSPredicate(format: "(tema = %@)", tema)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        var ceritas : [Cerita] = []
        
        do{
            ceritas = try persistentContainer.viewContext.fetch(request)
        }catch {
            print("Error fetching stories data")
        }
        return ceritas
    }
    
    
    func save () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                print("saved succesfully")
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}
