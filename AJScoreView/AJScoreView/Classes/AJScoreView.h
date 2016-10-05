//
//  AJScoreView.h
//  Pods
//
//  Created by Aijun on 16/10/4.
//
//

#import <UIKit/UIKit.h>

/**
 评分组件类型，默认为星形
 */
typedef enum {
    AJScoreViewStarType = 1,    //星形
    AJScoreViewHeartType,   //心型
    AJScoreViewCustomType       //自定义类型
}AJScoreViewSharpeType;

/**
 评分组件左右对齐方式
 */
typedef enum {
    AJScoreViewAlignmentCenter = 1,    //居中
    AJScoreViewAlignmentLeft,   //居左
    AJScoreViewAlignmentRight,   //居右
}AJScoreViewAlignment;


@interface AJScoreView : UIView

/**
 *  评分组件的类型
 */
@property (nonatomic, assign)  AJScoreViewSharpeType type;
/**
 *  评分组件的对齐方式
 */
@property (nonatomic, assign)  AJScoreViewAlignment alignment;
/**
 *  评分组件四周的间隙
 */
@property (nonatomic, assign) UIEdgeInsets insert;
/**
 *  各个形状之间的间隙，必须大于0.1，默认为2.0。如果对齐方式为AJScoreViewAlignmentCenter，则此设置无效
 */
@property (nonatomic, assign) CGFloat padding;
/**
 *  评分组件是否可以点击编辑，默认为NO
 */
@property (nonatomic, assign) BOOL editing;
/**
 *  评分组件的最小值，minimumValue的值不能大于maximumValue
 */
@property (nonatomic, assign) CGFloat minimumValue;
/**
 *  评分组件的最大值，maximumValue的值不能小于minimumValue
 */
@property (nonatomic, assign) CGFloat maximumValue;
/**
 *  评分组件的当前值
 */
@property (nonatomic, assign) CGFloat value;
/**
 *  评分组件的显示个数，number必须大于1
 */
@property (nonatomic, assign) NSInteger number;
/**
 *  取值的颜色
 */
@property (nonatomic, strong) UIColor *selectedColor;
/**
 *  未取值的颜色
 */
@property (nonatomic, strong) UIColor *unselectedColor;
/**
 *    当类型为AJScoreViewCustomType类型的时候，可以通过path赋予不同的形状，如果是星星或心型则会使用自带的path。并且只有先赋值type为AJScoreViewCustomType才能赋值path，否则赋值无效。建议使用PaintCode来画图生成Object-C代码。
 */
@property (nonatomic, strong) UIBezierPath *path;

/**
 *  设置评分组件的值
 *
 *  @param value    评分值
 *  @param animated 改变值是否有动画,YES则显示动画，动画时间0.3秒
 */
- (void)setValue:(CGFloat)value animated:(BOOL)animated;


@end
