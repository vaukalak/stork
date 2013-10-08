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
    private const _propertiesOnStart:Object = {};
    private var _tweenStarted:Boolean;

    public function StorkTween(target:Object, time:Number, properties:Object, transition:String = "") {
        _properties = properties;
        _tween = new Tween(target, time, transition || Transitions.LINEAR);
        for (var propertyName:String in _properties) {
            _tween.animate(propertyName, _properties[propertyName]);
        }
        _tween.onUpdate = progress.dispatch;
    }

    override public function reset():void {
        _tween.reset(_tween.target, _tween.totalTime, _tween.transition);
        for (var propertyName:String in _properties) {
            if (_propertiesOnStart[propertyName]) {
                _tween.target[propertyName] = _propertiesOnStart[propertyName];
            }
            _tween.animate(propertyName, _properties[propertyName]);
        }
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

    override public function get currentTime():Number {
        return _tween.currentTime;
    }

    override public function update(dt:Number):void {
        if (!_tweenStarted) {
            for (var propertyName:String in _properties) {
                _propertiesOnStart[propertyName] = _tween.target[propertyName];
            }
            _tweenStarted = true;
            started.dispatch();
        }
        if (_tween.totalTime == _tween.currentTime && dt < 0) {
            reset();
            _tween.advanceTime(_tween.totalTime + dt);
        } else {
            if (dt > 0) {
                _tween.advanceTime(dt);
            } else {
                if (-dt > _tween.currentTime) {
                    _tween.advanceTime(-_tween.currentTime);
                    for (var propertyName:String in _propertiesOnStart) {
                        _tween.target[propertyName] = _propertiesOnStart[propertyName];
                    }
                } else {
                    _tween.advanceTime(dt);
                }
            }
        }
        if (_tween.currentTime <= 0 || _tween.currentTime >= _tween.totalTime) {
            dispose();
            complete.dispatch();
        }
    }

    override public function changeProperty(propertyName:String, changeFunction:Function):void {
        var oldTime:Number = _tween.currentTime;
        doChangeProperties(propertyName, changeFunction);
        reset();
        _tween.advanceTime(oldTime);
    }

    private function doChangeProperties(propertyName:String, changeFunction:Function):void {
        if (_propertiesOnStart[propertyName]) {
            _propertiesOnStart[propertyName] = changeFunction(_propertiesOnStart[propertyName]);
        }
        if (_properties[propertyName]) {
            _properties[propertyName] = changeFunction(_properties[propertyName]);
            _tween.target[propertyName] = changeFunction(_tween.target[propertyName]);
        }
    }
}
}
