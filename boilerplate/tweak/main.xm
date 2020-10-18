/*
 * Tweak.x
 * boilerPlate
 *
 * Created by c0dine <c0dineDev@gmail.com> on 2020/08/15.
 * Copyright © 2020 c0dine <c0dineDev@gmail.com>. All rights reserved.
 *
 *	////DEFINITIONS///////////////////////////////////////////////////////////////////////////////
 *	// %log: Logs everything about a certain method                                             //
 *	// %hook: Creates a pointer swap at that Class's functions                                  //
 *	// %ctor: Calls this code before creating a pointer swap                                    //
 *	// (%group/%end): Groups hooks to call conditionally                                        //
 *	// %orig: Run the methods original code (can be called conditionally)                       //
 *	// %orig(arguments): Call the original code with custom arguments (requires all arguments)  //
 *	//////////////////////////////////////////////////////////////////////////////////////////////
 */
#import "main.h"
%ctor {
    NSLog (@"[Main BoilerPlate] Starting groups now...");
    welcome();
    memSpoof();
}