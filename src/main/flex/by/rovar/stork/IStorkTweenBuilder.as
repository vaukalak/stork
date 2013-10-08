/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/6/13
 * Time: 5:14 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
public interface IStorkTweenBuilder {
    function resolve(autostart:Boolean = true):IStorkTween;

    function onComplete(value:Function, params:Array = null):IStorkTweenBuilder;

    function onStart(value:Function, params:Array = null):IStorkTweenBuilder;
}
}
