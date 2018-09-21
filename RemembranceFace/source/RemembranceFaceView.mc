using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;
using Toybox.ActivityMonitor as Monitor;
using Toybox.Time as Time;

class RemembranceFaceView extends Ui.WatchFace {
    var background;
    var originX;
    var originY;
    var poppy;

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
        var deviceSettings = Sys.getDeviceSettings();
        var screenShape = deviceSettings.screenShape;
        originX = (dc.getWidth()-250)/2;
        originY = (dc.getHeight()-250)/2;
        if(screenShape == Sys.SCREEN_SHAPE_RECTANGLE){
            originY = originY - 15;
        }
        background = new WatchUi.Bitmap({
            :rezId=>Rez.Drawables.Background,
            :locX=>originX,
            :locY=>originY
        });
        poppy = Ui.loadResource(Rez.Drawables.Poppy);
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
        var now = Time.Gregorian.info(Time.now(), Time.FORMAT_SHORT);
        var today = now.day;
        // Get the current time and format it correctly
        var timeFormat = "$1$:$2$";
        var clockTime = Sys.getClockTime();
        var hours = clockTime.hour;
        if (!Sys.getDeviceSettings().is24Hour) {
            if (hours > 12) {
                hours = hours - 12;
            }
            if (hours == 0) {
                hours = 12;
            }
        } else {
            if (App.getApp().getProperty("UseMilitaryFormat")) {
                timeFormat = "$1$$2$";
                hours = hours.format("%02d");
            }
        }
        var timeString = Lang.format(timeFormat, [hours, clockTime.min.format("%02d")]);

        background.draw(dc);
        drawPoppies(dc);
        dc.setColor(Gfx.COLOR_DK_RED, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth()/2 - 20, dc.getHeight()/2 - 50, Gfx.FONT_NUMBER_MEDIUM, timeString, Gfx.TEXT_JUSTIFY_RIGHT);
        if(!Sys.getDeviceSettings().is24Hour){
            var ampm = "am";
            if(clockTime.hour >= 12 && clockTime.hour < 24){
                ampm = "pm";
            }
            dc.drawText(dc.getWidth()/2 - 19, dc.getHeight()/2 - 50 + Gfx.getFontHeight(Gfx.FONT_NUMBER_MEDIUM)/2, Gfx.FONT_TINY, ampm, Gfx.TEXT_JUSTIFY_LEFT);
        }
        dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_TRANSPARENT);
        dc.drawText(dc.getWidth() - 5, dc.getHeight()/2 - Gfx.getFontHeight(Gfx.FONT_TINY)/2, Gfx.FONT_TINY, today, Gfx.TEXT_JUSTIFY_RIGHT);
    }
    
    function drawPoppies(dc){
        //one by one
        var info = Monitor.getInfo();
        if(info.steps >= info.stepGoal * 12 / 12){
            dc.drawBitmap(originX + 146, originY + 135, poppy);
        }
        if(info.steps >= info.stepGoal * 11 / 12){
            dc.drawBitmap(originX + 135, originY + 134, poppy);
        }
        if(info.steps >= info.stepGoal * 10 / 12){
            dc.drawBitmap(originX + 125, originY + 133, poppy);
        }
        if(info.steps >= info.stepGoal * 9 / 12){
            dc.drawBitmap(originX + 114, originY + 133, poppy);
        }
        if(info.steps >= info.stepGoal * 8 / 12){
            dc.drawBitmap(originX + 101, originY + 133, poppy);
        }
        if(info.steps >= info.stepGoal * 7 / 12){
            dc.drawBitmap(originX + 88, originY + 134, poppy);
        }
        if(info.steps >= info.stepGoal * 6 / 12){
            dc.drawBitmap(originX + 75, originY + 135, poppy);
        }
        if(info.steps >= info.stepGoal * 5 / 12){
            dc.drawBitmap(originX + 62, originY + 137, poppy);
        }
        if(info.steps >= info.stepGoal * 4 / 12){
            dc.drawBitmap(originX + 48, originY + 140, poppy);
        }
        if(info.steps >= info.stepGoal * 3 / 12){
            dc.drawBitmap(originX + 34, originY + 143, poppy);
        }
        if(info.steps >= info.stepGoal * 2 / 12){
            dc.drawBitmap(originX + 22, originY + 146, poppy);
        }
        if(info.steps >= info.stepGoal * 1 / 12){
            dc.drawBitmap(originX + 9, originY + 151, poppy);
        }
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
