/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/6/13
 * Time: 4:31 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
import flash.utils.Dictionary;

public class StorkTweenPack extends AbstractStorkTween {

    public var timeScale:Number;
    private var _duration:Number;

    private const _allTweens:Vector.<IStorkTween> = new Vector.<IStorkTween>();
    private const _delayByTween:Dictionary = new Dictionary();
    private var _currentTime:Number;
    private var _activeTweens:Vector.<IStorkTween> = new <IStorkTween>[];
    private var _tweenStarted:Boolean;

    public function StorkTweenPack() {
        timeScale = 1;
        _currentTime = 0;
        _duration = 0;
    }

    override public function update(dt:Number):void {
        if (!_tweenStarted) {
            _tweenStarted = true;
            started.dispatch();
        }
        var scaledDt:Number = dt * timeScale;
        var newTotalTime:Number = Math.max(Math.min(_currentTime + scaledDt, _duration), 0);
        var activeTweensClone:Vector.<IStorkTween> = _activeTweens.concat();

        for each (var storkTween:IStorkTween in  activeTweensClone) {
            storkTween.update(scaledDt);
        }
        for (var tween:* in _delayByTween) {
            var tweenStartTime:Number = _delayByTween[tween];
            if (dt >= 0) {
                if (tweenStartTime >= _currentTime && tweenStartTime <= newTotalTime) {
                    addActiveTween(tween, newTotalTime - tweenStartTime);
                }
            } else {
                var tweenEndTime:Number = tweenStartTime + tween.duration;
                if (tweenEndTime <= _currentTime && tweenEndTime >= newTotalTime) {
                    addActiveTween(tween, newTotalTime - tweenEndTime);
                }
            }
        }
        progress.dispatch();
        _currentTime = newTotalTime;
        if (_currentTime >= _duration || _currentTime <= 0) {
            dispose();
            complete.dispatch();
        }
    }

    private function addActiveTween(tween:IStorkTween, dt:Number):void {
        if (_activeTweens.indexOf(tween) != -1) {
            return;
        }
        _activeTweens.push(tween);
        tween.complete.addOnce(new ParametrisedListener(onTweenComplete, [tween]).invoke);
        tween.update(dt);
    }

    override public function get currentTime():Number {
        return _currentTime;
    }

    private function onTweenComplete(tween:IStorkTween):void {
        var indexOf:Number = _activeTweens.indexOf(tween);
        _activeTweens.splice(indexOf, 1);
    }

    public function insert(value:IStorkTween, delay:Number):void {
        if (delay < 0 || isNaN(delay)) {
            delay = 0;
        }
        _duration = Math.max(delay + value.duration, _duration);
        _delayByTween[value] = delay;
        _allTweens.push(value);
    }

    override public function get duration():Number {
        return _duration;
    }


    override public function changeProperty(propertyName:String, changeFunction:Function):void {
        for each (var storkTween:IStorkTween in _allTweens) {
            storkTween.changeProperty(propertyName, changeFunction);
        }
    }
}
}
