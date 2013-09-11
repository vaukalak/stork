/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/6/13
 * Time: 3:42 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
import starling.animation.Transitions;
import starling.animation.Tween;

public class StorkTween extends AbstractStorkTween {

    private var _tween:Tween;
    private var _properties:Object;

    public function StorkTween(target:Object, time:Number, properties:Object, transition:String = "") {
        _properties = properties;
        _tween = new Tween(target, time, transition || Transitions.LINEAR);
        for (var propertyName:String in _properties) {
            _tween.animate(propertyName, _properties[propertyName]);
        }
        _tween.onUpdate = progress.dispatch;
    }

    public function set delay(delay:Number):void {
        _tween.delay = delay;
    }

    public function get delay():Number {
        return _tween.delay;
    }

    public function set easing(value:String):void {
        _tween.transition = value;
    }

    public function get easing():String {
        return _tween.transition;
    }

    override public function get duration():Number {
        return _tween.totalTime;
    }

    override public function update(dt:Number):void {
        _tween.advanceTime(dt);
        if (_tween.currentTime >= _tween.currentTime) {
            dispose();
            complete.dispatch();
        }
    }
}
}
