#import <Foundation/Foundation.h>
#import "../.resources/logging/RemoteLog.h"

BOOL runOrig = false;
#define DIVIDER (1024 * 1024 * 1024)
NSUserDefaults *data = nil;

%group start
%hook NSProcessInfo
-(unsigned long long)physicalMemory {
    if (runOrig) {
        return %orig;
        NSLog(@"[ramSpoof]: Ran Orig");
    } else {
        return (unsigned long long)[data integerForKey:@"mem"];
    }
}
%end
%end
void setupData() {
    data = [NSUserDefaults standardUserDefaults];
    runOrig = true;
    int oldMem = (int)[NSProcessInfo processInfo].physicalMemory;
    int dividedNewMem = (oldMem / DIVIDER) + 2000;
    int regularNewMem = dividedNewMem * DIVIDER;
    [data setInteger:regularNewMem forKey:@"mem"];
    [data synchronize];
    runOrig = false;
}
extern "C" void memSpoof() {
    if (![data integerForKey:@"mem"]) {
        setupData();
    }
    %init(start);
}
