//
//  ViewController.m
//  AYCollectionViewFlowLayoutDemo
//
//  Created by Avadesh Kumar on 21/11/15.
//  Copyright © 2015 AYSamples. All rights reserved.
//

#import "ViewController.h"
#import "AYCollectionViewFlowLayout.h"

@interface ViewController ()
@property (strong, nonatomic) UICollectionView *collectionView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.collectionViewLayout = [[AYCollectionViewFlowLayout alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionView data sourcec and delegate methods
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MyCell" forIndexPath:indexPath];
    [cell.contentView setBackgroundColor:(indexPath.item %2 == 0)? [UIColor blueColor]: [UIColor redColor]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height = 80.0;
    
    if (indexPath.item %2 == 0) {
        height = 130.0;
    }
    
    return CGSizeMake(collectionView.frame.size.width - 20, height);
}

@end
