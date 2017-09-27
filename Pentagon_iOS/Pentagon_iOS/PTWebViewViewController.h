//
//  PTWebViewViewController.h
//  Pentagon_iOS
//
//  Created by vinci on 2017/6/27.
//  Copyright © 2017年 vinci. All rights reserved.
//

#import "PTBaseViewController.h"
@class Request;

typedef NS_ENUM(NSInteger, MusicServiceType){
    MusicServiceTypeSpotify = 0,
    MusicServiceTypeSoundCloud,
    MusicServiceTypeAlexa
};

@interface PTWebViewViewController : PTBaseViewController

@property (nonatomic, assign)MusicServiceType type;
@property (nonatomic, copy) void (^loginService)(Request *r,MusicServiceType type);
    

@end
