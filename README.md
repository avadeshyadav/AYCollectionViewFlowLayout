# AYCollectionViewFlowLayout
This is a custom flow layout to demonstrate compression effect when collectionview is overscrolled.

![giphy](https://github.com/avadeshyadav/AYCollectionViewFlowLayout/blob/master/AYCollectionViewFlowLayoutDemo/Sample.gif)

1. To integrate it in your project, just add AYCollectionViewFlowLayout folder from this project to your project.

2. Now either integrate it via Interface builder or via code.
      i). Via Interface builder:
        
      Open Storyboard/xib file, select your CollectionView, and under collection view select CollectionViewFlowLayout.


    
Now go to Identity Inspector tab on the right pane, Under Custom Class section, set value for the class field to AYCollectionViewFlowLayout.

  ii). Via Code:
  
   Goto your ViewController class, in which you want integrate AYCollectionViewFlowLayout flow layout.
   Import AYCollectionViewFlowLayout in your class like:
   
   #import "AYCollectionViewFlowLayout.h"

   Now find viewDidLoad Method and insert one line of code like:
  
 - (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.collectionViewLayout = [[AYCollectionViewFlowLayout alloc] init];
  }

Now you are ready to go......cheers..:)
