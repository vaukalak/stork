stork
=====

as3 tween engine

key features:

### fluent interface

```as3
new StorkTweenPackBuilder()
                .append(
                        new StorkTweenPackBuilder()
                                .insert(StorkTweenBuilder.from(image, 1, {alpha:0}))
                                .insert(StorkTweenBuilder.fromTo(image, 1, {x:-100}, {x:100}))
                )
                .append(StorkTweenBuilder.to(image, 1, {alpha:0}))
                .resolve();
```

### change properties on fly

If, for example, your application is resised. You can change properties of the tween on fly:

```as3
var scale:Number = stageWidth / _oldStageWidth;
storkTween.changeProperty("x", function (oldX:Number):Number {
    return  oldX * scale;
});
```

### time scaling

You can set you timescale for bot tween or tweenpack objects.

### friendly callback api

Thank's to fluet interface, the callback subscription becames very easy.

```as3
new StorkTweenPackBuilder()
  .append(StorkTweenBuilder.from(image, 1, {alpha:0}).onComplete(trace, ["image appeared"]))
  .append(StorkTweenBuilder.from(image, 1, {x:100, y:100}).onComplete(trace, ["image position tweened"]))
  .onComplete(trace, ["all tweens completed"])
  .resolve();
```

Note: you can refference "onComplete" and other callback api methods many times.

### custom progress controll

Using "currentProgress" property of IStorkTween interface, you can specify the current progrees of the tween manualy.
It doesn't metter if you change progress of tween or of tween pack.

### starling oriented

Stork tween engine works wraps standart starling tweens.
