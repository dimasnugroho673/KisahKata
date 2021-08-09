//
//  SubStories+CoreDataProperties.swift
//  KisahKata
//
//  Created by Mulazi Azi on 07/08/21.
//
//

import Foundation
import CoreData


extension SubStories {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SubStories> {
        return NSFetchRequest<SubStories>(entityName: "SubStories")
    }

    @NSManaged public var cerita: String?
    @NSManaged public var id: UUID?
    @NSManaged public var ilustration: StoryIlustration?
    @NSManaged public var kosakata: NSSet?
    @NSManaged public var stories: Cerita?

}

// MARK: Generated accessors for kosakata
extension SubStories {

    @objc(addKosakataObject:)
    @NSManaged public func addToKosakata(_ value: Highlghtword)

    @objc(removeKosakataObject:)
    @NSManaged public func removeFromKosakata(_ value: Highlghtword)

    @objc(addKosakata:)
    @NSManaged public func addToKosakata(_ values: NSSet)

    @objc(removeKosakata:)
    @NSManaged public func removeFromKosakata(_ values: NSSet)

}

extension SubStories : Identifiable {

}
