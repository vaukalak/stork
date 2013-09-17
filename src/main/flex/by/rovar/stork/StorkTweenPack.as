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

    private const _delayByTween:Dictionary = new Dictionary();
    private var _totalTime:Number;
    private var _activeTweens:Vector.<IStorkTween> = new <IStorkTween>[];

    public function StorkTweenPack() {
        timeScale = 1;
        _totalTime = 0;
        _duration = 0;
    }

    override public function update(dt:Number):void {
        var scaledDt:Number = dt * timeScale;
        var newTotalTime:Number = _totalTime + scaledDt;
        var activeTweensClone:Vector.<IStorkTween> = _activeTweens.concat();
        for each (var storkTween:IStorkTween in  activeTweensClone) {
            storkTween.update(scaledDt);
        }
        for (var tween:* in _delayByTween) {
            var tweenStartTime:* = _delayByTween[tween];
            if (tweenStartTime >= _totalTime && tweenStartTime < newTotalTime) {
                _activeTweens.push(tween);
                tween.complete.add(new ParametrisedListener(onTweenComplete, [tween]).invoke);
                (tween as IStorkTween).update(newTotalTime - tweenStartTime);
            }
        }
        _totalTime = newTotalTime;
        if (_totalTime >= _duration) {
            dispose();
            complete.dispatch();
        }
    }


    override protected function dispose():void {
        super.dispose();
        for (var tween:* in _delayByTween) {
            delete _delayByTween[tween];
        }
    }

    private function onTweenComplete(tween:IStorkTween):void {
        var indexOf:Number = _activeTweens.indexOf(tween);
        _activeTweens.splice(indexOf, 1);
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
