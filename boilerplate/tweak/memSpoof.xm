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
        NSLog(@"[ramSpoof]: Returned Spoofed Mem");
    }
}
%end
%end
void setupData() {
    data = [NSUserDefaults standardUserDefaults];
    NSLog(@"[ramSpoof]: Set the \"data\" variable");
    runOrig = true;
    NSLog(@"[ramSpoof]: Set runOrig");
    int oldMem = (int)[NSProcessInfo processInfo].physicalMemory;
    NSLog(@"[ramSpoof]: Got the old memory");
    int dividedNewMem = (oldMem / DIVIDER) + 2000;
    NSLog(@"[ramSpoof]: Divided it");
    int regularNewMem = dividedNewMem * DIVIDER;
    NSLog(@"[ramSpoof]: Multiplied it");
    [data setInteger:regularNewMem forKey:@"mem"];
    NSLog(@"[ramSpoof]: Saved it");
    [data synchronize];
    NSLog(@"[ramSpoof]: Synchronzed me");
    runOrig = false;
    NSLog(@"Cleaned up");
}
extern "C" void memSpoof() {
    if (![data integerForKey:@"mem"]) {
        NSLog(@"[ramSpoof]: Setting Up...");
        setupData();
    }
    %init(start);
}