import Toybox.Lang;
import Toybox.WatchUi;

class garmintestDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new garmintestMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}