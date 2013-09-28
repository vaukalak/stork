/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/6/13
 * Time: 4:32 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
import org.osflash.signals.ISignal;

public interface IStorkTween {
    function start():void;

    function get duration():Number;

    function get currentTime():Number;

    function update(dt:Number):void;

    function get complete():ISignal;

    function get progress():ISignal;

    function get currentProgress():Number;

    function set currentProgress(value:Number):void;

    function pause():void;

    function resume():void;

    function stop():void;

    function dispose():void;

    function changeProperty(propertyName:String, changeFunction:Function):void;
}
}
