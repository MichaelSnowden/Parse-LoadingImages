//
//  MyCollectionViewController.m
//  CardForgeCopy
//
//  Created by Michael Snowden on 7/27/14.
//  Copyright (c) 2014 Michael Snowden. All rights reserved.
//

#import "MyCollectionViewController.h"
#import "MyBlownupImageViewController.h"

@interface MyCollectionViewController ()

@property (nonatomic, strong) NSArray *images;

@end

@implementation MyCollectionViewController
{
    NSUInteger _indexOfSelectedImage;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    PFQuery *query = [MTGCard query];
    MyCollectionViewController *weakSelf = self;
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        NSMutableArray *images = [NSMutableArray arrayWithCapacity:objects.count];
        for (MTGCard *card in objects)
        {
            UIImage *image = [UIImage imageWithData:[card.image getData]];
            [images addObject:image];
        }
        weakSelf.images = images;
        dispatch_sync(dispatch_get_main_queue(), ^{
            [weakSelf.collectionView reloadData];
            weakSelf.title = [NSString stringWithFormat:@"Number of images: %lu", (unsigned long)objects.count];
        });
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _images.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseIdentifier"
                                                                           forIndexPath:indexPath];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    UIImage *image = _images[indexPath.row];
    imageView.image = image;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    _indexOfSelectedImage = indexPath.row;
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BlownupImage"])
    {
        MyBlownupImageViewController *vc = segue.destinationViewController;
        vc.indexOfSelectedImage = _indexOfSelectedImage;
        vc.images = _images;
    }
}

@end
