//
import sys.FileSystem;
import funkin.options.type.TextOption;
import funkin.options.type.Checkbox;
import funkin.options.TreeMenuScreen;
import funkin.savedata.FunkinSave;
import funkin.backend.assets.ModsFolder;

function postCreate() {
    bg.visible = false;

    titleLabel.font = Paths.font("vcr.ttf");
    descLabel.font = Paths.font("vcr.ttf");

    titleLabel.size = 48;
    descLabel.size = 24;

    titleLabel.x += 10;
    descLabel.x += 10;
}

function update(elapsed:Float) {
    for (menu in tree) {
        if (menu.health != -1) {
            menu.health = -1;
            switch (menu.rawName) {
                case "optionsTree.gameplay-name":
                    menu.members.remove(menu.members[9]); // 移除“流媒体人声”，因为存在内存问题
                    var noHitCheckbox:Checkbox = null;
                    var mechanicsHitCheckbox:Checkbox = null;
                    var botplayCheckbox:Checkbox = null;
                    var middleScrollCheckbox:Checkbox = null;

                    menu.insert(1, noHitCheckbox = new Checkbox("无伤模式", "不要漏掉任何一个音符，否则你会失败！！！影响歌曲结束后的经验获取（1倍倍率 → 2倍倍率）。", "nh", null, FlxG.save.data));
                    menu.insert(1, mechanicsHitCheckbox = new Checkbox("机制", "启用/禁用游戏机制，影响歌曲结束后的经验获取（1倍倍率 → 0.5倍倍率）。", "mechanics", null, FlxG.save.data));
                    menu.add(middleScrollCheckbox = new Checkbox("中间滚动", "若勾选，将音符轨道移至屏幕中央，并隐藏玩家2的音符轨道。", "MiddleScroll", null, FlxG.save.data));
                    menu.add(botplayCheckbox = new Checkbox("程序操控", "如果你手动操作能力较差，就开启这个选项。", "botplay", null, FlxG.save.data));

                    noHitCheckbox.color = 0xFFC9FEFF;
                    mechanicsHitCheckbox.color = 0xFF8CDBFF;
                    
                    menu.members.remove(menu.members[4]); // 移除“成人内容”
                case "optionsTree.appearance-name":
                    for (i in 1...5) menu.members.remove(menu.members[1]);
                    menu.members[1].suffix = "/ 着色器 >";
                case "optionsMenu.advanced":
                    menu.members[0].changedCallback = (val:String) -> {
                        var quality:Int = Std.parseInt(val);
                        switch (quality) {
                            case 0: // 低
                                set_shaders_low();
                            case 1: // 高
                                set_shaders_high();
                        }

                        if (quality <= 1) Options.antialiasing = true;
                        menu.members[1].checked = Options.antialiasing;
                        menu.members[2].checked = Options.gameplayShaders;

                        for (member in 0...menu.members.length) 
                            menu.members[member].locked = false;
                        
                        menu.members[3].locked = quality <= 1;
                        menu.members[2].locked = quality <= 1;

                        var antialiasing = quality == 0 ? false : (quality == 1 ? true : Options.antialiasing);
                        FlxG.game.stage.quality = (FlxG.enableAntialiasing = antialiasing) ? 0 /*最佳*/ : 2 /*低*/;
                    };

                    var shaderOption = menu.members[3];
                    menu.members.remove(shaderOption);
                    menu.members.insert(4, shaderOption);

                    menu.members.remove(menu.members[2]); // 移除“低内存模式”
                    menu.members.remove(menu.members[2]); // 移除“显存精灵选项”

                    shaderOption.selectCallback = () -> {
                        menu.members[3].locked = !shaderOption.checked;
                    };

                    menu.add(new TextOption("特定着色器 ", "更改更多的着色器选项。", ">", () -> {
                        var spefShadersTree:TreeMenuScreen = new TreeMenuScreen("特定着色器", "更改更高级的着色器选项（高端着色器最卡，中端着色器有点卡，低端着色器在大多数系统上不会造成问题）。");
                        var highEndText:TextOption = null;
                        spefShadersTree.add(highEndText = new TextOption("高端着色器 ", "高消耗着色器", ">", () -> {
                            var intShadersTree:TreeMenuScreen = new TreeMenuScreen("高性能着色器", "更改高性能着色器选项（从上到下，最难运行 → 最容易运行）。");
                            intShadersTree.add(new Checkbox("泛光效果", "启用/禁用泛光着色器。", "bloom", null, FlxG.save.data));
                            intShadersTree.add(new Checkbox("上帝光着色器", "启用/禁用上帝之光着色器。", "godrays", null, FlxG.save.data));
                            intShadersTree.add(new Checkbox("粒子着色器", "启用/禁用粒子着色器。", "particles", null, FlxG.save.data));
                            intShadersTree.add(new Checkbox("故障着色器", "启用/禁用故障着色器。", "glitch", null, FlxG.save.data));
                            spefShadersTree.parent.addMenu(intShadersTree);

                            for (i => member in intShadersTree.members)
                                member.color = FlxColor.interpolate(0xFFFE2323, 0xFFFFE3E3, i/intShadersTree.members.length);
                        }));
                        highEndText.color = 0xFFFFACAC;
                        var medEndText:TextOption = null;
                        spefShadersTree.add(medEndText = new TextOption("中端着色器 ", "中消耗着色器", ">", () -> {
                            var medShadersTree:TreeMenuScreen = new TreeMenuScreen("中端着色器", "更改中端着色器选项（从上到下，最难运行 → 最容易运行）。");
                            medShadersTree.add(new Checkbox("雾效着色器", "启用/禁用雾效着色器。", "fog", null, FlxG.save.data));
                            medShadersTree.add(new Checkbox("水效着色器", "启用/禁用水效着色器。", "water", null, FlxG.save.data));
                            medShadersTree.add(new Checkbox("色差着色器", "启用/禁用色差着色器。", "chromwarp", null, FlxG.save.data));
                            medShadersTree.add(new Checkbox("扭曲着色器", "启用/禁用扭曲着色器。", "warp", null, FlxG.save.data));
                            medShadersTree.add(new Checkbox("火焰着色器", "启用/禁用火焰着色器。", "fire", null, FlxG.save.data));
                            spefShadersTree.parent.addMenu(medShadersTree);

                            for (i => member in medShadersTree.members)
                                member.color = FlxColor.interpolate(0xFFFFF97D, 0xFFFFFFFF, i/medShadersTree.members.length);
                        }));
                        medEndText.color = 0xFFFFF5AC;
                        var lowEndText:TextOption = null;
                        spefShadersTree.add(lowEndText = new TextOption("低端着色器 ", "低消耗着色器", ">", () -> {
                            var lowShadersTree:TreeMenuScreen = new TreeMenuScreen("低端着色器", "更改低端着色器选项（从上到下，最难运行 → 最容易运行）。");
                            lowShadersTree.add(new Checkbox("静态着色器", "启用/禁用静态着色器。", "static", null, FlxG.save.data));
                            lowShadersTree.add(new Checkbox("像素着色器", "启用/禁用像素着色器。", "pixel", null, FlxG.save.data));
                            lowShadersTree.add(new Checkbox("饱和度着色器", "启用/禁用饱和度着色器。", "saturation", null, FlxG.save.data));
                            lowShadersTree.add(new Checkbox("冲击着色器", "启用/禁用冲击着色器。", "impact", null, FlxG.save.data));
                            spefShadersTree.parent.addMenu(lowShadersTree);
                            
                            for (i => member in lowShadersTree.members)
                                member.color = FlxColor.interpolate(0xFF88FF5D, 0xFFFFFFFF, i/lowShadersTree.members.length);
                        }));
                        lowEndText.color = 0xFFC2FFAC;
                        menu.parent.addMenu(spefShadersTree);
                    }));

                    menu.members[0].changedCallback(Std.string(Options.quality));
                    shaderOption.selectCallback();
                case "optionsTree.miscellaneous-name":
                    for (member in 1...5) // 移除一些会干扰构建的CNE内容
                        menu.members.remove(menu.members[1]);

                    #if desktop
                    menu.add(new Checkbox("种族灭绝猛料", "如果你不能玩种族灭绝，请取消勾选。你会错过一个非常酷的惊喜……", "gSwag", null, FlxG.save.data));
                    #end

                    if (!FileSystem.exists("dev.txt")) menu.members.shift();

                    for (member in menu.members)
                        if (member.rawText == "MiscOptions.resetSaveData-name") {
                            member.selectCallback = () -> {
                                FunkinSave.save.erase();
                                FunkinSave.highscores.clear();
                                FunkinSave.flush();

                                FlxG.save.erase();
			                    FlxG.save.data.dustinMigrated = true;
                                FlxG.save.flush();

                                ModsFolder.switchMod(ModsFolder.currentModFolder);
                            }
                        }
            }
        }
    }
}