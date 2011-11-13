package kom.bine {

	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;

	import ru.oceanit.StartScreen;

	public class Preloader extends MovieClip {

		public var screen : StartScreen = new StartScreen();

		public function Preloader() {
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}

			addEventListener(Event.ENTER_FRAME, onEnterFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);

			addChild(screen);
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