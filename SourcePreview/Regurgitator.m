/*
 *  Regurgitator.m
 */

#import "Regurgitator.h"

NSImage *imageTintedWithColor(NSImage *original, NSColor *tint)
{
    NSImage *image = [original copy];
    if (tint) {
        NSImage *newImage = [[NSImage alloc] initWithSize:[image size]];
        [newImage lockFocus];
        [[NSColor whiteColor] set];
        NSRectFill(NSMakeRect(0,0,[newImage size].width, [newImage size].height));
        [image compositeToPoint:NSZeroPoint operation:NSCompositeCopy];
        [newImage unlockFocus];
        
        return newImage;
    }
    return image;
}

NSString *imageToNSString(NSImage *image)
{
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    imageData = [imageRep representationUsingType:NSPNGFileType properties:Nil];
    
    NSString *base64 = [imageData base64EncodedStringWithOptions:nil];
    
    return base64;
}

NSString *regurgitateHTML(NSURL* url)
{
    NSStringEncoding usedEncoding = 0;
    NSError *readError = nil;
    
    NSString *source = [NSString stringWithContentsOfURL:url usedEncoding:&usedEncoding error:&readError];
    
    if (usedEncoding == 0)
    {
        NSLog(@"Failed to determine encoding for file %@", [url path]);
    }
    
    NSURL *imageURL = [[NSBundle bundleWithIdentifier:@"tsif.swift-preview"] URLForResource:@"swift_logo" withExtension:@"png"];
    NSImage *image = imageTintedWithColor([[NSImage alloc] initWithContentsOfURL:imageURL], [NSColor colorWithWhite:1.0f alpha:0.95f]);
    NSString *base64Image = imageToNSString(image);
    
    NSString *cssPath = [[NSBundle bundleWithIdentifier:@"tsif.swift-preview"] pathForResource:@"prism.css" ofType:nil];
    NSString *cssContent = [NSString stringWithContentsOfFile:cssPath
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    
    NSString *jsPath = [[NSBundle bundleWithIdentifier:@"tsif.swift-preview"] pathForResource:@"prism.js" ofType:nil];
    NSString *jsContent = [NSString stringWithContentsOfFile:jsPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    NSString *htmlPath = [[NSBundle bundleWithIdentifier:@"tsif.swift-preview"] pathForResource:@"page.html" ofType:nil];
    NSString *htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                      encoding:NSUTF8StringEncoding
                                                         error:nil];
    
    NSString *html = [NSString stringWithFormat:htmlContent,
                      base64Image,
                      cssContent,
                      url.absoluteString,
                      [NSString stringWithCString:source.UTF8String encoding:NSUTF8StringEncoding],
                      jsContent];
    
    return html;
}

NSData *regurgitateHTMLData(NSURL* url)
{
    NSStringEncoding usedEncoding = 0;
    NSError *readError = nil;
    
    NSString *source = [NSString stringWithContentsOfURL:url usedEncoding:&usedEncoding error:&readError];
    
    if (usedEncoding == 0)
    {
        NSLog(@"Failed to determine encoding for file %@", [url path]);
    }
    
    NSURL *imageURL = [[NSBundle bundleWithIdentifier:@"tsif.swift-preview"] URLForResource:@"swift_logo" withExtension:@"png"];
    NSImage *image = imageTintedWithColor([[NSImage alloc] initWithContentsOfURL:imageURL], [NSColor colorWithWhite:1.0f alpha:0.95f]);
    NSString *base64Image = imageToNSString(image);
    
    NSString *cssPath = [[NSBundle bundleWithIdentifier:@"tsif.swift-preview"] pathForResource:@"prism.css" ofType:nil];
    NSString *cssContent = [NSString stringWithContentsOfFile:cssPath
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    
    NSString *jsPath = [[NSBundle bundleWithIdentifier:@"tsif.swift-preview"] pathForResource:@"prism.js" ofType:nil];
    NSString *jsContent = [NSString stringWithContentsOfFile:jsPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    NSString *htmlPath = [[NSBundle bundleWithIdentifier:@"tsif.swift-preview"] pathForResource:@"page.html" ofType:nil];
    NSString *htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    NSString *html = [NSString stringWithFormat:htmlContent,
                      base64Image,
                      cssContent,
                      url.absoluteString,
                      [NSString stringWithCString:source.UTF8String encoding:NSUTF8StringEncoding],
                      jsContent];
    
    return [html dataUsingEncoding:NSUTF8StringEncoding];
}
