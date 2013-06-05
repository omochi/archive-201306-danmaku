//
//  main.m
//  Danmaku
//
//  Created by おもちメタル on 13/06/03.
//  Copyright (c) 2013年 com.omochimetaru. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ODMAppDelegate.h"

#if HOGEHOGE
#warning aaaa
#endif

int main(int argc, char *argv[])
{
	@autoreleasepool {
		@try {
			return UIApplicationMain(argc, argv, nil, NSStringFromClass([ODMAppDelegate class]));
		}
		@catch (NSException *exception) {
			NSLog(@"Uncaught exception: %@", exception.description);
			NSLog(@"Stack trace: %@", [exception callStackSymbols]);
			return EXIT_FAILURE;
		}
	}
}
