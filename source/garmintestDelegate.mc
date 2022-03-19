import Toybox.Lang;
import Toybox.System;
import Toybox.WatchUi;
import Toybox.ActivityRecording;
var session = null;


class PlayLayerView extends WatchUi.View {

    var myBitmap;

    function initialize() {
        View.initialize();
        myBitmap = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Monkey,
            :locX=>10,
            :locY=>30
        });
    }

    // Update the view
    function onUpdate(dc) {
        myBitmap.draw(dc);
    }
}

class ConfirmSaveDelegate extends WatchUi.ConfirmationDelegate {

    function initialize() {
        ConfirmationDelegate.initialize();
    }

    function onResponse(value) {
        if (value == CONFIRM_YES) {
            System.println("Saving Record");
            session.stop();                                      // stop the session
            session.save();                                      // save the session
            session = null;                                      // set session control variable to null
        }

        return true;
    }
}

class garmintestDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
       if (Toybox has :ActivityRecording) {                          // check device for activity recording
            if ((session == null) || (session.isRecording() == false)) {
//                WatchUi.pushView(new PlayLayerView());

                session = ActivityRecording.createSession({          // set up recording session
                        :name=>"Generic",                              // set session name
                        :sport=>ActivityRecording.SPORT_ALPINE_SKIING,       // set sport type
                        :subSport=>ActivityRecording.SUB_SPORT_GENERIC // set sub sport type
                });
                session.start();                                     // call start session
            }
            else if ((session != null) && session.isRecording()) {
                var message = "Save ?";
                WatchUi.pushView(
                    new WatchUi.Confirmation(message),
                    new ConfirmSaveDelegate(),
                    WatchUi.SLIDE_IMMEDIATE
                );
            }
        }
        return true; 
    }

    function onMenu() as Boolean {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new garmintestMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}