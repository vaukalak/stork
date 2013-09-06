/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/6/13
 * Time: 3:42 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
import org.osflash.signals.ISignal;
import org.osflash.signals.Signal;

public class StorkTween {

    public const complete:ISignal = new Signal();
    public const progress:ISignal = new Signal();

    public function StorkTween(_target:Object, time:Number) {
    }
}
}
