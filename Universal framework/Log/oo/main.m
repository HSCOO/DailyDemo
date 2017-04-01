//
//  main.m
//  oo
//
//  Created by OnlyStu on 2017/4/1.
//  Copyright © 2017年 OnlyStu. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AppleScriptObjC/AppleScriptObjC.h>

int main(int argc, const char * argv[]) {
    [[NSBundle mainBundle] loadAppleScriptObjectiveCScripts];
    return NSApplicationMain(argc, argv);
}
