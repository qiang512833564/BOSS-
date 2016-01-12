//
//  UIViewExtension.swift
//  BOSS刷新模拟
//
//  Created by lizhongqiang on 16/1/12.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

import UIKit

extension UIView {
    
}

extension UIBezierPath {
    class func bezierPathWithText(text:NSString,attribute:NSDictionary)->UIBezierPath{
        
        let attrStrs = NSAttributedString(string:text as String, attributes:attribute as? [String : AnyObject])
        
        let paths = CGPathCreateMutable()
        let line = CTLineCreateWithAttributedString(attrStrs)
        let runArray = CTLineGetGlyphRuns(line)
        
        for var runIndex=0;runIndex < CFArrayGetCount(runArray); ++runIndex {
            let run:CTRunRef! = CFArrayGetValueAtIndex(runArray, runIndex) as! CTRunRef
//            let runFont:CTFontRef! = CFDictionaryGetValue(CTRunGetAttributes(run),kCTFontAttributeName) as! CTFontRef;
            var cfString:CFString = kCTFontAttributeName
            let runFont:CTFont = CFDictionaryGetValue(CTRunGetAttributes(run), &cfString) as! CTFont;
            for var runGlyphIndex = 0; runGlyphIndex < CTRunGetGlyphCount(run);++runGlyphIndex{
                let thisGlyphRange = CFRangeMake(runGlyphIndex, 1)
                var glyph:CGGlyph = CGGlyph()
                var position:CGPoint = CGPoint()
                CTRunGetGlyphs(run, thisGlyphRange, &glyph)
                CTRunGetPositions(run, thisGlyphRange, &position)
                let path:CGPathRef! = CTFontCreatePathForGlyph(runFont, glyph, Optional.None!)
                var t:CGAffineTransform = CGAffineTransformMakeTranslation(position.x, position.y)
                CGPathAddPath(paths, &t, path)
////                    CGPathRelease(path)
                
            }
        }
//        CFRelease(line)
       
        let path:UIBezierPath! = UIBezierPath();
        path .moveToPoint(CGPointZero)
        path .appendPath(UIBezierPath(CGPath: paths))
//        CGPathRelease(paths)
        
        return path
    }
    
}