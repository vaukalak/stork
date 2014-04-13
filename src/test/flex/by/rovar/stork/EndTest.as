package by.rovar.stork {
	import flexunit.framework.Assert;

	public class EndTest{

		private var _completeDispatched:Boolean = false;

		[Test]
		public function testCallback() : void {
			var obj:Object = {x:100};
			var iStorkTween : IStorkTween = StorkTweenBuilder.to(obj, 0.1, {x : 50}).resolve(false);
			iStorkTween.complete.add(onComplete);
			iStorkTween.end();
			Assert.assertEquals(50, obj.x);
			Assert.assertTrue(_completeDispatched);
		}

		private function onComplete() : void {
			_completeDispatched = true;
		}

	}
}
