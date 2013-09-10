/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/10/13
 * Time: 5:22 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
public class ParametrisedListener {

    private var _callback:Function;
    private var _params:Array;

    public function ParametrisedListener(callback:Function, params:Array) {
        _callback = callback;
        _params = params;
    }

    public function invoke(...rest):void {
        _callback.apply(null, _params);
    }

}
}
