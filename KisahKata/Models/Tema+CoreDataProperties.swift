//
//  Tema+CoreDataProperties.swift
//  KisahKata
//
//  Created by Mulazi Azi on 06/08/21.
//
//

import Foundation
import CoreData


extension Tema {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tema> {
        return NSFetchRequest<Tema>(entityName: "Tema")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var lock: Bool
    @NSManaged public var temaImage: Data?
    @NSManaged public var title: String?
    @NSManaged public var stories: NSSet?

}

// MARK: Generated accessors for stories
extension Tema {

    @objc(addStoriesObject:)
    @NSManaged public func addToStories(_ value: Stories)

    @objc(removeStoriesObject:)
    @NSManaged public func removeFromStories(_ value: Stories)

    @objc(addStories:)
    @NSManaged public func addToStories(_ values: NSSet)

    @objc(removeStories:)
    @NSManaged public func removeFromStories(_ values: NSSet)

}

extension Tema : Identifiable {

}
