/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/6/13
 * Time: 4:31 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
import flash.utils.Dictionary;

import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.core.Starling;

public class StorkTweenPack implements IStorkTween {

    private const _complete:ISignal = new Signal();
    private const _progress:ISignal = new Signal();

    private var _duration:Number;
    private var _advanceTimeDispatcher:AdvanceTimeDispatcher;
    private const _delayByTween:Dictionary = new Dictionary();
    private var _totalTime:Number;
    private var _onCompleteParams:Array;

    public function StorkTweenPack() {
        _totalTime = 0;
        _duration = 0;
        _advanceTimeDispatcher = new AdvanceTimeDispatcher(update);
    }

    public function update(dt:Number):void {
        var newTotalTime:Number = _totalTime + dt;
        for (var tween:* in _delayByTween) {
            var tweenStartTime:* = _delayByTween[tween];
            if (tweenStartTime >= _totalTime && tweenStartTime < newTotalTime) {
                (tween as IStorkTween).start();
                (tween as IStorkTween).update(tweenStartTime - _totalTime);
            }
        }
        _totalTime = newTotalTime;
        if(_totalTime > _duration) {
            Starling.current.juggler.remove(_advanceTimeDispatcher);
            _complete.dispatch.apply(null, _onCompleteParams || []);
        }
    }

    public function insert(value:IStorkTween, delay:Number):void {
        if (delay < 0) {
            delay = 0;
        }
        _duration = Math.max(delay + value.duration, _duration);
        _delayByTween[value] = delay;
    }

    public function start():void {
        Starling.current.juggler.add(_advanceTimeDispatcher);
    }

    public function get duration():Number {
        return _duration;
    }

    public function get complete():ISignal {
        return _complete;
    }

    public function get progress():ISignal {
        return _progress;
    }

    public function get onCompleteParams():Array {
        return _onCompleteParams;
    }

    public function set onCompleteParams(value:Array):void {
        _onCompleteParams = value;
    }
}
}

import starling.animation.IAnimatable;

class AdvanceTimeDispatcher implements IAnimatable {

    private var _callback:Function;


    public function AdvanceTimeDispatcher(callback:Function) {
        _callback = callback;
    }

    public function advanceTime(time:Number):void {
        _callback(time);
    }
}
