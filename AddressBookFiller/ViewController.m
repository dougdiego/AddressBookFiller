//
//  ViewController.m
//  AddressBookFiller
//
//  Created by Doug Diego on 9/16/13.
//  Copyright (c) 2013 Doug Diego. All rights reserved.
//
// The MIT License (MIT)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy of
// this software and associated documentation files (the "Software"), to deal in
// the Software without restriction, including without limitation the rights to
// use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
// the Software, and to permit persons to whom the Software is furnished to do so,
// subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "ViewController.h"
#import <AddressBook/AddressBook.h>

@interface ViewController ()
- (IBAction) presidentsButtonPressed:(id)sender ;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) presidentsButtonPressed:(id)sender {
	NSLog(@"presidentsButtonPressed");
	[self populateAddressBookWithPresidents];
	
	
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Done"
                                                    message:@"Address book populated!"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
	[alert show];
	
}

-(BOOL) addressBookAccessGrant {
    ABAddressBookRef ab = NULL;
    // ABAddressBookCreateWithOptions is iOS 6 and up.
    if (&ABAddressBookCreateWithOptions) {
        CFErrorRef error = nil;
        ab = ABAddressBookCreateWithOptions(NULL, &error);
        if (error) { NSLog(@"%@", error); }
    }
    // iOS 5
    // if (ab == NULL) {
    //    ab = ABAddressBookCreate();
    // }
    
    __block BOOL accessGranted = NO;
    
    if (ABAddressBookRequestAccessWithCompletion != NULL) { // we're on iOS 6
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        ABAddressBookRequestAccessWithCompletion(ab, ^(bool granted, CFErrorRef error) {
            accessGranted = granted;
            dispatch_semaphore_signal(sema);
        });
        
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else { // we're on iOS 5 or older
        accessGranted = YES;
    }
    
    if (!accessGranted) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"You must grant access to the address book to proceed."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
    
    return accessGranted;
}


- (void) populateAddressBookWithPresidents {
	NSLog(@"PopulateAddressBook.populateAddressBookWithPresidents");
    
    if(![self addressBookAccessGrant]){
        return;
    }
	
    // Create Date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    dateFormatter.dateFormat = @"yy-MMM-dd";
    
    NSDate *date1 = [dateFormatter dateFromString:@"1732-02-22"];
	[self addPersonWithFirstName:@"George" lastName:@"Washington" phone:@"212-212-2112" birthDate:date1
						   image:@"http://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Gilbert_Stuart_Williamstown_Portrait_of_George_Washington.jpg/225px-Gilbert_Stuart_Williamstown_Portrait_of_George_Washington.jpg"];
	
	
	NSDate *date2 = [dateFormatter dateFromString:@"1732-10-30 00:00:00 -0800"];
	[self addPersonWithFirstName:@"John" lastName:@"Adams" phone:@"222-222-2222" birthDate:date2
						   image:@"http://upload.wikimedia.org/wikipedia/commons/9/9e/Johnadamsvp.flipped.jpg"];
	
	NSDate *date3 = [dateFormatter dateFromString:@"1743-04-13"];
	[self addPersonWithFirstName:@"Thomas" lastName:@"Jefferson" phone:@"333-333-3333" birthDate:date3
						   image:@"http://upload.wikimedia.org/wikipedia/commons/thumb/4/46/T_Jefferson_by_Charles_Willson_Peale_1791_2.jpg/225px-T_Jefferson_by_Charles_Willson_Peale_1791_2.jpg"];
	
	NSDate *date4 = [dateFormatter dateFromString:@"1751-03-16"];
	[self addPersonWithFirstName:@"James" lastName:@"Madison" phone:@"444-444-4444" birthDate:date4
						   image:@"http://upload.wikimedia.org/wikipedia/commons/thumb/1/1d/James_Madison.jpg/225px-James_Madison.jpg"];
	
	NSDate *date5 = [dateFormatter dateFromString:@"1758-04-28"];
	[self addPersonWithFirstName:@"James" lastName:@"Monroe" phone:@"555-555-5555" birthDate:date5
						   image:@"http://upload.wikimedia.org/wikipedia/commons/f/f2/Jm5.gif"];
	
	
	NSDate *date16 = [dateFormatter dateFromString:@"1865-02-12"];
	[self addPersonWithFirstName:@"Abraham" lastName:@"Lincoln" phone:@"333-333-3333" birthDate:date16
						   image:@"http://upload.wikimedia.org/wikipedia/commons/thumb/4/44/Abraham_Lincoln_head_on_shoulders_photo_portrait.jpg/225px-Abraham_Lincoln_head_on_shoulders_photo_portrait.jpg"];
    
	NSDate *date40 = [dateFormatter dateFromString:@"1911-02-06"];
	[self addPersonWithFirstName:@"Ronald" lastName:@"Reagan" phone:@"044-244-0344" birthDate:date40
						   image:@"http://upload.wikimedia.org/wikipedia/commons/thumb/1/16/Official_Portrait_of_President_Reagan_1981.jpg/219px-Official_Portrait_of_President_Reagan_1981.jpg"];
	
	NSDate *date41 = [dateFormatter dateFromString:@"1924-06-12"];
	[self addPersonWithFirstName:@"George H. W." lastName:@"Bush" phone:@"345-234-0444" birthDate:date41
						   image:@"http://upload.wikimedia.org/wikipedia/commons/thumb/0/0f/George_H._W._Bush%2C_President_of_the_United_States%2C_1989_official_portrait.jpg/225px-George_H._W._Bush%2C_President_of_the_United_States%2C_1989_official_portrait.jpg"];
	
	NSDate *date42 = [dateFormatter dateFromString:@"1946-08-19"];
	[self addPersonWithFirstName:@"Bill" lastName:@"Clinton" phone:@"144-344-0674" birthDate:date42
						   image:@"http://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Bill_Clinton.jpg/225px-Bill_Clinton.jpg"];
	
	NSDate *date43 = [dateFormatter dateFromString:@"1946-07-06"];
	[self addPersonWithFirstName:@"George W." lastName:@"Bush" phone:@"454-054-0033" birthDate:date43
						   image:@"http://upload.wikimedia.org/wikipedia/commons/thumb/d/d4/George-W-Bush.jpeg/225px-George-W-Bush.jpeg"];
    
	NSDate *date44 = [dateFormatter dateFromString:@"1961-08-04"];
	[self addPersonWithFirstName:@"Barack" lastName:@"Obama" phone:@"(202) 456-1111" birthDate:date44
						   image:@"http://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/Official_portrait_of_Barack_Obama.jpg/225px-Official_portrait_of_Barack_Obama.jpg" street:@"1600 Pennsylvania Ave NW" city:@"Washington" state:@"DC" zip:@"20500"];
    
    
}

-(void) addPersonWithFirstName:(NSString *) firstName
                      lastName:(NSString *) lastName
                         phone:(NSString *) phone
                     birthDate:(NSDate *) birthDate
                         image:(NSString *) image  {
    [self addPersonWithFirstName:firstName lastName:lastName phone:phone birthDate:birthDate image:image street:nil city:nil state:nil zip:nil];
    
}

-(void) addPersonWithFirstName:(NSString *) firstName
                      lastName:(NSString *) lastName
                         phone:(NSString *) phone
                     birthDate:(NSDate *) birthDate
                         image:(NSString *) image
                        street:(NSString*) street
                          city:(NSString*) city
                         state:(NSString*) state
                           zip:(NSString*) zip
{
	
	NSLog(@"PopulateAddressBook.addPersonWithFirstName");
	
    // Create Address Book
    CFErrorRef error = nil;
    ABAddressBookRef addressBook = ABAddressBookCreateWithOptions(NULL, &error);
	ABRecordRef person = ABPersonCreate();
	
    // Set First & Last Name
	ABRecordSetValue(person, kABPersonFirstNameProperty, (__bridge CFTypeRef)firstName , nil);
	ABRecordSetValue(person, kABPersonLastNameProperty, (__bridge CFTypeRef)lastName, nil);
	
    // Set Phone
	ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
	ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)phone, kABPersonPhoneMainLabel, NULL);
	ABRecordSetValue(person, kABPersonPhoneProperty, multiPhone,nil);
	CFRelease(multiPhone);
    
    // Set Address

    if(street||city||state||zip) {
		ABMutableMultiValueRef multiAddress = ABMultiValueCreateMutable(kABMultiDictionaryPropertyType);
		NSMutableDictionary * addressDictionary = [NSMutableDictionary dictionary];
		if(street) {
			[addressDictionary setObject:street forKey:(NSString *)kABPersonAddressStreetKey];
        }
		if(city){
			[addressDictionary setObject:city forKey:(NSString *)kABPersonAddressCityKey];
        }
		if(state) {
			[addressDictionary setObject:state forKey:(NSString *)kABPersonAddressStateKey];
        }
		if(zip){
			[addressDictionary setObject:zip forKey:(NSString *)kABPersonAddressZIPKey];
        }
		ABMultiValueAddValueAndLabel(multiAddress,(__bridge CFTypeRef)addressDictionary,kABWorkLabel,NULL);
		ABRecordSetValue(person,kABPersonAddressProperty,multiAddress,NULL);
		CFRelease(multiAddress);
	}
    
    
	
	// Add Image
	if(image != nil){
		UIImage *myImage = [[UIImage alloc] initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:image]]];
		ABPersonSetImageData(person, ( __bridge CFDataRef ) (UIImageJPEGRepresentation(myImage, 1.0f)), &error);
	}
	
	// Add Birthday
	if(birthDate != nil){
		ABRecordSetValue(person, kABPersonBirthdayProperty, (__bridge CFTypeRef)birthDate , nil);
	}
	
    // Add & Save
	ABAddressBookAddRecord(addressBook, person, &error);
	ABAddressBookSave(addressBook, &error);
	
	CFRelease(person);
	
	if (error != NULL) {
		NSLog(@"Error creating contact %@", error);
	}
}

@end
