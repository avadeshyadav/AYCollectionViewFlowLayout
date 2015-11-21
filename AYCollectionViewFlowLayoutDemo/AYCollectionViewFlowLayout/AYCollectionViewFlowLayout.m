//
//  MyFlowLayout.m
//  FlowLayoutSample
//
//  Created by Avadesh Kumar on 18/11/15.
//  Copyright © 2015 ibiboRydes. All rights reserved.
//

#define kDivideFactor 4

#import "AYCollectionViewFlowLayout.h"

@protocol UICollectionViewDelegateFlowLayout;

@interface AYCollectionViewFlowLayout ()
@property (nonatomic, strong) NSDictionary *layoutInfo;
@end

@implementation AYCollectionViewFlowLayout

#pragma mark - Layout

- (void)prepareLayout
{
    [super prepareLayout];
    
    NSMutableDictionary *newLayoutInfo = [NSMutableDictionary dictionary];
    NSMutableDictionary *cellLayoutInfo = [NSMutableDictionary dictionary];
    
    NSInteger sectionCount = [self.collectionView numberOfSections];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    
    for (NSInteger section = 0; section < sectionCount; section++) {
        NSInteger itemCount = [self.collectionView numberOfItemsInSection:section];
        
        for (NSInteger item = 0; item < itemCount; item++) {
            indexPath = [NSIndexPath indexPathForItem:item inSection:section];
            
            UICollectionViewLayoutAttributes *itemAttributes =
            [super layoutAttributesForItemAtIndexPath:indexPath];
            
            cellLayoutInfo[indexPath] = [itemAttributes copy];
        }
    }
    
    newLayoutInfo[@"MyCell"] = cellLayoutInfo;
    
    self.layoutInfo = newLayoutInfo;
}

#pragma mark - Private
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *allAttributes = [NSMutableArray arrayWithCapacity:self.layoutInfo.count];
    float yOffset = self.collectionView.contentOffset.y;
    float bottomOffset = 0;
    
    if ([self collectionViewContentSize].height > self.collectionView.frame.size.height) {
        bottomOffset = [self collectionViewContentSize].height - (self.collectionView.frame.size.height + yOffset);
    }


    [self.layoutInfo enumerateKeysAndObjectsUsingBlock:^(NSString *elementIdentifier,
                                                         NSDictionary *elementsInfo,
                                                         BOOL *stop) {
        
        NSInteger numberOfItems = [[elementsInfo allKeys] count];
        
        [elementsInfo enumerateKeysAndObjectsUsingBlock:^(NSIndexPath *indexPath,
                                                          UICollectionViewLayoutAttributes *attributes,
                                                          BOOL *innerStop) {
          
            if (CGRectIntersectsRect(rect, attributes.frame)) {
                
                if (yOffset < 0) {
                    
                    float topScaleRatio = 1 - (fabs(yOffset) / (attributes.frame.size.height * kDivideFactor));

                    CGAffineTransform t = CGAffineTransformMakeTranslation(0, yOffset/(kDivideFactor - 0.2) * indexPath.item);
                    t = CGAffineTransformScale(t, 1, topScaleRatio);
                    attributes.transform = t;
                }
                else if (0 > bottomOffset) {
                    
                    float bottomScaleRatio = 1 - (fabs(bottomOffset) / (attributes.frame.size.height * kDivideFactor));

                    CGAffineTransform t = CGAffineTransformMakeTranslation(0, -(bottomOffset/(kDivideFactor - 0.2) * (numberOfItems - (indexPath.item + 1))));
                    t = CGAffineTransformScale(t, 1, bottomScaleRatio);
                    attributes.transform = t;
                }
                else {
                    attributes.transform = CGAffineTransformIdentity;
                }

                [allAttributes addObject:attributes];
            }
        }];
    }];

    return allAttributes;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.layoutInfo[@"MyCell"][indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)bounds
{
    return YES;
}

@end
