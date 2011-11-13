package kom.bine {

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;

	public class Preloader extends MovieClip {

		public var screen : LoadingScreen = new LoadingScreen();

		public function Preloader() {
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			stage.addEventListener(Event.RESIZE, onStageResize);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);

			addChild(screen);
			onStageResize();
		}

		private function onStageResize(event : Event = null) : void {
			screen.x = stage.stageWidth / 2;
			screen.y = stage.stageHeight / 2;
		}

		private function onProgress(e : ProgressEvent) : void {
			screen.progressbar.scaleX = stage.loaderInfo.bytesLoaded / stage.loaderInfo.bytesTotal;
		}

		private function onEnterFrame(e : Event) : void {
			if (currentFrame == totalFrames) {
				stop();
				loadingFinished();
			}
		}

		private function loadingFinished() : void {
			removeEventListener(Event.ENTER_FRAME, onEnterFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			stage.removeEventListener(Event.RESIZE, onStageResize);

			removeChild(screen);
			stop();

			startup();
		}

		private function startup() : void {
			var mainClass : Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
	}
}