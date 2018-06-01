/*
 *  Regurgitator.h
 */

#ifndef Regurgitator_h
#define Regurgitator_h

#import <Foundation/Foundation.h>
#import <AppKit/AppKit.h>

NSImage *imageTintedWithColor(NSImage *original, NSColor *tint);
NSString *imageToNSString(NSImage *image);
NSString *regurgitateHTML(NSURL* url);
NSData *regurgitateHTMLData(NSURL* url);

#endif /* Regurgitator_h */
