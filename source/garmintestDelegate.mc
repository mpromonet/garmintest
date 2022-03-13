import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.ActivityRecording;
var session = null;

class garmintestDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
       if (Toybox has :ActivityRecording) {                          // check device for activity recording
            if ((session == null) || (session.isRecording() == false)) {
                session = ActivityRecording.createSession({          // set up recording session
                        :name=>"Generic",                              // set session name
                        :sport=>ActivityRecording.SPORT_GENERIC,       // set sport type
                        :subSport=>ActivityRecording.SUB_SPORT_GENERIC // set sub sport type
                });
                session.start();                                     // call start session
            }
            else if ((session != null) && session.isRecording()) {
                session.stop();                                      // stop the session
                session.save();                                      // save the session
                session = null;                                      // set session control variable to null
            }
        }
        return true; 
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new garmintestMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}