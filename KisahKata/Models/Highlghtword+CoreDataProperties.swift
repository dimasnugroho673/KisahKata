//
//  Highlghtword+CoreDataProperties.swift
//  KisahKata
//
//  Created by Mulazi Azi on 07/08/21.
//
//

import Foundation
import CoreData


extension Highlghtword {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Highlghtword> {
        return NSFetchRequest<Highlghtword>(entityName: "Highlghtword")
    }

    @NSManaged public var deskripsi: String?
    @NSManaged public var deskripsiVideo: String?
    @NSManaged public var id: UUID?
    @NSManaged public var kata: String?
    @NSManaged public var sudahDipelajari: Bool
    @NSManaged public var urlVideo: String?
    @NSManaged public var substories: SubStories?

}

extension Highlghtword : Identifiable {

}
