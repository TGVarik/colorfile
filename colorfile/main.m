//
//  main.m
//  colorfile
//
//  Created by Tom G Varik on 10/19/14.
//  Copyright (c) 2014 Tom G Varik. All rights reserved.
//

#import <AppKit/AppKit.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSColorList *colorList = [[NSColorList alloc] initWithName:@"Colors"];
        if (argc < 2) {
            printf("Usage: %s name:rrggbb,name:rrggbb,...\n", argv[0]);
            return 0;
        }
        NSString *colors = [NSString stringWithUTF8String:argv[1]];
        for (NSString *colorString in [colors componentsSeparatedByString:@","]){
            NSString *key, *color;
            NSArray *keyAndColor = [colorString componentsSeparatedByString:@":"];
            if ([keyAndColor count] > 1) {
                key = keyAndColor[0];
                color = keyAndColor[1];
            } else {
                key = [NSString stringWithFormat:@"#%@", [colorString lowercaseString]];
                color = colorString;
            }
            NSScanner *scanner = [NSScanner scannerWithString:color];
            unsigned int colorInt;
            [scanner scanHexInt:&colorInt];
            CGFloat r = (CGFloat)((colorInt >> 16) & 0xff) / 0xff;
            CGFloat g = (CGFloat)((colorInt >> 8) & 0xff) / 0xff;
            CGFloat b = (CGFloat)((colorInt & 0xff) / 0xff);
            [colorList setColor: [NSColor colorWithRed:r green:g blue:b alpha:1.0f] forKey:key];
        }
        [colorList writeToFile:@"Colors.clr"];
    }
    return 0;
}
