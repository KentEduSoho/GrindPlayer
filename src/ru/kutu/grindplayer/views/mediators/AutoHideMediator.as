package ru.kutu.grindplayer.views.mediators {
	
	import ru.kutu.grind.views.mediators.AutoHideBaseMediator;
	
	public class AutoHideMediator extends AutoHideBaseMediator {
		
		private var isAdvertisement:Boolean;
		
		override public function initialize():void {
			super.initialize();
		}
		
		override protected function checkVisibility():void {
			visible =
				isReady
				&&
				(
					(!isPlaying && !isAdvertisement)
					||
					hasWaitTarget
					||
					(!isFullScreen && !isMouseLeave && !isAutoHideComplete)
					||
					(isFullScreen && isMouseMove && !isAutoHideComplete)
				);
			
			if (_visible) {
				resetAutoHideTimer();
			}
		}

		
	}
	
}
