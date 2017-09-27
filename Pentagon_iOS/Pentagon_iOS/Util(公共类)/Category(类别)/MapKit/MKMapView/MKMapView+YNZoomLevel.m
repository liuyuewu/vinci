//
//  MKMapView+ZoomLevel.m
//  ynCategories (https://github.com/shaojiankui/ynCategories)
//
//  Created by Jakey on 15/4/1.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

// MKMapView+ZoomLevel.m

#import "MKMapView+YNZoomLevel.h"

#define yn_MERCATOR_OFFSET 268435456
#define yn_MERCATOR_RADIUS 85445659.44705395

@implementation MKMapView (YNZoomLevel)

#pragma mark -
#pragma mark Map conversion methods

- (double)yn_longitudeToPixelSpaceX:(double)longitude
{
    return round(yn_MERCATOR_OFFSET + yn_MERCATOR_RADIUS * longitude * M_PI / 180.0);
}

- (double)yn_latitudeToPixelSpaceY:(double)latitude
{
    return round(yn_MERCATOR_OFFSET - yn_MERCATOR_RADIUS * logf((1 + sinf(latitude * M_PI / 180.0)) / (1 - sinf(latitude * M_PI / 180.0))) / 2.0);
}

- (double)yn_pixelSpaceXToLongitude:(double)pixelX
{
    return ((round(pixelX) - yn_MERCATOR_OFFSET) / yn_MERCATOR_RADIUS) * 180.0 / M_PI;
}

- (double)yn_pixelSpaceYToLatitude:(double)pixelY
{
    return (M_PI / 2.0 - 2.0 * atan(exp((round(pixelY) - yn_MERCATOR_OFFSET) / yn_MERCATOR_RADIUS))) * 180.0 / M_PI;
}

#pragma mark -
#pragma mark Helper methods

- (MKCoordinateSpan)yn_coordinateSpanWithMapView:(MKMapView *)mapView
                             centerCoordinate:(CLLocationCoordinate2D)centerCoordinate
                                 andZoomLevel:(NSUInteger)zoomLevel
{
    // convert center coordiate to pixel space
    double centerPixelX = [self yn_longitudeToPixelSpaceX:centerCoordinate.longitude];
    double centerPixelY = [self yn_latitudeToPixelSpaceY:centerCoordinate.latitude];
    
    // determine the scale value from the zoom level
    NSInteger zoomExponent = 20 - zoomLevel;
    double zoomScale = pow(2, zoomExponent);
    
    // scale the map’s size in pixel space
    CGSize mapSizeInPixels = mapView.bounds.size;
    double scaledMapWidth = mapSizeInPixels.width * zoomScale;
    double scaledMapHeight = mapSizeInPixels.height * zoomScale;
    
    // figure out the position of the top-left pixel
    double topLeftPixelX = centerPixelX - (scaledMapWidth / 2);
    double topLeftPixelY = centerPixelY - (scaledMapHeight / 2);
    
    // find delta between left and right longitudes
    CLLocationDegrees minLng = [self yn_pixelSpaceXToLongitude:topLeftPixelX];
    CLLocationDegrees maxLng = [self yn_pixelSpaceXToLongitude:topLeftPixelX + scaledMapWidth];
    CLLocationDegrees longitudeDelta = maxLng - minLng;
    
    // find delta between top and bottom latitudes
    CLLocationDegrees minLat = [self yn_pixelSpaceYToLatitude:topLeftPixelY];
    CLLocationDegrees maxLat = [self yn_pixelSpaceYToLatitude:topLeftPixelY + scaledMapHeight];
    CLLocationDegrees latitudeDelta = -1 * (maxLat - minLat);
    
    // create and return the lat/lng span
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    return span;
}

#pragma mark -
#pragma mark Public methods

- (void)yn_setCenterCoordinate:(CLLocationCoordinate2D)centerCoordinate
                  zoomLevel:(NSUInteger)zoomLevel
                   animated:(BOOL)animated
{
    // clamp large numbers to 28
    zoomLevel = MIN(zoomLevel, 28);
    
    // use the zoom level to compute the region
    MKCoordinateSpan span = [self yn_coordinateSpanWithMapView:self centerCoordinate:centerCoordinate andZoomLevel:zoomLevel];
    MKCoordinateRegion region = MKCoordinateRegionMake(centerCoordinate, span);
    
    // set the region like normal
    [self setRegion:region animated:animated];
}

@end
