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

    private var _duration:Number;

    private const _delayByTween:Dictionary = new Dictionary();
    private var _totalTime:Number;
    private var _activeTweens:Vector.<IStorkTween> = new <IStorkTween>[];

    public function StorkTweenPack() {
        _totalTime = 0;
        _duration = 0;
    }

    override public function update(dt:Number):void {
        var newTotalTime:Number = _totalTime + dt;
        for each (var storkTween:IStorkTween in _activeTweens) {
            storkTween.update(dt);
        }
        for (var tween:* in _delayByTween) {
            var tweenStartTime:* = _delayByTween[tween];
            if (tweenStartTime >= _totalTime && tweenStartTime < newTotalTime) {
                (tween as IStorkTween).update(tweenStartTime - _totalTime);
                _activeTweens.push(tween);
            }
        }
        _totalTime = newTotalTime;
        if (_totalTime > _duration) {
            dispose();
            complete.dispatch();
        }
    }

    public function insert(value:IStorkTween, delay:Number):void {
        if (delay < 0) {
            delay = 0;
        }
        _duration = Math.max(delay + value.duration, _duration);
        _delayByTween[value] = delay;
    }

    override public function get duration():Number {
        return _duration;
    }
}
}
