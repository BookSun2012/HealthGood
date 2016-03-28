//
//  Like+CoreDataProperties.h
//  
//
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Like.h"

NS_ASSUME_NONNULL_BEGIN

@interface Like (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *type;
@property (nullable, nonatomic, retain) NSString *bookCount;

@end

NS_ASSUME_NONNULL_END
