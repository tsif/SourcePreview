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
    
    NSString *html = [NSString stringWithFormat:@"<!DOCTYPE html>"
                      "<html>"
                      "<head>"
                      "<style>*{margin:0;padding:0;font-size:95%%;}body{background-image: url(\"data:image/jpg;base64,%@\");}%@</style>"
                      "</head>"
                      "<body>"
                      "<div class=\"page-header\">"
                      "<h1>swift</h1>"
                      "</div>"
                      "<pre><code class=\"language-javascript\">%@</code></pre>"
                      "<script>%@</script>"
                      "</body>"
                      "</html>",
                      base64Image,
                      cssContent,
                      [NSString stringWithCString:source.UTF8String encoding:NSUTF8StringEncoding],
                      jsContent];
    
    return [html dataUsingEncoding:NSUTF8StringEncoding];
}
