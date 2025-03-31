//
//  AppDelegate.h
//  HyphenateChatQuickstart
//
//  Created by stwang on 2025/3/31.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

