//
//  StoryIlustration+CoreDataProperties.swift
//  KisahKata
//
//  Created by Mulazi Azi on 07/08/21.
//
//

import Foundation
import CoreData


extension StoryIlustration {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<StoryIlustration> {
        return NSFetchRequest<StoryIlustration>(entityName: "StoryIlustration")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var storyIlustration: Data?
    @NSManaged public var substories: SubStories?

}

extension StoryIlustration : Identifiable {

}
