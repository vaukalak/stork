/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/11/13
 * Time: 4:47 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

import starling.core.Starling;

public class AbstractStorkTween implements IStorkTween {

    private const _complete:ISignal = new Signal();
    private const _progress:ISignal = new Signal();

    private var _advanceTimeDispatcher:AdvanceTimeDispatcher;

    public function start():void {
        _advanceTimeDispatcher = new AdvanceTimeDispatcher(update);
        Starling.current.juggler.add(_advanceTimeDispatcher);
    }

    protected function dispose():void {
        Starling.current.juggler.remove(_advanceTimeDispatcher);
    }

    public function get duration():Number {
        return 0;
    }

    public function update(dt:Number):void {
    }

    public function get complete():ISignal {
        return _complete;
    }

    public function get progress():ISignal {
        return _progress;
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