//
//  Stories+CoreDataProperties.swift
//  KisahKata
//
//  Created by Mulazi Azi on 06/08/21.
//
//

import Foundation
import CoreData


extension Stories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Stories> {
        return NSFetchRequest<Stories>(entityName: "Stories")
    }

    @NSManaged public var coverImage: Data?
    @NSManaged public var id: UUID?
    @NSManaged public var lock: Bool
    @NSManaged public var title: String?
    @NSManaged public var substories: NSSet?
    @NSManaged public var tema: Tema?

}

// MARK: Generated accessors for substories
extension Stories {

    @objc(addSubstoriesObject:)
    @NSManaged public func addToSubstories(_ value: SubStories)

    @objc(removeSubstoriesObject:)
    @NSManaged public func removeFromSubstories(_ value: SubStories)

    @objc(addSubstories:)
    @NSManaged public func addToSubstories(_ values: NSSet)

    @objc(removeSubstories:)
    @NSManaged public func removeFromSubstories(_ values: NSSet)

}

extension Stories : Identifiable {

}
