//
//  Kosakata+CoreDataProperties.swift
//  KisahKata
//
//  Created by Mulazi Azi on 11/08/21.
//
//

import Foundation
import CoreData


extension Kosakata {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Kosakata> {
        return NSFetchRequest<Kosakata>(entityName: "Kosakata")
    }

    @NSManaged public var deskripsi: String?
    @NSManaged public var kata: String?
    @NSManaged public var sudahDipelajari: Int16
    @NSManaged public var urlVideo: String?

}

extension Kosakata : Identifiable {

}
