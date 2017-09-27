//
//  UISearchBar+YNBlocks.m
//  UISearchBarBlocks
//
//  Created by Håkon Bogen on 20.10.13.
//  Copyright (c) 2013 Håkon Bogen. All rights reserved.
//

#import "UISearchBar+YNBlocks.h"
#import <objc/runtime.h>

/* Only for convenience and readabilty in delegate methods */
typedef BOOL (^YN_UISearchBarReturnBlock) (UISearchBar *searchBar);
typedef void (^YN_UISearchBarVoidBlock) (UISearchBar *searchBar);
typedef void (^YN_UISearchBarSearchTextBlock) (UISearchBar *searchBar,NSString *searchText);
typedef BOOL (^YN_UISearchBarInRangeReplacementTextBlock) (UISearchBar *searchBar,NSRange range,NSString *text);
typedef void (^YN_UISearchBarScopeIndexBlock)(UISearchBar *searchBar, NSInteger selectedScope);

@implementation UISearchBar (YNBlocks)


static const void *YN_UISearchBarDelegateKey                                = &YN_UISearchBarDelegateKey;
static const void *YN_UISearchBarShouldBeginEditingKey                      = &YN_UISearchBarShouldBeginEditingKey;
static const void *YN_UISearchBarTextDidBeginEditingKey                     = &YN_UISearchBarTextDidBeginEditingKey;
static const void *YN_UISearchBarShouldEndEditingKey                        = &YN_UISearchBarShouldEndEditingKey;
static const void *YN_UISearchBarTextDidEndEditingKey                       = &YN_UISearchBarTextDidEndEditingKey;
static const void *YN_UISearchBarTextDidChangeKey                           = &YN_UISearchBarTextDidChangeKey;
static const void *YN_UISearchBarShouldChangeTextInRangeKey                 = &YN_UISearchBarShouldChangeTextInRangeKey;
static const void *YN_UISearchBarSearchButtonClickedKey                                = &YN_UISearchBarSearchButtonClickedKey;
static const void *YN_UISearchBarBookmarkButtonClickedKey                                = &YN_UISearchBarBookmarkButtonClickedKey;
static const void *YN_UISearchBarCancelButtonClickedKey                                = &YN_UISearchBarCancelButtonClickedKey;
static const void *YN_UISearchBarResultsListButtonClickedKey                                = &YN_UISearchBarResultsListButtonClickedKey;
static const void *YN_UISearchBarSelectedScopeButtonIndexDidChangeKey                                = &YN_UISearchBarSelectedScopeButtonIndexDidChangeKey;




#pragma mark UISearchBar delegate Methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar;
{
    YN_UISearchBarReturnBlock block = searchBar.yn_completionShouldBeginEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]){
        return [delegate searchBarShouldBeginEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    YN_UISearchBarVoidBlock block = searchBar.yn_completionTextDidBeginEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]){
        [delegate searchBarTextDidBeginEditing:searchBar];
    }
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    YN_UISearchBarReturnBlock block = searchBar.yn_completionShouldEndEditingBlock;
    if (block) {
        return block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]){
        return [delegate searchBarShouldEndEditing:searchBar];
    }
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
   YN_UISearchBarVoidBlock block = searchBar.yn_completionTextDidEndEditingBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]){
        [delegate searchBarTextDidEndEditing:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    YN_UISearchBarSearchTextBlock block = searchBar.yn_completionTextDidChangeBlock;
    if (block) {
        block(searchBar,searchText);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:textDidChange:)]){
        [delegate searchBar:searchBar textDidChange:searchText];
    }
}
// called when text changes (including clear)
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    YN_UISearchBarInRangeReplacementTextBlock block = searchBar.yn_completionShouldChangeTextInRangeBlock;
    if (block) {
        return block(searchBar,range,text);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]){
        return [delegate searchBar:searchBar shouldChangeTextInRange:range replacementText:text];
    }
    return YES;
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    YN_UISearchBarVoidBlock block = searchBar.yn_completionSearchButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]){
        [delegate searchBarSearchButtonClicked:searchBar];
    }
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar
{
    YN_UISearchBarVoidBlock block = searchBar.yn_completionBookmarkButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarBookmarkButtonClicked:)]){
        [delegate searchBarBookmarkButtonClicked:searchBar];
    }
}

- (void)searchBarCancelButtonClicked:(UISearchBar *) searchBar
{
    YN_UISearchBarVoidBlock block = searchBar.yn_completionCancelButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]){
        [delegate searchBarCancelButtonClicked:searchBar];
    }
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)searchBar
{
    YN_UISearchBarVoidBlock block = searchBar.yn_completionResultsListButtonClickedBlock;
    if (block) {
        block(searchBar);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBarResultsListButtonClicked:)]){
        [delegate searchBarResultsListButtonClicked:searchBar];
    }
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope
{
    YN_UISearchBarScopeIndexBlock block = searchBar.yn_completionSelectedScopeButtonIndexDidChangeBlock;
    if (block) {
        block(searchBar,selectedScope);
    }
    id delegate = objc_getAssociatedObject(self, YN_UISearchBarDelegateKey);
    
    if (delegate && [delegate respondsToSelector:@selector(searchBar:selectedScopeButtonIndexDidChange:)]){
        [delegate searchBar:searchBar selectedScopeButtonIndexDidChange:selectedScope];
    }
}


#pragma mark Block setting/getting methods
- (BOOL (^)(UISearchBar *))yn_completionShouldBeginEditingBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarShouldBeginEditingKey);
}

- (void)setYn_completionShouldBeginEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldBeginEditingBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarShouldBeginEditingKey, searchBarShouldBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))yn_completionTextDidBeginEditingBlock
{
    return objc_getAssociatedObject(self,YN_UISearchBarTextDidBeginEditingKey);
}

- (void)setYn_completionTextDidBeginEditingBlock:(void (^)(UISearchBar *))searchBarTextDidBeginEditingBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarTextDidBeginEditingKey, searchBarTextDidBeginEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *))yn_completionShouldEndEditingBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarShouldEndEditingKey);
}

- (void)setYn_completionShouldEndEditingBlock:(BOOL (^)(UISearchBar *))searchBarShouldEndEditingBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarShouldEndEditingKey, searchBarShouldEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))yn_completionTextDidEndEditingBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarTextDidEndEditingKey);
}

- (void)setYn_completionTextDidEndEditingBlock:(void (^)(UISearchBar *))searchBarTextDidEndEditingBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarTextDidEndEditingKey, searchBarTextDidEndEditingBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSString *))yn_completionTextDidChangeBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarTextDidChangeKey);
}

- (void)setYn_completionTextDidChangeBlock:(void (^)(UISearchBar *, NSString *))searchBarTextDidChangeBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarTextDidChangeKey, searchBarTextDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (BOOL (^)(UISearchBar *, NSRange, NSString *))yn_completionShouldChangeTextInRangeBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarShouldChangeTextInRangeKey);
}

- (void)setYn_completionShouldChangeTextInRangeBlock:(BOOL (^)(UISearchBar *, NSRange, NSString *))searchBarShouldChangeTextInRangeBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarShouldChangeTextInRangeKey, searchBarShouldChangeTextInRangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))yn_completionSearchButtonClickedBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarSearchButtonClickedKey);
}

- (void)setYn_completionSearchButtonClickedBlock:(void (^)(UISearchBar *))searchBarSearchButtonClickedBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarSearchButtonClickedKey, searchBarSearchButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))yn_completionBookmarkButtonClickedBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarBookmarkButtonClickedKey);
}

- (void)setYn_completionBookmarkButtonClickedBlock:(void (^)(UISearchBar *))searchBarBookmarkButtonClickedBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarBookmarkButtonClickedKey, searchBarBookmarkButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))yn_completionCancelButtonClickedBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarCancelButtonClickedKey);
}

- (void)setYn_completionCancelButtonClickedBlock:(void (^)(UISearchBar *))searchBarCancelButtonClickedBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarCancelButtonClickedKey, searchBarCancelButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *))yn_completionResultsListButtonClickedBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarResultsListButtonClickedKey);
}

- (void)setYn_completionResultsListButtonClickedBlock:(void (^)(UISearchBar *))searchBarResultsListButtonClickedBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarResultsListButtonClickedKey, searchBarResultsListButtonClickedBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UISearchBar *, NSInteger))yn_completionSelectedScopeButtonIndexDidChangeBlock
{
    return objc_getAssociatedObject(self, YN_UISearchBarSelectedScopeButtonIndexDidChangeKey);
}

- (void)setYn_completionSelectedScopeButtonIndexDidChangeBlock:(void (^)(UISearchBar *, NSInteger))searchBarSelectedScopeButtonIndexDidChangeBlock
{
    [self yn_setDelegateIfNoDelegateSet];
    objc_setAssociatedObject(self, YN_UISearchBarSelectedScopeButtonIndexDidChangeKey, searchBarSelectedScopeButtonIndexDidChangeBlock, OBJC_ASSOCIATION_COPY);
}

- (void)yn_setDelegateIfNoDelegateSet
{
    if (self.delegate != (id<UISearchBarDelegate>)self) {
        objc_setAssociatedObject(self, YN_UISearchBarDelegateKey, self.delegate, OBJC_ASSOCIATION_ASSIGN);
        self.delegate = (id<UISearchBarDelegate>)self;
    }
}

@end
