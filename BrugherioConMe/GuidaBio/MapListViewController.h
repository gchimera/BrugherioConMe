//
//  MapListViewController.h
//  GuidaBIO
//
//  Created by Silvia Pessini on 04/01/13.
//  Copyright (c) 2013 Aries Comunicazione srl. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MapListViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
  
}

  @property (nonatomic,retain) NSMutableArray* lista;
@end
