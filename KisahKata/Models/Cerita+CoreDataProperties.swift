//
//  Cerita+CoreDataProperties.swift
//  KisahKata
//
//  Created by Mulazi Azi on 09/08/21.
//
//

import Foundation
import CoreData


extension Cerita {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cerita> {
        return NSFetchRequest<Cerita>(entityName: "Cerita")
    }

    @NSManaged public var coverImage: String?
    @NSManaged public var id: UUID?
    @NSManaged public var lock: Bool
    @NSManaged public var title: String?
    @NSManaged public var substories: NSSet?
    @NSManaged public var tema: TemaCerita?

}

// MARK: Generated accessors for substories
extension Cerita {

    @objc(addSubstoriesObject:)
    @NSManaged public func addToSubstories(_ value: SubStories)

    @objc(removeSubstoriesObject:)
    @NSManaged public func removeFromSubstories(_ value: SubStories)

    @objc(addSubstories:)
    @NSManaged public func addToSubstories(_ values: NSSet)

    @objc(removeSubstories:)
    @NSManaged public func removeFromSubstories(_ values: NSSet)

}

extension Cerita : Identifiable {

}
