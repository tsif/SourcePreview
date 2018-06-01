#include <CoreFoundation/CoreFoundation.h>
#include <CoreServices/CoreServices.h>
#include <QuickLook/QuickLook.h>

#include "Regurgitator.h"

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize);
void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail);

/* -----------------------------------------------------------------------------
    Generate a thumbnail for file

   This function's job is to create thumbnail for designated file as fast as possible
   ----------------------------------------------------------------------------- */

OSStatus GenerateThumbnailForURL(void *thisInterface, QLThumbnailRequestRef thumbnail, CFURLRef url, CFStringRef contentTypeUTI, CFDictionaryRef options, CGSize maxSize)
{
    NSStringEncoding usedEncoding = 0;
    NSError *readError = nil;
    
    NSString *source = [NSString stringWithContentsOfURL:(__bridge NSURL*)url usedEncoding:&usedEncoding error:&readError];
    
    if (usedEncoding == 0) {
        NSLog(@"Failed to determine encoding for file %@", [(__bridge NSURL*)url path]);
        return noErr;
    }
    
    source = [NSString stringWithCString:source.UTF8String encoding:NSUTF8StringEncoding];
    
    // Load water mark
    
    NSURL *imageURL = [[NSBundle bundleWithIdentifier:@"tsif.swift-preview"] URLForResource:@"swift_logo" withExtension:@"png"];
    NSImage *image = imageTintedWithColor([[NSImage alloc] initWithContentsOfURL:imageURL], [NSColor colorWithWhite:1.0f alpha:0.1f]);
    CGFloat iconScale = image.size.width / maxSize.width;
    
    NSRect renderRect = NSMakeRect(0.0, 0.0, maxSize.width, maxSize.height);
    CGFloat iconHeight = image.size.height / iconScale;
    NSRect iconRect = NSMakeRect(0.0, maxSize.height - iconHeight, maxSize.width, iconHeight);
    
    CGContextRef context = QLThumbnailRequestCreateContext(thumbnail, maxSize, false, NULL);
    if (context) {
        NSGraphicsContext* graphicsContext = [NSGraphicsContext graphicsContextWithGraphicsPort:(void *)context flipped:NO];
        
        [NSGraphicsContext setCurrentContext:graphicsContext];
        [image drawInRect:iconRect];
        
        NSDictionary *textAttributes =
        @{
          NSForegroundColorAttributeName: [NSColor blackColor],
          NSBackgroundColorAttributeName: [NSColor clearColor],
          NSFontAttributeName: [NSFont fontWithName:@"Monaco" size:10.0]
          };
        [source drawInRect:renderRect withAttributes:textAttributes];
        
        QLThumbnailRequestFlushContext(thumbnail, context);
        CFRelease(context);
    }

    
    // To complete your generator please implement the function GenerateThumbnailForURL in GenerateThumbnailForURL.c
    return noErr;
}

void CancelThumbnailGeneration(void *thisInterface, QLThumbnailRequestRef thumbnail)
{
    // Implement only if supported
}
