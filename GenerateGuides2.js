
//This is based heavily on the "Generate Key Reference" script by Claire West found at "https://github.com/claire-west/svstudio-scripts"


var SCRIPT_TITLE = 'Generate Guide II';

var DURATION_MINIMUM = 10;

var TRACK_NAME = 'GUIDE';
var TRACK_COLOR_DEFAULT_MAJOR = '#EE4B2B';
var TRACK_COLOR_DEFAULT_MINOR = '#2288FF';
var OCTAVES = [ '1','2','3','4','5','6' ];
var MAX_OCTAVE = 8;
var LINE_COUNT = [ '1','2','3','4','5'];
var INCREMENTS = [ '1/32','1/16','1/8','1/4','1/2' ];
var BASELINE = [ 'C','D','E','F','G','A','B' ];
var DEF_LENGTH = 10;
var GUIDE_DURATION_MAX = SV.QUARTER;

function getClientInfo() {
  return {
    "name": SV.T(SCRIPT_TITLE),
    "author": "Bill White based on a Claire West script",
    "versionNumber": 1,
    "minEditorVersion": 65537,
  }
}

//Internationalization
//Note: Translated via Google, so it may all be Greek.
function getTranslations(langCode)
{
  if (langCode == "ja-jp") {
    return [
		["GUIDE_MAJOR", "ガイド専攻"],
		["GUIDE_MINOR", "ガイドマイナー"],	
		["Major Line On", "ガイドマイナー"],			
		["Generate Guide", "ガイドの生成"],
		["Rerunning the script will delete the current Guide Track and create a new one with the current length as a default", "スクリプトを再実行すると、現在のガイド トラックが削除され、デフォルトで現在の長さの新しいガイド トラックが作成されます"],
		["Bottom Octave", "ボトムオクターブ"],
		["How many lines", "何行"],
		["Major Guide Increments", "ガイドの大幅な増加"],
		["Minor Guide Increments", "ガイドのマイナーインクリメント"],		
		["Length in Measures", "長さ"],
		["Major Incr Color", "主増分の色"]
		["Minor Incr Color", "副増分の色"]		
		];
	} else 
	if (langCode == "zh-cn") {
    return [
		["GUIDE_MAJOR", "指导专业"],	
		["GUIDE_MINOR", "未成年人指南"],			
		["Major Line On", "未成年人指南"],					
		["Generate Guide", "生成指南"],
		["Rerunning the script will delete the current Guide Track and create a new one with the current length as a default", "重新运行脚本将删除当前轨道，并创建一个默认长度为当前长度的新轨道"],
		["Bottom Octave", "底部八度"],
		["How many lines", "多少行"],
		["Major Guide Increments", "指南的主要增量"],
		["Minor Guide Increments", "指南的小增量"],		
		["Length in Measures", "长度"],
		["Major Incr Color", "主要增量的颜色"]
		["Minor Incr Color", "小增量的颜色"]		
		];
	}
   return [];
}


function removeOldguideRefs() {
	
  for (var i = 0; i < SV.getProject().getNumTracks(); i++) {
    if (SV.getProject().getTrack(i).getName() === SV.T('GUIDE_MAJOR') || SV.getProject().getTrack(i).getName() === SV.T('GUIDE_MINOR')) {
	  SV.getProject().removeTrack(i);
	  i--;
    }
  }
	
}


function getguideRefTrackMajor() {
  // no existing track, make a new one
  var newMajorTrack = SV.create('Track');
  newMajorTrack.setName(SV.T('GUIDE_MAJOR'));
  newMajorTrack.setBounced(false);
  return newMajorTrack;
}

function getguideRefTrackMinor() {
  // no existing track, make a new one
  var newMinorTrack = SV.create('Track');
  newMinorTrack.setName(SV.T('GUIDE_MINOR'));
  newMinorTrack.setBounced(false);
  return newMinorTrack;
}

function setDefaultLength() {
	var endBlicks = SV.getProject().getDuration();
	var minBlicks = DURATION_MINIMUM * SV.QUARTER * 4;
	if (endBlicks < minBlicks ) { endBlicks = minBlicks; }	
	return Math.ceil(endBlicks / (SV.QUARTER * 4));
}

function generateGuideRefs() {
	
	var form = {

		title: SV.T("Generate Guide"),
		message: SV.T('Rerunning the script will delete the current Guide Track and create a new one with the current length as a default'),
		buttons: 'OkCancel',
		widgets: [
		{
		  name: 'octave',
		  type: 'ComboBox',
		  label: SV.T('Bottom Octave'),
		  choices: OCTAVES,
		  default: '1'
		},
		{
		  name: 'baseline',
		  type: 'ComboBox',
		  label: SV.T('Major Line On'),
		  choices: BASELINE,
		  default: '0'
		},		
		{
		  name: 'rows',
		  type: 'ComboBox',
		  label: SV.T('How many lines'),
		  choices: LINE_COUNT,
		  default: '3'
		},
		{
		  name: 'guide_dur_major',
		  type: 'ComboBox',
		  label: SV.T('Major Guide Increments'),
		  choices: INCREMENTS,
		  default: '3'
		},
		{
		  name: 'guide_dur_minor',
		  type: 'ComboBox',
		  label: SV.T('Minor Guide Increments'),
		  choices: INCREMENTS,
		  default: '1'
		},
		{
		  name: 'length',
		  label: SV.T('Length in Measures'),
		  type: 'TextBox',
		  default: setDefaultLength()
		},
		{
		  name: 'colorMajor',
		  label: SV.T('Major Incr Color'),
		  type: 'TextBox',
		  default: TRACK_COLOR_DEFAULT_MAJOR
		},
		{
		  name: 'colorMinor',
		  label: SV.T('Minor Incr Color'),
		  type: 'TextBox',
		  default: TRACK_COLOR_DEFAULT_MINOR
		}
		]
	};
    var results = SV.showCustomDialog(form)
    if (!results.status) {
      return;
    }

	var line_correction = 0;
 	switch(results.answers.baseline) {
		  case 0:  //C
			line_correction = 0;
			break;
		  case 1: //D
			line_correction = 2;
			break;
		  case 2:  //E
			line_correction = 4;
			break;
		  case 3:  //F
			line_correction = 5;
			break;
		  case 4:  //G
			line_correction = 7;
			results.answers.octave--;			
			break;
		  case 5:  //A
			line_correction = 9;
			results.answers.octave--;			
			break;
		  case 6:  //B
			line_correction = 11;
			results.answers.octave--;
			break;
		  default:
			break;
		}
	if (results.answers.octave < 1) { results.answers.octave = 1; }
    var orig_pitch = (results.answers.octave * 12) + 24 + line_correction;
    var row_count = results.answers.rows + 1;
	removeOldguideRefs();
//MAJOR LINES		
	var guideRefMajor = getguideRefTrackMajor();	  
  	SV.getProject().addTrack(guideRefMajor);	
    guideRefMajor.setDisplayColor(results.answers.colorMajor);
	
	mainGroup = guideRefMajor.getGroupReference(0).getTarget();
	switch(results.answers.guide_dur_major) {
		  case 0:
			GUIDE_DURATION_MAX = SV.QUARTER / 8;
			break;
		  case 1:
			GUIDE_DURATION_MAX = SV.QUARTER / 4;
			break;
		  case 2:
			GUIDE_DURATION_MAX = SV.QUARTER / 2;
			break;
		  case 3:
			GUIDE_DURATION_MAX = SV.QUARTER;
			break;
		  case 4:
			GUIDE_DURATION_MAX = SV.QUARTER * 2;
			break;
		  default:
			break;
		}
	var noteCount = (results.answers.length * SV.QUARTER * 4) / (GUIDE_DURATION_MAX * 2);
	for (var this_row = 0; this_row < row_count; this_row++) {
		var currBlick = 0;		
		var pitch = orig_pitch + (this_row * 12);
		if (pitch < 121) {
			for (var i = 0; i < noteCount; i++) {
				var note = SV.create('Note');
				note.setPitch(pitch);
				note.setOnset(currBlick);
				note.setDuration(GUIDE_DURATION_MAX);
				mainGroup.addNote(note);
				currBlick = currBlick + (GUIDE_DURATION_MAX * 2);
			}
		}
	}	
	
	
//MINOR LINES	
	var orig_pitch = (results.answers.octave * 12) + 24;
	orig_pitch = (results.answers.octave * 12) + 24 + line_correction - 1;
	var guideRefMinor = getguideRefTrackMinor();	  
  	SV.getProject().addTrack(guideRefMinor);	
    guideRefMinor.setDisplayColor(results.answers.colorMinor);

	mainGroup = guideRefMinor.getGroupReference(0).getTarget();
	switch(results.answers.guide_dur_minor) {
		  case 0:
			GUIDE_DURATION_MAX_MINOR = SV.QUARTER / 8;
			break;
		  case 1:
			GUIDE_DURATION_MAX_MINOR = SV.QUARTER / 4;
			break;
		  case 2:
			GUIDE_DURATION_MAX_MINOR = SV.QUARTER / 2;
			break;
		  case 3:
			GUIDE_DURATION_MAX_MINOR = SV.QUARTER;
			break;
		  case 4:
			GUIDE_DURATION_MAX_MINOR = SV.QUARTER * 2;
			break;
		  default:
			break;
		}
	var noteCount = (results.answers.length * SV.QUARTER * 4) / (GUIDE_DURATION_MAX_MINOR * 2);
	for (var this_row = 0; this_row < row_count; this_row++) {
		var currBlick = 0;		
		var pitch = orig_pitch + (this_row * 12);
		if (pitch < 121) {
			for (var i = 0; i < noteCount; i++) {
				var note = SV.create('Note');
				note.setPitch(pitch);
				note.setOnset(currBlick);
				note.setDuration(GUIDE_DURATION_MAX_MINOR);
				mainGroup.addNote(note);
				currBlick = currBlick + (GUIDE_DURATION_MAX_MINOR * 2);
			}
		}
	}	
	
}

function main() {
  //var push_selection = SV.getMainEditor().getSelection();
  generateGuideRefs();
  SV.getArrangement().getSelection().clearAll();
  SV.finish();
}
