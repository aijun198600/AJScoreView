//
//  AJScoreView.m
//  Pods
//
//  Created by Aijun on 16/10/4.
//
//

#import "AJScoreView.h"

@implementation AJScoreView
{
    
    CAShapeLayer *unSelectedLayer;
    CAShapeLayer *selectedLayer;
    CALayer *unSelectedMaskLayer;
    CALayer *selectedMaskLayer;
    
    CGRect pathBounds;
    CGRect totoalPathBounds;
    CGFloat scale;
    CGFloat scalePadding;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self != nil) {
        [self commonInit];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self != nil) {
        [self commonInit];
    }
    return self;
}

#pragma mark - Data Init methods
- (void)commonInit {
    
    _minimumValue = _minimumValue?_minimumValue:0.0;
    _maximumValue = _maximumValue?_maximumValue:5.0;
    _value = _value?_value:_minimumValue;
    _number = _number?_number:5;
    _padding = _padding?_padding:2.0;
    _type = _type?_type:AJScoreViewStarType;
    _path = _path?_path:[self obtainStarPath];
    _alignment = _alignment?_alignment:AJScoreViewAlignmentLeft;
    _editing = _editing?_editing:YES;
    _selectedColor = _selectedColor?_selectedColor:[UIColor yellowColor];
    _unselectedColor = _unselectedColor?_unselectedColor:[UIColor grayColor];
    
}

#pragma mark - Draw methods
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGRect pathBounds;
    if (_path) {
        
        pathBounds = _path.bounds;
        [_path applyTransform:CGAffineTransformMakeTranslation(-pathBounds.origin.x,-pathBounds.origin.y)];
        pathBounds = _path.bounds;
        
    }else{
        return;
    }
    
    CGRect drawRect = CGRectMake(_insert.left,_insert.top, rect.size.width-(_insert.left+_insert.right), rect.size.height-(_insert.top+_insert.bottom));
    if (_padding*(_number-1) >= drawRect.size.width) {
        return;
    }
    
    //缩放百分比
    CGFloat scale;
    CGFloat padding;
    if (_alignment == AJScoreViewAlignmentCenter) {
        padding = 0.0;
    }else{
        padding = _padding;
    }
    if ((drawRect.size.width-(_number-1)*padding)/pathBounds.size.width/_number > (drawRect.size.height/pathBounds.size.height)) {
        scale = drawRect.size.height/pathBounds.size.height;
    }else{
        scale = (drawRect.size.width-(_number-1)*padding)/pathBounds.size.width/_number;
    }
    //确定间隙
    CGFloat scalePadding;
    if (_alignment == AJScoreViewAlignmentCenter) {
        scalePadding = (drawRect.size.width-pathBounds.size.width*scale*_number)/(_number-1)/scale;
    }else{
        scalePadding = _padding/scale;
    }
    
    UIBezierPath *totalPath = [UIBezierPath bezierPath];
    for (int i=0; i<_number; i++) {
        
        UIBezierPath *copyPath = [UIBezierPath bezierPath];
        [copyPath appendPath:_path];
        [copyPath applyTransform:CGAffineTransformMakeTranslation((pathBounds.size.width+scalePadding)*i,0)];
        
        [totalPath appendPath:copyPath];
    }
    
    [totalPath applyTransform:CGAffineTransformMakeScale(scale,scale)];
    //修正当前的x,y值
    CGFloat refixY = (drawRect.size.height-totalPath.bounds.size.height)/2.0+drawRect.origin.y;
    CGFloat refixX;
    if (_alignment == AJScoreViewAlignmentRight) {
        refixX = drawRect.size.width - totalPath.bounds.size.width+drawRect.origin.x;
    }else{
        refixX = drawRect.origin.x;
    }
    [totalPath applyTransform:CGAffineTransformMakeTranslation(refixX,refixY)];
    [_unselectedColor setFill];
    [totalPath fill];
    
    //取值的范围
    CGFloat numberOfSharp = _value/((_maximumValue-_minimumValue)/_number);
    NSInteger integer = floor(numberOfSharp);
    CGFloat remainValue = numberOfSharp - integer;
    CGRect totoalPathBounds = totalPath.bounds;
    CGFloat selectW = (pathBounds.size.width*integer + scalePadding*integer + pathBounds.size.width*remainValue)*scale;
    CGRect selectRect;
    if (_alignment == AJScoreViewAlignmentRight){
        selectRect = CGRectMake(totoalPathBounds.origin.x, drawRect.origin.y+pathBounds.origin.y-0.5, totoalPathBounds.size.width-selectW, drawRect.size.height-2*pathBounds.origin.y+1.0);
    }else{
        selectRect = CGRectMake(selectW+totoalPathBounds.origin.x, drawRect.origin.y+pathBounds.origin.y-0.5, totoalPathBounds.size.width-selectW, drawRect.size.height-2*pathBounds.origin.y+1.0);
    }
    UIBezierPath* rectanglePath = [UIBezierPath bezierPathWithRect:selectRect];
    UIBezierPath* rectanglePath2 =[UIBezierPath bezierPath];
    [rectanglePath2 appendPath:rectanglePath];
    [totalPath appendPath:rectanglePath];
    [totalPath setUsesEvenOddFillRule:YES];
    [totalPath addClip];
    [totalPath appendPath:rectanglePath2];
    [totalPath setUsesEvenOddFillRule:YES];
    [totalPath addClip];
    [_selectedColor setFill];
    [totalPath fill];
    
}

#pragma mark - Setter methods
- (void)setFrame:(CGRect)frame{
    if (!CGRectEqualToRect(frame, self.frame)) {
        [super setFrame:frame];
        [self setNeedsDisplay];
    }
}

- (void)setType:(AJScoreViewSharpeType)type{
    if (_type != type) {
        _type = type;
        switch (_type) {
            case AJScoreViewStarType:
                [self setPath:[self obtainStarPath]];
                break;
            case AJScoreViewHeartType:
                [self setPath:[self obtainHeartPath]];
                break;
            default:
                break;
        }
        if (_type == AJScoreViewCustomType) {
            return;
        }
        [self setNeedsDisplay];
    }
    
}

- (void)setAlignment:(AJScoreViewAlignment)alignment{
    if (_alignment != alignment) {
        _alignment = alignment;
        [self setNeedsDisplay];
    }
}

- (void)setInsert:(UIEdgeInsets)insert{
    if (!UIEdgeInsetsEqualToEdgeInsets(insert, self.insert)) {
        _insert = insert;
        [self setNeedsDisplay];
    }
}

- (void)setPadding:(CGFloat)padding{
    if (_padding != padding && _type != AJScoreViewAlignmentCenter) {
        if (padding < 0) {
            _padding = 0;
        }else{
            _padding = padding;
        }
        [self setNeedsDisplay];
    }
}

- (void)setMinimumValue:(CGFloat)minimumValue{
    if (_minimumValue != minimumValue && minimumValue <= _maximumValue) {
        _minimumValue = minimumValue;
        [self setNeedsDisplay];
    }
    
}

- (void)setMaximumValue:(CGFloat)maximumValue{
    if (_maximumValue != maximumValue && maximumValue >= _minimumValue) {
        _maximumValue = maximumValue;
        [self setNeedsDisplay];
    }
}

- (void)setValue:(CGFloat)value{
    if (_value != value) {
        if (value<_minimumValue) {
            _value = _minimumValue;
        }else if(value > _maximumValue){
            _value = _maximumValue;
        }else{
            _value = value;
        }
        [self setNeedsDisplay];
    }
}

- (void)setNumber:(NSInteger)number{
    if (_number != number) {
        if (number < 1) {
            number = 1;
        }else{
            _number = number;
        }
        [self setNeedsDisplay];
    }
}

- (void)setSelectedColor:(UIColor *)selectedColor{
    if (![_selectedColor isEqual:selectedColor]) {
        _selectedColor = selectedColor;
        [self setNeedsDisplay];
    }
}

- (void)setUnselectedColor:(UIColor *)unselectedColor{
    if (![_unselectedColor isEqual:unselectedColor]) {
        _unselectedColor = unselectedColor;
        [self setNeedsDisplay];
    }
}

- (void)setPath:(UIBezierPath *)path{
    if (self.type == AJScoreViewCustomType) {
        _path = path;
        [self setNeedsDisplay];
    }
}

#pragma mark - getSharpPath methods
/**
 *  获取五角星的UIBezierPath对象
 *
 *  @return 五角星的UIBezierPath对象
 */
- (UIBezierPath *)obtainStarPath{
    
    UIBezierPath* starPath = UIBezierPath.bezierPath;
    [starPath moveToPoint: CGPointMake(2.5, 0)];
    [starPath addLineToPoint: CGPointMake(3.38, 1.29)];
    [starPath addLineToPoint: CGPointMake(4.88, 1.73)];
    [starPath addLineToPoint: CGPointMake(3.93, 2.96)];
    [starPath addLineToPoint: CGPointMake(3.97, 4.52)];
    [starPath addLineToPoint: CGPointMake(2.5, 4)];
    [starPath addLineToPoint: CGPointMake(1.03, 4.52)];
    [starPath addLineToPoint: CGPointMake(1.07, 2.96)];
    [starPath addLineToPoint: CGPointMake(0.12, 1.73)];
    [starPath addLineToPoint: CGPointMake(1.62, 1.29)];
    [starPath closePath];
    return starPath;
    
}

/**
 *  获取心形的UIBezierPath对象
 *
 *  @return 心形的UIBezierPath对象
 */
- (UIBezierPath *)obtainHeartPath{
    
    UIBezierPath *heartPath = [UIBezierPath bezierPath];
    [heartPath addArcWithCenter:CGPointMake(-1.0, 1.0) radius:1.0 startAngle:-M_PI endAngle:0 clockwise:YES];
    [heartPath addArcWithCenter:CGPointMake(1.0, 1.0) radius:1.0 startAngle:M_PI endAngle:0 clockwise:YES];
    [heartPath addQuadCurveToPoint:CGPointMake(0.0, 3.0) controlPoint:CGPointMake(1.8, 2.0)];
    [heartPath addQuadCurveToPoint:CGPointMake(-2.0, 1.0) controlPoint:CGPointMake(-1.8, 2.0)];
    [heartPath closePath];
    
    return heartPath;
    
}



@end
