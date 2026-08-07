//
public var finalNotesScale:Float = 0.65;
static var noteSkin:String = "default";
static var splashSkin:String = "default";

function create() {
	noteSkin = "default"; splashSkin = "default";
	
	if (stage != null && stage.stageXML != null) {
		if (stage.stageXML.exists("noteSkin")) {
			noteSkin = stage.stageXML.get("noteSkin");
			if (!stage.stageXML.exists("splashSkin") && Assets.exists(Paths.image("game/splashes/" + noteSkin))) {
				splashSkin = noteSkin;
			}
		}
		if (stage.stageXML.exists("splashSkin")) splashSkin = stage.stageXML.get("splashSkin");
	}
}

var __usePixel:Bool = false;
var __useSplashPixel:Bool = false;
static var prevNoteSkin:String = "default";

function update(elapsed:Float) {
	if (noteSkin != prevNoteSkin) {
		if (Assets.exists(Paths.image("game/splashes/" + noteSkin))) {
			splashSkin = noteSkin;
			__useSplashPixel = Assets.exists(Paths.image("game/splashes/" + splashSkin + "_END"));
			reloadNotesAndStrums();
		}
		prevNoteSkin = noteSkin;
	}
}

function onStrumCreation(event) {
	event.sprite = "game/notes/" + noteSkin;
	if (Assets.exists(Paths.image(event.sprite + "_END"))) {
		__usePixel = true; event.cancel();
		var strum = event.strum;
		strum.loadGraphic(Paths.image(event.sprite), true, 17, 17);
		strum.animation.add("static", [event.strumID]);
		strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
		strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);
	}
}

function onPostStrumCreation(e) {
	var trueScale:Float = __usePixel ? 6 : 1;
	e.strum.scale.set(trueScale, trueScale); e.strum.updateHitbox();
	e.strum.setGraphicSize(Std.int((e.strum.width * finalNotesScale)));
	e.strum.updateHitbox();
}

function onNoteCreation(e) {
	if (e.noteType != null && Assets.exists(Paths.image("game/notes/types/" + e.noteType)))
		e.noteSprite = "game/notes/types/" + e.noteType;
	else {
		e.noteScale = finalNotesScale;
		e.noteSprite = "game/notes/" + noteSkin;
		if (__usePixel) {
			e.cancel();
			var note = e.note;
			if (e.note.isSustainNote) {
				note.loadGraphic(Paths.image(e.noteSprite + "_END"), true, 7, 6);
				note.animation.add("hold", [e.strumID]);
				note.animation.add("holdend", [4 + e.strumID]);
			} else {
				note.loadGraphic(Paths.image(e.noteSprite), true, 17, 17);
				note.animation.add("scroll", [4 + e.strumID]);
			}
			note.scale.set(6, 6); note.updateHitbox();
			note.setGraphicSize(Std.int((note.width * finalNotesScale)));
			note.updateHitbox();
		}
	}
}

function onSplashCreation(e) {
	e.splashScale = finalNotesScale;
	e.splashSprite = "game/splashes/" + splashSkin;
	if (Assets.exists(Paths.image(e.splashSprite + "_END"))) {
		__useSplashPixel = true;
		e.cancel();
		var splash = e.splash;
		splash.loadGraphic(Paths.image(e.splashSprite), true, 34, 34);
		splash.animation.add("splash", [0, 1, 2, 3], 24, false);
		splash.scale.set(6, 6); splash.updateHitbox();
		splash.setGraphicSize(Std.int((splash.width * finalNotesScale)));
		splash.updateHitbox();
	}
}

function onPostNoteCreation(e) {
	e.note.splash = splashSkin;
	
	switch (noteSkin) {
		case "default":
			e.note.useAntialiasingFix = true;
			if(e.note.gapFix != null)
				e.note.gapFix = 3.5;
	}
	
	switch (splashSkin) {
		case "default":
			e.note.splashUseAntialiasingFix = true;
		case "default":
			e.note.splashUseAntialiasingFix = false;
	}
}

function onNoteHit(e) {
	if (splashSkin == null) e.showSplash = true;
	
	if (__useSplashPixel && e.splashNote != null) {
		e.splashNote.scale.set(6, 6);
		e.splashNote.updateHitbox();
		e.splashNote.setGraphicSize(Std.int((e.splashNote.width * finalNotesScale)));
		e.splashNote.updateHitbox();
	}
}

//
public var finalNotesScale:Float = 0.65;
static var noteSkin:String = "default";
static var splashSkin:String = "default";

function create() {
	noteSkin = "default"; splashSkin = "default";
	
	if (stage != null && stage.stageXML != null) {
		if (stage.stageXML.exists("noteSkin")) {
			noteSkin = stage.stageXML.get("noteSkin");
			if (!stage.stageXML.exists("splashSkin") && Assets.exists(Paths.image("game/splashes/" + noteSkin))) {
				splashSkin = noteSkin;
			}
		}
		if (stage.stageXML.exists("splashSkin")) splashSkin = stage.stageXML.get("splashSkin");
	}
}

var __usePixel:Bool = false;
var __useSplashPixel:Bool = false;
static var prevNoteSkin:String = "default";

function update(elapsed:Float) {
	if (noteSkin != prevNoteSkin) {
		if (Assets.exists(Paths.image("game/splashes/" + noteSkin))) {
			splashSkin = noteSkin;
			__useSplashPixel = Assets.exists(Paths.image("game/splashes/" + splashSkin + "_END"));
			reloadNotesAndStrums();
		}
		prevNoteSkin = noteSkin;
	}
}

function onStrumCreation(event) {
	event.sprite = "game/notes/" + noteSkin;
	if (Assets.exists(Paths.image(event.sprite + "_END"))) {
		__usePixel = true; event.cancel();
		var strum = event.strum;
		strum.loadGraphic(Paths.image(event.sprite), true, 17, 17);
		strum.animation.add("static", [event.strumID]);
		strum.animation.add("pressed", [4 + event.strumID, 8 + event.strumID], 12, false);
		strum.animation.add("confirm", [12 + event.strumID, 16 + event.strumID], 24, false);
	}
}

function onPostStrumCreation(e) {
	var trueScale:Float = __usePixel ? 6 : 1;
	e.strum.scale.set(trueScale, trueScale); e.strum.updateHitbox();
	e.strum.setGraphicSize(Std.int((e.strum.width * finalNotesScale)));
	e.strum.updateHitbox();
}

function onNoteCreation(e) {
	if (e.noteType != null && Assets.exists(Paths.image("game/notes/types/" + e.noteType)))
		e.noteSprite = "game/notes/types/" + e.noteType;
	else {
		e.noteScale = finalNotesScale;
		e.noteSprite = "game/notes/" + noteSkin;
		if (__usePixel) {
			e.cancel();
			var note = e.note;
			if (e.note.isSustainNote) {
				note.loadGraphic(Paths.image(e.noteSprite + "_END"), true, 7, 6);
				note.animation.add("hold", [e.strumID]);
				note.animation.add("holdend", [4 + e.strumID]);
			} else {
				note.loadGraphic(Paths.image(e.noteSprite), true, 17, 17);
				note.animation.add("scroll", [4 + e.strumID]);
			}
			note.scale.set(6, 6); note.updateHitbox();
			note.setGraphicSize(Std.int((note.width * finalNotesScale)));
			note.updateHitbox();
		}
	}
}

function onSplashCreation(e) {
	e.splashScale = finalNotesScale;
	e.splashSprite = "game/splashes/" + splashSkin;
	if (Assets.exists(Paths.image(e.splashSprite + "_END"))) {
		__useSplashPixel = true;
		e.cancel();
		var splash = e.splash;
		splash.loadGraphic(Paths.image(e.splashSprite), true, 34, 34);
		splash.animation.add("splash", [0, 1, 2, 3], 24, false);
		splash.scale.set(6, 6); splash.updateHitbox();
		splash.setGraphicSize(Std.int((splash.width * finalNotesScale)));
		splash.updateHitbox();
	}
}

function onPostNoteCreation(e) {
	e.note.splash = splashSkin;
	
	switch (noteSkin) {
		case "default":
			e.note.useAntialiasingFix = true;
			if(e.note.gapFix != null)
				e.note.gapFix = 3.5;
	}
	
	switch (splashSkin) {
		case "default":
			e.note.splashUseAntialiasingFix = true;
		case "default":
			e.note.splashUseAntialiasingFix = false;
	}
}

function onNoteHit(e) {
	if (splashSkin == null) e.showSplash = true;
	
	if (__useSplashPixel && e.splashNote != null) {
		e.splashNote.scale.set(6, 6);
		e.splashNote.updateHitbox();
		e.splashNote.setGraphicSize(Std.int((e.splashNote.width * finalNotesScale)));
		e.splashNote.updateHitbox();
	}
}

function updateNoteSkin(newSkin:String) {
	noteSkin = newSkin;
	
	if (Assets.exists(Paths.image("game/splashes/" + noteSkin))) {
		splashSkin = noteSkin;
		__useSplashPixel = Assets.exists(Paths.image("game/splashes/" + splashSkin + "_END"));
	}
	
	reloadNotesAndStrums();
}

function reloadNotesAndStrums() {
}
function updateNoteSkin(newSkin:String) {
	noteSkin = newSkin;
	
	if (Assets.exists(Paths.image("game/splashes/" + noteSkin))) {
		splashSkin = noteSkin;
		__useSplashPixel = Assets.exists(Paths.image("game/splashes/" + splashSkin + "_END"));
	}
	
	reloadNotesAndStrums();
}

function reloadNotesAndStrums() {
}
