//
//  IntentHandler.m
//  SiriExtension
//
//  Created by 韩元旭 on 2017/5/15.
//  Copyright © 2017年 韩元旭. All rights reserved.
//

#import "IntentHandler.h"
#import "XYHeader.pch"

// As an example, this class is set up to handle Message intents.
// You will want to replace this or add other intents as appropriate.
// The intents you wish to handle must be declared in the extension's Info.plist.

// You can test your example integration by saying things to Siri like:
// "Send a message using <myApp>"
// "<myApp> John saying hello"
// "Search for messages in <myApp>"

@interface IntentHandler () <INSendMessageIntentHandling>
//, INSearchForMessagesIntentHandling, INSetMessageAttributeIntentHandling
@end

@implementation IntentHandler

- (id)handlerForIntent:(INIntent *)intent {
    // This is the default implementation.  If you want different objects to handle different intents,
    // you can override this and return the handler you want for that particular intent.
    
    return self;
}

#pragma mark - INSendMessageIntentHandling

// Implement resolution methods to provide additional information about your intent (optional).
- (void)resolveRecipientsForSendMessage:(INSendMessageIntent *)intent withCompletion:(void (^)(NSArray<INPersonResolutionResult *> *resolutionResults))completion {
    NSArray<INPerson *> *recipients = intent.recipients;
    
    // If no recipients were provided we'll need to prompt for a value.
    if (recipients.count == 0) {
        completion(@[[INPersonResolutionResult needsValue]]);
        return;
    }
    
    NSMutableArray<INPersonResolutionResult *> *resolutionResults = [NSMutableArray array];
    // Implement your contact matching logic here to create an array of matching contacts
    NSMutableArray<INPerson *> *matchingContacts = [NSMutableArray array];
    //  遍历待匹配项
    
    
    for (INPerson *recipient in recipients) {
        
        //  待匹配的名称和拼音
        NSString *recipientName = recipient.displayName;
        NSString *recipientPinYin = [recipientName xy_PinYin];
        
        //  先精确匹配
        for (XYUserInfo *user in [XYUserInfo userList]) {
            
            //  用户名称和拼音
            NSString *name = user.name;
            
            //  包含匹配
            if ([recipientName  isEqualToString:name]) {
                
                //  创建一个匹配成功的用户
                INPersonHandle *handle = [[INPersonHandle alloc] initWithValue:user.address type:INPersonHandleTypeEmailAddress];
                INImage *icon = [INImage imageNamed:user.icon];
                
                INPerson *person = [[INPerson alloc] initWithPersonHandle:handle nameComponents:nil displayName:name image:icon contactIdentifier:nil customIdentifier:nil aliases:nil suggestionType:INPersonSuggestionTypeSocialProfile];
                
                //  记录匹配的用户
                [matchingContacts addObject:person];
            }
            
        }
        
        if (matchingContacts.count == 0) {
            //  如果精确匹配没有的话提供模糊匹配,匹配包含内容或者包含拼音
            for (XYUserInfo *user in [XYUserInfo userList]) {
                
                //  用户名称和拼音
                NSString *name = user.name;
                NSString *pinYin = [name xy_PinYin];
                
                //  包含匹配
                if ([recipientName containsString:name] || [recipientPinYin containsString:pinYin]) {
                    
                    //  创建一个匹配成功的用户
                    INPersonHandle *handle = [[INPersonHandle alloc] initWithValue:user.address type:INPersonHandleTypeEmailAddress];
                    INImage *icon = [INImage imageWithURL:[NSURL URLWithString:user.icon]];
                    
                    INPerson *person = [[INPerson alloc] initWithPersonHandle:handle nameComponents:nil displayName:name image:icon contactIdentifier:nil customIdentifier:nil aliases:nil suggestionType:INPersonSuggestionTypeSocialProfile];
                    
                    //  记录匹配的用户
                    [matchingContacts addObject:person];
                }
                
            }
        }
        
        if (matchingContacts.count > 1) {
            // We need Siri's help to ask user to pick one from the matches.
            [resolutionResults addObject:[INPersonResolutionResult disambiguationWithPeopleToDisambiguate:matchingContacts]];

        } else if (matchingContacts.count == 1) {
            // We have exactly one matching contact
            [resolutionResults addObject:[INPersonResolutionResult successWithResolvedPerson:recipient]];
        } else {
            // We have no contacts matching the description provided
            [resolutionResults addObject:[INPersonResolutionResult needsValue]];
        }
        
    }
    
    completion(resolutionResults);
}

- (void)resolveContentForSendMessage:(INSendMessageIntent *)intent withCompletion:(void (^)(INStringResolutionResult *resolutionResult))completion {
    NSString *text = intent.content;
    if (text && ![text isEqualToString:@""]) {
        completion([INStringResolutionResult successWithResolvedString:text]);
    } else {
        completion([INStringResolutionResult needsValue]);
    }
}

// Once resolution is completed, perform validation on the intent and provide confirmation (optional).

- (void)confirmSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Verify user is authenticated and your app is ready to send a message.
    
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeReady userActivity:userActivity];
    completion(response);
}

// Handle the completed intent (required).

- (void)handleSendMessage:(INSendMessageIntent *)intent completion:(void (^)(INSendMessageIntentResponse *response))completion {
    // Implement your application logic to send a message here.
    
    NSString *email = [intent.recipients lastObject].personHandle.value;
    NSString *content = intent.content;
    
    NSLog(@"发送邮件\"%@\"给%@", content, email)
        
    NSUserActivity *userActivity = [[NSUserActivity alloc] initWithActivityType:NSStringFromClass([INSendMessageIntent class])];
    INSendMessageIntentResponse *response = [[INSendMessageIntentResponse alloc] initWithCode:INSendMessageIntentResponseCodeSuccess userActivity:userActivity];
    completion(response);
}


@end
