/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/6/13
 * Time: 4:32 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
public interface IStorkTween {
    function start():void;
    function get duration():Number;

    function update(dt:Number):void;
}
}
