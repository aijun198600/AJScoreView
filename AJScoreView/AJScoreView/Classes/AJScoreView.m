//
//  AJScoreView.m
//  Pods
//
//  Created by Aijun on 16/10/4.
//
//

#import "AJScoreView.h"

@implementation AJScoreView {
    
    CAShapeLayer *unSelectedLayer;
    CAShapeLayer *selectedLayer;
    CALayer *maskLayer;
    
    CGRect totoalPathBounds;
    CGRect scaleRect;
    CGFloat realPadding;
    
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
    
    //默认不可编辑状态
    self.enabled = NO;
    
    _minimumValue = _minimumValue?_minimumValue:0.0;
    _maximumValue = _maximumValue?_maximumValue:5.0;
    _value = _value?_value:_minimumValue;
    _number = _number?_number:5;
    _padding = _padding?_padding:2.0;
    _insert = UIEdgeInsetsMake(2, 2, 2, 2);
    _type = _type?_type:AJScoreViewStarType;
    _path = _path?_path:[self obtainStarPath];
    _alignment = _alignment?_alignment:AJScoreViewAlignmentLeft;
    _selectedFillColor = _selectedFillColor?_selectedFillColor:[UIColor yellowColor];
    _unselectedFillColor = _unselectedFillColor?_unselectedFillColor:[UIColor grayColor];
    _borderWidth = _borderWidth?_borderWidth:0.0;
    
    unSelectedLayer = [CAShapeLayer layer];
    selectedLayer = [CAShapeLayer layer];
    maskLayer = [CALayer layer];
    maskLayer.backgroundColor = [UIColor blackColor].CGColor;
    
    [self.layer addSublayer:selectedLayer];
    [self.layer addSublayer:unSelectedLayer];
    
    [self setNeedsLayout];
    
}

#pragma mark - Layout subviews 
- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    CGRect pathBounds = _path.bounds;
    
    //确定绘图区域
    CGRect rect = self.bounds;
    CGRect drawRect = CGRectMake(_insert.left,_insert.top, rect.size.width -(_insert.left + _insert.right), rect.size.height - (_insert.top + _insert.bottom));
    if (_padding * (_number - 1) >= drawRect.size.width) {
        return;
    }
    
    //缩放百分比
    realPadding = _padding + 2 * _borderWidth;
    CGFloat scale;
    if ((drawRect.size.width - (_number - 1) * realPadding) / pathBounds.size.width / _number > (drawRect.size.height / pathBounds.size.height)) {
        scale = drawRect.size.height / pathBounds.size.height;
    }else{
        scale = (drawRect.size.width - (_number - 1) * realPadding) / pathBounds.size.width / _number;
    }
    if (_alignment == AJScoreViewAlignmentCenter) {
        realPadding = (drawRect.size.width - pathBounds.size.width * scale * _number) / (_number - 1);
    }
    
    //复制平移操作
    UIBezierPath *scalePath = [UIBezierPath bezierPath];
    [scalePath appendPath:_path];
    [scalePath applyTransform:CGAffineTransformMakeScale(scale,scale)];
    scaleRect = scalePath.bounds;
    
    UIBezierPath *totalPath = [UIBezierPath bezierPath];
    for (int i=0; i<_number; i++) {
        
        UIBezierPath *copyPath = [UIBezierPath bezierPath];
        [copyPath appendPath:scalePath];
        [copyPath applyTransform:CGAffineTransformMakeTranslation((scaleRect.size.width+realPadding)*i,0)];
        [totalPath appendPath:copyPath];
    }
    
    //修正origin的x，y值, 使path位置居中
    CGRect totalPathRect = totalPath.bounds;
    CGFloat x;
    if (_alignment == AJScoreViewAlignmentRight) {
        x = drawRect.origin.x + drawRect.size.width - totalPathRect.origin.x - totalPathRect.size.width;
    }else {
        x = drawRect.origin.x - totalPathRect.origin.x;
    }
    CGFloat y = (drawRect.size.height - totalPathRect.size.height) / 2.0 + drawRect.origin.y;
    y = y - totalPathRect.origin.y;
    [totalPath applyTransform:CGAffineTransformMakeTranslation(x, y)];
    totoalPathBounds = totalPath.bounds;
    
    //确定背景颜色
    unSelectedLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    unSelectedLayer.path = totalPath.CGPath;
    unSelectedLayer.fillColor = _unselectedFillColor.CGColor;

    selectedLayer.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    selectedLayer.path = totalPath.CGPath;
    selectedLayer.fillColor = _selectedFillColor.CGColor;
    
    if (_borderWidth > 0.0) {
        unSelectedLayer.strokeColor = _unselectedBorderColor.CGColor;
        unSelectedLayer.lineWidth = _borderWidth;
        selectedLayer.strokeColor = _selectedBorderColor.CGColor;
        selectedLayer.lineWidth = _borderWidth;
    }
    
    //确定遮罩层的大小
    [self updateMaskLayersWithAnimation:NO];
    
}

- (void)updateMaskLayersWithAnimation:(BOOL)animation {
    
    CGFloat numberOfSharp = _value/((_maximumValue-_minimumValue)/_number);
    NSInteger integer = floor(numberOfSharp);
    CGFloat remainValue = numberOfSharp - integer;
    CGFloat selectW = scaleRect.size.width*integer + realPadding*integer + scaleRect.size.width*remainValue;
    CGRect selectRect;
    if (_alignment == AJScoreViewAlignmentRight){
        selectRect = CGRectMake(totoalPathBounds.origin.x, 0, totoalPathBounds.size.width-selectW, self.bounds.size.height);
    }else{
        selectRect = CGRectMake(selectW+totoalPathBounds.origin.x, 0, totoalPathBounds.size.width-selectW, self.bounds.size.height);
    }
    
    if (animation) {
        [CATransaction setDisableActions:NO];
    }else {
        [CATransaction setDisableActions:YES];
    }
    
    maskLayer.frame = selectRect;
    unSelectedLayer.mask = maskLayer;
    
}

#pragma mark - Setter methods
- (void)setFrame:(CGRect)frame{
    if (!CGRectEqualToRect(frame, self.frame)) {
        [super setFrame:frame];
        [self setNeedsLayout];
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
        [self setNeedsLayout];
    }
    
}

- (void)setAlignment:(AJScoreViewAlignment)alignment{
    if (_alignment != alignment) {
        _alignment = alignment;
        [self setNeedsLayout];
    }
}

- (void)setInsert:(UIEdgeInsets)insert{
    if (!UIEdgeInsetsEqualToEdgeInsets(insert, self.insert)) {
        _insert = insert;
        [self setNeedsLayout];
    }
}

- (void)setPadding:(CGFloat)padding{
    if (_padding != padding && _alignment != AJScoreViewAlignmentCenter) {
        if (padding < 0) {
            _padding = 0;
        }else{
            _padding = padding;
        }
        [self setNeedsLayout];
    }
}

- (void)setMinimumValue:(CGFloat)minimumValue{
    if (_minimumValue != minimumValue && minimumValue <= _maximumValue) {
        _minimumValue = minimumValue;
        [self updateMaskLayersWithAnimation:NO];
    }
    
}

- (void)setMaximumValue:(CGFloat)maximumValue{
    if (_maximumValue != maximumValue && maximumValue >= _minimumValue) {
        _maximumValue = maximumValue;
        [self updateMaskLayersWithAnimation:NO];
    }
}

- (void)updateValue:(CGFloat)value {
    if (value<_minimumValue) {
        _value = _minimumValue;
    }else if(value > _maximumValue){
        _value = _maximumValue;
    }else{
        _value = value;
    }
}

- (void)setValue:(CGFloat)value{
    if (_value != value) {
        [self updateValue:value];
        [self updateMaskLayersWithAnimation:NO];
    }
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated{
    if(_value != value){
        if (animated) {
            [self updateValue:value];
            [self updateMaskLayersWithAnimation:YES];
        }else{
            [self setValue:value];
        }
    }
}


- (void)setNumber:(NSInteger)number{
    if (_number != number) {
        if (number < 1) {
            number = 1;
        }else{
            _number = number;
        }
        [self setNeedsLayout];
    }
}

- (void)setSelectedFillColor:(UIColor *)selectedColor{
    if (![_selectedFillColor isEqual:selectedColor]) {
        _selectedFillColor = selectedColor;
        selectedLayer.fillColor = _selectedFillColor.CGColor;
    }
}

- (void)setUnselectedFillColor:(UIColor *)unselectedColor{
    if (![_unselectedFillColor isEqual:unselectedColor]) {
        _unselectedFillColor = unselectedColor;
        unSelectedLayer.fillColor = _unselectedFillColor.CGColor;
    }
}

- (void)setSelectedBorderColor:(UIColor *)selectedBorderColor{
    if (![_selectedBorderColor isEqual:selectedBorderColor]) {
        _selectedBorderColor = selectedBorderColor;
        selectedLayer.strokeColor = _selectedBorderColor.CGColor;
    }
}

- (void)setUnselectedBorderColor:(UIColor *)unselectedBorderColor{
    if (![_unselectedBorderColor isEqual:unselectedBorderColor]) {
        _unselectedBorderColor = unselectedBorderColor;
        unSelectedLayer.strokeColor = _unselectedBorderColor.CGColor;
    }
}

- (void)setBorderWidth:(CGFloat)borderWidth {
    if (_borderWidth != borderWidth) {
        _borderWidth = borderWidth;
        [self setNeedsLayout];
    }
}

- (void)setPath:(UIBezierPath *)path{
    _path = path;
    [self setNeedsLayout];
}

#pragma mark - Eevent handle
- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super beginTrackingWithTouch:touch withEvent:event];
    [self moveHandle:touch];
    return self.enabled;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super continueTrackingWithTouch:touch withEvent:event];
    [self moveHandle:touch];
    return self.enabled;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
    [super endTrackingWithTouch:touch withEvent:event];
}

- (void)moveHandle:(UITouch *)touch {
    
    if (self.enabled == YES) {
        
        CGPoint point = [touch locationInView:self];
        if (CGRectContainsPoint(self.bounds, point)) {
            CGFloat selectW;
            if (_alignment == AJScoreViewAlignmentRight) {
                if (point.x <= totoalPathBounds.origin.x) {
                    selectW = totoalPathBounds.size.width;
                }else if (point.x >= totoalPathBounds.origin.x + totoalPathBounds.size.width) {
                    selectW = 0.0;
                }else {
                    selectW = totoalPathBounds.origin.x + totoalPathBounds.size.width - point.x;
                }
            }else {
                if (point.x <= totoalPathBounds.origin.x) {
                    selectW = 0.0;
                }else if (point.x >= totoalPathBounds.origin.x + totoalPathBounds.size.width) {
                    selectW = totoalPathBounds.size.width;
                }else {
                    selectW = point.x - totoalPathBounds.origin.x;
                }
            }
            
            NSInteger i = floor(selectW / (scaleRect.size.width + realPadding));
            CGFloat remainValue = (selectW - i * (scaleRect.size.width + realPadding)) / scaleRect.size.width;
            CGFloat value = i + remainValue;
            if (value != _value) {
                self.value = i + remainValue;
                [self sendActionsForControlEvents:UIControlEventValueChanged];
            }
            
        }
        
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
