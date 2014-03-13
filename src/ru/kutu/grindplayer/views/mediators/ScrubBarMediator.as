package ru.kutu.grindplayer.views.mediators {
	
	import org.osmf.net.StreamType;
	
	import ru.kutu.grind.views.mediators.ScrubBarBaseMediator;
	
	public class ScrubBarMediator extends ScrubBarBaseMediator {
		
		
		override public function initialize():void {
			super.initialize();
		}
		
		override protected function updateEnabled():void {
			view.enabled = isStartPlaying;
			view.visible = streamType != StreamType.LIVE;
		}
		
	
	}
	
}
