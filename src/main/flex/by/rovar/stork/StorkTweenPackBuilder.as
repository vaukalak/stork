/**
 * Created with IntelliJ IDEA.
 * User: vaukalak
 * Date: 9/6/13
 * Time: 4:44 PM
 * To change this template use File | Settings | File Templates.
 */
package by.rovar.stork {
public class StorkTweenPackBuilder implements IStorkTweenBuilder{

    private var _storkTweenPack:StorkTweenPack;

    public function StorkTweenPackBuilder() {
        _storkTweenPack = new StorkTweenPack();
    }

    public function append(tween:IStorkTweenBuilder, delay:Number = 0):StorkTweenPackBuilder {
        _storkTweenPack.insert(tween.resolve(false), _storkTweenPack.duration + delay);
        return this;
    }

    public function insert(tween:IStorkTweenBuilder, delay:Number = 0):StorkTweenPackBuilder {
        _storkTweenPack.insert(tween.resolve(false), delay);
        return this;
    }

    public function resolve(autostart:Boolean = true):IStorkTween {
        if(autostart){
            _storkTweenPack.start();
        }
        return _storkTweenPack;
    }
}
}
