//
//  TemaCerita+CoreDataProperties.swift
//  KisahKata
//
//  Created by Mulazi Azi on 08/08/21.
//
//

import Foundation
import CoreData


extension TemaCerita {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TemaCerita> {
        return NSFetchRequest<TemaCerita>(entityName: "TemaCerita")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var lock: Bool
    @NSManaged public var temaImage: String?
    @NSManaged public var title: String?
    @NSManaged public var stories: NSSet?

}

// MARK: Generated accessors for stories
extension TemaCerita {

    @objc(addStoriesObject:)
    @NSManaged public func addToStories(_ value: Cerita)

    @objc(removeStoriesObject:)
    @NSManaged public func removeFromStories(_ value: Cerita)

    @objc(addStories:)
    @NSManaged public func addToStories(_ values: NSSet)

    @objc(removeStories:)
    @NSManaged public func removeFromStories(_ values: NSSet)

}

extension TemaCerita : Identifiable {

}
