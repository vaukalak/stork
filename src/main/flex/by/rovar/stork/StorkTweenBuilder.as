/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/6/13
 * Time: 4:07 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
public class StorkTweenBuilder implements IStorkTweenBuilder{

    private var _tween:StorkTween;

    //---------------------------------
    //
    //  NEW INSTANCE CREATION
    //
    //---------------------------------

    public static function to(target:Object, time:Number, properties:Object):StorkTweenBuilder {
        var result:StorkTweenBuilder = new StorkTweenBuilder();
        result._tween = new StorkTween(target, time, properties);
        return result;
    }

    public static function from(target:Object, time:Number, properties:Object):StorkTweenBuilder {
        var targetProperties:Object = {};
        for (var propertyName:String in properties) {
            targetProperties[propertyName] = target[propertyName];
            target[propertyName] = properties[propertyName];
        }
        return to(target, time, targetProperties);
    }

    //---------------------------------
    //
    //  PUBLIC METHODS
    //
    //---------------------------------

    public function delay(value:Number):StorkTweenBuilder {
        _tween.delay = value;
        return this;
    }

    public function ease(value:String):StorkTweenBuilder {
        _tween.easing = value;
        return this;
    }

    public function resolve(autostart:Boolean = true):IStorkTween {
        if (autostart) {
            _tween.start();
        }
        return _tween;
    }

}
}
