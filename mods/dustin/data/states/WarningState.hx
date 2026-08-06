//

import flixel.text.FlxText.FlxTextFormat;
import flixel.text.FlxText.FlxTextFormatMarkerPair;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.system.framerate.Framerate;
import funkin.backend.MusicBeatState;

var newWarningFont:FlxText = null;
function postCreate() {

    FlxG.camera.flash(0xFF000000, .3);
    MusicBeatState.skipTransIn = MusicBeatState.skipTransOut = true;
    disclaimer.text = "该模组含有大量着色器，设备弱爆了的别对此模组抱有希望\n\n虽然你可以在设置菜单中关闭此功能:\n外观  >  高级  >  #游戏玩法 着色器#\n\n以及还有大量 *强光闪烁* 请谨慎游玩！！！\n\n_按下 屏幕任意处 以继续。_\n\n+此汉化由 懒人汉化组 制作\n录视频也并非纯游戏实况加字幕+";
    disclaimer.applyMarkup(disclaimer.text, [
        new FlxTextFormatMarkerPair(new FlxTextFormat(0xFFFF5D5D), "*"),
        new FlxTextFormatMarkerPair(new FlxTextFormat(0xFF55DAFF), "#"),
        new FlxTextFormatMarkerPair(new FlxTextFormat(0x5B56CA), "+"),
        new FlxTextFormatMarkerPair(new FlxTextFormat(0xFFFFFF00), "_")
    ]);
    disclaimer.font = Paths.font("8bit-jve.ttf");
    disclaimer.textField.antiAliasType = 0/*ADVANCED*/;
    disclaimer.textField.sharpness = 400/*MAX ON OPENFL*/;
    disclaimer.y += 15;

    newWarningFont = new FlxText(0, 170, FlxG.width, "警告");
    newWarningFont.setFormat(Paths.font("fallen-down.ttf"), 60, 0xFFFFFFFF);
    newWarningFont.borderStyle = FlxTextBorderStyle.OUTLINE;
    newWarningFont.borderSize = 2;
    newWarningFont.borderColor = 0xFF000000;
    newWarningFont.textField.antiAliasType = 0/*ADVANCED*/;
    newWarningFont.textField.sharpness = 400/*MAX ON OPENFL*/;
    newWarningFont.alignment = "center";
    add(newWarningFont);

    titleAlphabet.visible = false;

    var freakingLunarBro = new FunkinSprite().loadGraphic(Paths.image('menus/credits/sprites/Lunarcleint'));
    add(freakingLunarBro);
    freakingLunarBro.scale.set(12, 12);
    freakingLunarBro.updateHitbox();
    freakingLunarBro.screenCenter();
    freakingLunarBro.x -= 675;
    freakingLunarBro.alpha = 0;

    new FlxTimer().start(20, function() {
        FlxTween.tween(freakingLunarBro, {alpha: 0.075, x: freakingLunarBro.x + 25}, 10);
    });
}

var __timer:Float = 0;
function update(elapsed:Float) {
    __timer += elapsed;
    if (controls.ACCEPT || FlxG.mouse.justPressed) {
        FlxG.camera.visible = false;
        goToTitle();
    }

    if (FlxG.keys.justPressed.F)
        FlxG.fullscreen = !FlxG.fullscreen;
}

function destroy() {
    Framerate.debugMode = 0;
}
