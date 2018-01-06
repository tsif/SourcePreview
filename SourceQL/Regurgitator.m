/*
 *  Regurgitator.m
 */

#import "Regurgitator.h"

NSString *imageToNSString(NSImage *image)
{
    NSData *imageData = [image TIFFRepresentation];
    NSBitmapImageRep *imageRep = [NSBitmapImageRep imageRepWithData:imageData];
    imageData = [imageRep representationUsingType:NSPNGFileType properties:Nil];
    
    NSString *base64 = [imageData base64EncodedStringWithOptions:nil];
    
    return base64;
}

NSData *regurgitateHTML(NSURL* url)
{
    NSStringEncoding usedEncoding = 0;
    NSError *readError = nil;
    
    NSString *source = [NSString stringWithContentsOfURL:url usedEncoding:&usedEncoding error:&readError];
    
    if (usedEncoding == 0)
    {
        NSLog(@"Failed to determine encoding for file %@", [url path]);
    }
    
    NSURL *imageURL = [[NSBundle bundleWithIdentifier:@"tsif.ql-swift"] URLForResource:@"swift_logo" withExtension:@"png"];
    NSImage *image = [[NSImage alloc] initWithContentsOfURL:imageURL];
    NSString *base64Image = imageToNSString(image);
    
    NSString *cssPath = [[NSBundle bundleWithIdentifier:@"tsif.ql-swift"] pathForResource:@"prism.css" ofType:nil];
    NSString *cssContent = [NSString stringWithContentsOfFile:cssPath
                                                     encoding:NSUTF8StringEncoding
                                                        error:nil];
    
    NSString *jsPath = [[NSBundle bundleWithIdentifier:@"tsif.ql-swift"] pathForResource:@"prism.js" ofType:nil];
    NSString *jsContent = [NSString stringWithContentsOfFile:jsPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    NSString *htmlPath = [[NSBundle bundleWithIdentifier:@"tsif.ql-swift"] pathForResource:@"page.html" ofType:nil];
    NSString *htmlContent = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    
    NSString *html = [NSString stringWithFormat:htmlContent,
                      base64Image,
                      cssContent,
                      [NSString stringWithCString:source.UTF8String encoding:NSUTF8StringEncoding],
                      jsContent];
    
    return [html dataUsingEncoding:NSUTF8StringEncoding];
}
