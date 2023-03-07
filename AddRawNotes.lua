SCRIPT_TITLE = "Add Raw Notes v.1.1"

-- Standard header
function getClientInfo()
  return {
    name = SV:T(SCRIPT_TITLE),
    author = "Bill White",
    versionNumber = 1,
    minEditorVersion = 65537,
  }
end

--[[
Note: All translations done by Google, so they may not be accurate.

Make sure you have a good backup of whatever project you're working on before you start!

This script will read lyrics from a text file and place a bunch of corresponding notes on a track and populate those notes with the lyrics.  It will attempt to divide words into syllables and add a "+" note for each additional syllable. (It's about 70% accurate on the syllable counts.)

It will base the duration of the notes roughly on the length of the individual lyrics. This can be adjusted by playing with "Note length per letter" setting.

It will put a rest wherever there is a line feed in the input text. The length of the rest can be changed using the "Rest length between lines" slider. If you check the "Start lines on next measure" box, it will ignore the "Rest length between lines" setting and instead will start the next line on the next whole measure.

It will also offer to vary the pitch of the notes. To activate this feature, check the "Vary pitch" box. It will then use the selected note as the tonic. You can set a minor key by unchecking the "Major Scale" check box. Then each note will simply ascend the scale until it hits the scale degree set by the "Max Scale Degree for Variance" slider. Then it will descend until it hits the "Max Half Steps Allowed beneath the Tonic" setting.  It will reset to the tonic for each line in the text input file.

The point of this is not to try to write the song, of course!  It's just that I'm lazy and hate counting notes and adding lyrics. This gives you a base layout to start moving things around, and I think having it run up and down scales helps give a feel if you have the right key, the right octave, and the right voice. 

In general, to use the script: 
* Place a file named "input.txt" in (Windows) the SynthV program root folder ("C:\Program Files\Synthesizer V Studio Pro" by default); on Mac, put the file in your HOME folder. (This also may work on Linux; haven't tested it.) If you put in some other path name in the text box, it will try to use that. 
* Add a track to your project 
* Add a single note to that track. That note tells the script where to start placing its own notes. 
* Select that note and press OK to run the script.

It should remember your configuration settings between runs. To restore to defaults, check the "Ignore these settings and reset defaults" box and hit "OK."

Pro tip: the widgets can get a little finicky. If you can't get one to go where you want, you can search your hard drive for "rawnotes.cfg" and edit it with a text editor. The fields should be self-explanatory. (On Windows, by default it should be at "C:\Program Files\Synthesizer V Studio Pro\rawnotes.cfg:; other OSs it should be in your HOME folder.)

Although I have added the Internationalization section, it is extremely doubtful this would work in languages other than English. Some enterprising musician might take a crack at it though?
----------------------------------------------------------------------------------------------------------------------------
注: すべて Google によって翻訳されているため、正確ではない可能性があります。

開始する前に、作業中のプロジェクトの適切なバックアップがあることを確認してください!

このスクリプトは、テキスト ファイルから歌詞を読み取り、対応するノートをトラックに配置して、それらのノートに歌詞を入力します。 単語を音節に分割し、追加の音節ごとに "+" ノートを追加しようとします。 (音節数の正確さは約 70% です。)

ノートの長さは、個々の歌詞の長さに基づいています。 これは、「文字ごとの音符の長さ」設定で遊ぶことで調整できます。

入力テキストに改行があると休符が入ります。 休符の長さは、「行間の休符の長さ」スライダーを使用して変更できます。 [次の小節で行を開始] ボックスをオンにすると、[行間の残りの長さ] 設定が無視され、代わりに次の小節全体で次の行が開始されます。

また、ノートのピッチを変更することもできます。 この機能を有効にするには、[ピッチを変更] ボックスをオンにします。 次に、選択したノートをトニックとして使用します。 「メジャースケール」チェックボックスをオフにすると、マイナーキーを設定できます。 次に、各ノートは、"Max Scale Degree for Variance" スライダーで設定されたスケール度に達するまで、単純にスケールを上げていきます。 次に、「トニックの下で許可される最大ハーフステップ」設定に達するまで下降します。 テキスト入力ファイルの各行のトニックにリセットされます。

もちろん、これのポイントは曲を書こうとすることではありません! 怠け者で、音符を数えたり歌詞を追加したりするのが嫌いなだけです。 これにより、物事を動かし始めるための基本的なレイアウトが得られます。スケールを上下に動かすと、適切なキー、適切なオクターブ、適切な声があれば、感覚をつかむのに役立つと思います。

一般に、スクリプトを使用するには:
* 「input.txt」という名前のファイルを (Windows) SynthV プログラムのルート フォルダー (デフォルトでは「C:\Program Files\Synthesizer V Studio Pro」) に配置します。 Mac では、ファイルを HOME フォルダーに置きます。 (これは Linux でも動作する可能性があります。テストしていません。) テキスト ボックスに別のパス名を入力すると、それを使用しようとします。
* プロジェクトにトラックを追加
* そのトラックに 1 つのノートを追加します。 そのメモは、独自のメモの配置を開始する場所をスクリプトに指示します。
* そのメモを選択し、[OK] を押してスクリプトを実行します。

実行間で構成設定を記憶する必要があります。 デフォルトに戻すには、[これらの設定を無視してデフォルトにリセットする] ボックスをオンにして、[OK] をクリックします。

プロのヒント: ウィジェットは少し扱いにくい場合があります。 必要な場所に移動できない場合は、ハード ドライブで「rawnotes.cfg」を検索し、テキスト エディターで編集できます。 フィールドは自明である必要があります。 (Windows では、デフォルトで「C:\Program Files\Synthesizer V Studio Pro\rawnotes.cfg:」にあります。その他の OS では、HOME フォルダにあります。)

国際化セクションを追加しましたが、これが英語以外の言語で機能するかどうかは非常に疑わしいです。 しかし、進取の気性に富んだミュージシャンの中には、それに挑戦する人もいるでしょうか?
----------------------------------------------------------------------------------------------------------------------------
注意：所有翻译均由谷歌完成，因此可能不准确。

在开始之前，请确保您对正在进行的任何项目都有良好的备份！

该脚本将从文本文件中读取歌词，并将一堆相应的音符放在曲目上，然后用歌词填充这些音符。 它会尝试将单词分成音节，并为每个额外的音节添加一个“+”音符。 （它在音节数上的准确率约为 70%。）

它将大致根据单个歌词的长度来确定音符的持续时间。 这可以通过播放“每个字母的音符长度”设置来调整。

只要输入文本中有换行符，它就会暂停。 可以使用“线之间的休息长度”滑块更改休息的长度。 如果您选中“下一个小节的起始线”框，它将忽略“行间的静止长度”设置，而是在下一个完整小节开始下一条线。

它还将提供改变音符的音高。 要激活此功能，请选中“Vary pitch”框。 然后它将使用选定的音符作为补品。 您可以通过取消选中“大调”复选框来设置小调。 然后每个音符将简单地提升音阶，直到它达到由“方差的最大音阶”滑块设置的音阶。 然后它将下降，直到达到“Tonic 下允许的最大半步数”设置。 它将重置为文本输入文件中每一行的主音。

当然，这里的重点不是尝试写这首歌！ 只是我比较懒，讨厌数笔记加歌词。 这为您提供了一个开始移动事物的基本布局，我认为如果您拥有正确的键、正确的八度音阶和正确的声音，让它上下运行有助于给人一种感觉。

一般来说，要使用脚本：
* 在（Windows）SynthV 程序根文件夹（默认为“C:\Program Files\Synthesizer V Studio Pro”）中放置一个名为“input.txt”的文件； 在 Mac 上，将文件放在您的 HOME 文件夹中。 （这也可能适用于 Linux；尚未测试。）如果您在文本框中输入其他路径名，它会尝试使用该路径名。
* 为您的项目添加曲目
* 向该曲目添加单个音符。 该注释告诉脚本从哪里开始放置自己的注释。
* 选择该注释并按 OK 运行脚本。

它应该在运行之间记住您的配置设置。 要恢复为默认值，请选中“忽略这些设置并重置默认值”框并点击“确定”。

专业提示：小部件可能会有些挑剔。 如果你不能把它带到你想去的地方，你可以在你的硬盘上搜索“rawnotes.cfg”并用文本编辑器编辑它。 这些字段应该是不言自明的。 （在 Windows 上，默认情况下它应该位于“C:\Program Files\Synthesizer V Studio Pro\rawnotes.cfg:；其他操作系统应该在您的主文件夹中。）

虽然我已经添加了国际化部分，但我非常怀疑这是否适用于英语以外的语言。 一些有进取心的音乐家可能会尝试一下？
--]]

-- Internationalization

function getTranslations(langCode)
  if langCode == "ja-jp" then
    return {
		{" Not Found"," 見つかりません"},
		{"Add Raw Notes v.2","生のメモを追加 v.2"},
		{"Add only one note to a track and select it. That will be the starting note.","トラックにノートを 1 つだけ追加して選択します。 それがスタートノートになります。"},
		{"Defaults restored. Exiting.","デフォルトが復元されました。 終了します。"},
		{"Ignore these settings and reset defaults","これらの設定を無視してデフォルトにリセットする"},
		{"Input Text File Name","入力テキスト ファイル名"},
		{"Major Scale","メジャースケール"},
		{"Max Half Steps Allowed beneath the Tonic","トニックの下で許容される最大半歩"},
		{"Max Scale Degree for Variance","分散の最大スケール次数"},
		{"Maximum note length (in 1/32s)","最大音符の長さ (1/32 秒)"},
		{"Minimum note length (in 1/32s)","最小音符の長さ (1/32 秒)"},
		{"No note selected. Please select a single note.","メモが選択されていません。 ノートを 1 つ選択してください。"}, 
		{"No selection. Please select a single note.","選択なし。 ノートを 1 つ選択してください。"},
		{"Note length per letter (in 1/256s)","1 文字あたりの長さ (1/256 秒)"},
		{"Quantize Notes(in 1/16s, 0 for Off)","ノートのクオンタイズ (1/16 秒単位、オフの場合は 0)"},
		{"Rest length between lines (in 1/32s)","行間の残りの長さ (1/32 秒)"},
		{"Start lines on next measure","次の小節の開始行"},
		{"There can only be a single note on the selected track.","選択したトラックには単一のノートしか存在できません。"}, 
		{"Vary pitch","ピッチを変える"},
		{"~~~~~~~~~~~~~~~~~~~~~~~~  PITCH VARIATION  ~~~~~~~~~~~~~~~~~~~~~~~~","~~~~~~~~~~~~~~~~~~~~~~~~  ピッチバリエーション  ~~~~~~~~~~~~~~~~~~~~~~~~"},
		{"~~~~~~~~~~~~~~~~~~~~~~~~~  NOTE LENGTHS  ~~~~~~~~~~~~~~~~~~~~~~~~~","~~~~~~~~~~~~~~~~~~~~~~~~~  ノートの長さ  ~~~~~~~~~~~~~~~~~~~~~~~~~"},
		{"~~~~~~~~~~~~~~~~~~~~~~~~~~~  RESTS  ~~~~~~~~~~~~~~~~~~~~~~~~~~~","~~~~~~~~~~~~~~~~~~~~~~~~~~~  レスト  ~~~~~~~~~~~~~~~~~~~~~~~~~~~"},	
    }
  end
  if langCode == "zh-cn" then
    return {
		{" Not Found"," 未找到"},
		{"Add Raw Notes v.2","添加原始笔记 v.2"},
		{"Add only one note to a track and select it. That will be the starting note.","只向轨道添加一个音符并选择它。 那将是开始的音符。"},
		{"Defaults restored. Exiting.","默认值已恢复。 退出。"},
		{"Ignore these settings and reset defaults","忽略这些设置并重置默认值"},
		{"Input Text File Name","输入文本文件名"},
		{"Major Scale","大尺度"},
		{"Max Half Steps Allowed beneath the Tonic","Tonic 下允许的最大半步"},
		{"Max Scale Degree for Variance","方差的最大尺度度"},
		{"Maximum note length (in 1/32s)","最大音符长度（以 1/32 秒为单位）"},
		{"Minimum note length (in 1/32s)","最小音符长度（以 1/32 秒为单位）"},
		{"No note selected. Please select a single note.","未选择备注。 请选择一个音符。"}, 
		{"No selection. Please select a single note.","没有选择。 请选择一个音符。"},
		{"Note length per letter (in 1/256s)","每个字母的音符长度（以 1/256 秒为单位）"},
		{"Quantize Notes(in 1/16s, 0 for Off)","量化音符（以 1/16 秒为单位，0 表示关闭）"},		
		{"Rest length between lines (in 1/32s)","行间静止长度（1/32s）"},
		{"Start lines on next measure","下一个小节的起始行"},
		{"There can only be a single note on the selected track.","所选轨道上只能有一个音符。"}, 
		{"Vary pitch","变音调"},
		{"~~~~~~~~~~~~~~~~~~~~~~~~  PITCH VARIATION  ~~~~~~~~~~~~~~~~~~~~~~~~","~~~~~~~~~~~~~~~~~~~~~~~~  音调变化  ~~~~~~~~~~~~~~~~~~~~~~~~"},
		{"~~~~~~~~~~~~~~~~~~~~~~~~~  NOTE LENGTHS  ~~~~~~~~~~~~~~~~~~~~~~~~~","~~~~~~~~~~~~~~~~~~~~~~~~~  音符长度  ~~~~~~~~~~~~~~~~~~~~~~~~~"},
		{"~~~~~~~~~~~~~~~~~~~~~~~~~~~  RESTS  ~~~~~~~~~~~~~~~~~~~~~~~~~~~","~~~~~~~~~~~~~~~~~~~~~~~~~~~  休息  ~~~~~~~~~~~~~~~~~~~~~~~~~~~"},	
    }
  end
  return {}
end


function determine_OS()
	local hostinfo = SV:getHostInfo()
	return hostinfo.osType
end


-- main function
function main()
	

	if precheck() == true then
		local OS = determine_OS()
		local def_filename = "input.txt"	
		local def_cfgfile = "rawnotes.cfg"
		if OS ~= "Windows" then  --"Windows", "macOS", "Linux", "Unknown"
			def_filename = os.getenv("HOME") .. "/" .. def_filename
			def_cfgfile = os.getenv("HOME") .. "/" .. def_cfgfile
		end
		local mydefaults = {}, err
		mydefaults.filename = def_filename
		mydefaults.breaklength = 32
		mydefaults.syllablelength = 4
		mydefaults.min_duration = 2 
		mydefaults.max_duration = 384
		mydefaults.quantization = 1
		mydefaults.VaryP = 0
		mydefaults.MajorB = 1	
		local VaryPbool = false
		local MajorBool = true	
		local goToNextBarBool = false
		mydefaults.maxScaleStep = 5
		mydefaults.turn_around_delta = 1
		if file_exists(def_cfgfile) then
			mydefaults,err = table.load( def_cfgfile )
			assert( err == nil )
			if mydefaults.VaryP == 1 then VaryPbool = true end
			if mydefaults.MajorB == 0 then MajorBool = false end	
			if mydefaults.NextBar == 1 then goToNextBarBool = true end	
		end


		local form = {
			title = SV:T(SCRIPT_TITLE),
			message = SV:T("Add only one note to a track and select it. That will be the starting note."),
			buttons = "OkCancel",
			widgets = {
				{
					name = "filename",
					type = "TextBox",
					label = SV:T("Input Text File Name"),
					default = mydefaults.filename
				},			
				{
				name = "", type = "TextArea",
				label = SV:T("~~~~~~~~~~~~~~~~~~~~~~~~~~~  RESTS  ~~~~~~~~~~~~~~~~~~~~~~~~~~~"),
				height = 0,
				default = "",
				},				
				
				{
					name = "breaklength",
					type = "Slider",
					label = SV:T("Rest length between lines (in 1/32s)"),
					format = "%1.0f",
					minValue = 1,
					maxValue = 256,
					interval = 1,
					default = mydefaults.breaklength
					--default = (SV.QUARTER / SV.QUARTER) * 100
				},			
				{
					name = "goToNextBar",
					type = "CheckBox",
					text = SV:T("Start lines on next measure"),
					default = goToNextBarBool					
				},			
				{
				name = "", type = "TextArea",
				label = SV:T("~~~~~~~~~~~~~~~~~~~~~~~~~  NOTE LENGTHS  ~~~~~~~~~~~~~~~~~~~~~~~~~"),
				height = 0,
				default = "",
				},				
				{
					name = "syllablelength",
					type = "Slider",
					label = SV:T("Note length per letter (in 1/256s)"),
					format = "%3.0f",
					minValue = 1,
					maxValue = 64,
					interval = 1,
					default = mydefaults.syllablelength
					--default = (SV.QUARTER/4)/SV.QUARTER * 100
				},			
				{
					name = "quantization",
					type = "Slider",
					label = SV:T("Quantize Notes(in 1/16s, 0 for Off)"),
					format = "%1.0f",
					minValue = 0,
					maxValue = 8,
					interval = 1,
					default = mydefaults.quantization
					--default = (SV.QUARTER/4)/SV.QUARTER * 100
				},			
				{
					name = "min_duration",
					type = "Slider",
					label = SV:T("Minimum note length (in 1/32s)"),
					format = "%3.0f",
					minValue = 1,
					maxValue = 32,
					interval = 1,
					default = mydefaults.min_duration
					--default = (SV.QUARTER/4)/SV.QUARTER * 100
				},			
				{
					name = "max_duration",
					type = "Slider",
					label = SV:T("Maximum note length (in 1/32s)"),
					format = "%3.0f",
					minValue = 1,
					maxValue = 384,
					interval = 1,
					default = mydefaults.max_duration
					--default = (SV.QUARTER/4)/SV.QUARTER * 100
				},			
				{
				name = "", type = "TextArea",
				label = SV:T("~~~~~~~~~~~~~~~~~~~~~~~~  PITCH VARIATION  ~~~~~~~~~~~~~~~~~~~~~~~~"),
				height = 0,
				default = "",
				},				
				{
					name = "VaryPbool",
					type = "CheckBox",
					text = SV:T("Vary pitch"),
					default = VaryPbool
				},
				{
					name = "MajorBool",
					type = "CheckBox",
					text = SV:T("Major Scale"),
					default = MajorBool
				},
				{
					name = "maxScaleStep",
					type = "Slider",
					label = SV:T("Max Scale Degree for Variance"),
					format = "%3.0f",
					minValue = 1,
					maxValue = 7,
					interval = 1,
					default = mydefaults.maxScaleStep
					--default = (SV.QUARTER/4)/SV.QUARTER * 100
				},			
				{
					name = "turn_around_delta",
					type = "Slider",
					label = SV:T("Max Half Steps Allowed beneath the Tonic"),
					format = "%3.0f",
					minValue = 0,
					maxValue = 12,
					interval = 1,
					default = mydefaults.turn_around_delta
					--default = (SV.QUARTER/4)/SV.QUARTER * 100
				},			
				{
				name = "", type = "TextArea",
				label = "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~",
				height = 0,
				default = "",
				},								
				{
					name = "ResetDefaults",
					type = "CheckBox",
					text = SV:T("Ignore these settings and reset defaults"),
					default = false
				},
			},
		}

		local results = SV:showCustomDialog(form)
		if results.status then
			if results.answers.ResetDefaults == true then
				results.answers.filename = "input.txt"
				if OS ~= "Windows" then results.answers.filename = os.getenv("HOME") .. "/input.txt" end
				results.answers.breaklength = 32
				results.answers.syllablelength = 4
				results.answers.min_duration = 2
				results.answers.max_duration = 384
				results.answers.quantization = 1
				results.answers.maxScaleStep = 5
				results.answers.turn_around_delta = 3
				mydefaults = results.answers
				mydefaults.VaryP = 0
				mydefaults.MajorB = 1
				mydefaults.NextBar = 0
				table.save(mydefaults,def_cfgfile)
				SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("Defaults restored. Exiting."))
			else	
				mydefaults = results.answers
				if results.answers.VaryPbool == true then mydefaults.VaryP = 1 else mydefaults.VaryP = 0 end
				if results.answers.MajorBool == true then mydefaults.MajorB = 1 else mydefaults.MajorB = 0 end		
				if results.answers.goToNextBar == true then mydefaults.NextBar = 1 else mydefaults.NextBar = 0 end					
				--if mydefaults.NextBar == 1 then goToNextBarBool = true end	
				table.save(mydefaults,def_cfgfile)
				results.answers.syllablelength = (results.answers.syllablelength)  * (SV.QUARTER / 16)
				results.answers.breaklength = (results.answers.breaklength) * (SV.QUARTER / 8)
				local major_minor = results.answers.MajorBool
				local min_duration = results.answers.min_duration * (SV.QUARTER / 8)
				local max_duration = results.answers.max_duration * (SV.QUARTER / 8)
				local quantize_divisor = (results.answers.quantization / 16) * (SV.QUARTER * 4)
				math.randomseed(os.time())							
				local sel = SV:getMainEditor():getSelection()
				if sel ~= nil then
					local file = results.answers.filename
					file = file:gsub('"', '')
					if file_exists(file) then
						local filelines = lines_from(file)
						local count = 0
						local inputstring={}
						local this_len = 0
						local notes = sel:getSelectedNotes()
						sel:clearAll()
						if #notes > 0 then
							local note = notes[1]
							local group = note:getParent()
							local total_notes = group:getNumNotes() 
							if total_notes == 1 then
								local i = note:getIndexInParent()

								local base_duration = results.answers.syllablelength -- * 4
								local this_onset = note:getOnset() + note:getDuration()
								local base_pitch = note:getPitch()
								local our_pitch = base_pitch
								local curr_step = 1
								local direction = 1
								local counter = 0
								local syllables_here = 1
								for k,v in pairs(filelines) do
									curr_step = 1
									direction = 1
									counter = 0
									our_pitch = base_pitch
									inputstring = mysplit(v)
									for _,word in ipairs(inputstring) do
										--word = word:gsub('[%p%c%s]', '')	-- leave the punctuation in; it  makes a difference 
										syllables_here = CountSyllables(word)						
										if syllables_here == 0 then syllables_here = 1 end
										local newNote = SV:create("Note")
										newNote:setOnset(this_onset)
										if results.answers.VaryPbool == true then
											if counter > 0 then
												our_pitch, curr_step = Calculate_pitch(major_minor, curr_step, our_pitch, direction)
												if curr_step >= results.answers.maxScaleStep or our_pitch - base_pitch >= 12 then 
													direction = -1
												end	
												if base_pitch - our_pitch >= results.answers.turn_around_delta then direction = 1 end
											end	
										end
										newNote:setPitch(our_pitch)
										this_len = string.len(word)
										--duration = base_duration * (this_len/(4 * syllables_here))
										duration = base_duration * (this_len/syllables_here)
										if quantize_divisor > 0 then
											local t_dur = math.fmod(duration,quantize_divisor)
											if t_dur > .3 then
												duration =  math.ceil(duration/quantize_divisor) * quantize_divisor
											else
												duration =  math.floor(duration/quantize_divisor) * quantize_divisor
												if duration == 0 then duration = quantize_divisor end
											end
										end
										if duration < min_duration then duration = min_duration end
										if duration > max_duration then duration = max_duration end
										newNote:setDuration(duration)
										newNote:setLyrics(word)
										group:addNote(newNote)
										counter = counter + 1
										sel:selectNote(newNote)
										this_onset = this_onset + duration
										for i = 1, syllables_here - 1 do
											local newNote = SV:create("Note")
											newNote:setOnset(this_onset)
											if results.answers.VaryPbool == true then
												if counter > 0 then
													our_pitch, curr_step = Calculate_pitch(major_minor, curr_step, our_pitch, direction)
													if curr_step >= results.answers.maxScaleStep or our_pitch - base_pitch >= 12 then 
														direction = -1
													end
													if base_pitch - our_pitch >= results.answers.turn_around_delta then direction = 1 end
												end	
											end
											newNote:setPitch(our_pitch)
											newNote:setDuration(duration)
											newNote:setLyrics("+")
											group:addNote(newNote)
											counter = counter + 1									
											sel:selectNote(newNote)
											this_onset = this_onset + duration
										end
									end
									if results.answers.goToNextBar == true then
										this_onset = find_next_bar_start(this_onset)
									else
										this_onset = this_onset + results.answers.breaklength								
									end
								end	
							else	
								SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("There can only be a single note on the selected track."))
							end	
						else	
							SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("No note selected. Please select a single note."))				
						end
					else	
						SV:showMessageBox(SV:T(SCRIPT_TITLE), file .. SV:T(" Not Found"))
					end
				else	
					SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("No selection. Please select a single note."))
				end
			end	
		end	
	end
    SV:finish()
end


function precheck()
	local sel = SV:getMainEditor():getSelection()
	if sel == nil then
		local project = SV.getProject()
		local trackCount = project:getNumTracks()
		for i = 1, trackCount do
			local track = project:getTrack(i)
			local mainGroup = track:getGroupReference(0):getTarget()
			local notecount = mainGroup:getNumNotes()
			if notecount ==  1 then
				local note = mainGroup:getNote() 
				sel:clearAll()
				sel:selectNote(note)
			end
		end	
	end
	sel = SV:getMainEditor():getSelection()
	if sel == nil then
		SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("No selection. Please select a single note."))
		return false
	end	
	local notes = sel:getSelectedNotes()
	if #notes == 0 then 
		local project = SV:getProject()
		local trackCount = project:getNumTracks()
		for i = 1, trackCount do
			local track = project:getTrack(i)
			local mainGroup = track:getGroupReference(1):getTarget()
			local notecount = mainGroup:getNumNotes()
			if notecount ==  1 then
				local note = mainGroup:getNote(1) 
				sel:clearAll()
				sel:selectNote(note)
			end
		end	
	end
	notes = sel:getSelectedNotes()
	if #notes == 0 then 
		SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("No note selected. Please select a single note.")) 
		return false
	end
	local note = notes[1]
	local group = note:getParent()
	if group:getNumNotes() ~= 1 then 
		SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("There can only be a single note on the selected track.")) 
		return false
	end				
	return true
end


function find_next_bar_start(position)
	local BAR_LENGTH = SV.QUARTER * 4
	local barposition = position/BAR_LENGTH
	return math.ceil(barposition) * BAR_LENGTH
end

--majorminor

function Calculate_pitch(major_sc, curr_step, curr_pitch, direction)
	local Major = {2,2,1,2,2,2,1}
	local Minor = {2,1,2,2,1,2,2}
	
	local new_pitch = curr_pitch
	if major_sc == true then 
		if direction == 1 then
		  new_pitch = new_pitch + Major[curr_step]
		  curr_step = curr_step + 1
		  if curr_step > 7 then curr_step = 1 end
		elseif direction == -1 then
		  curr_step = curr_step - 1
		  if curr_step < 1 then curr_step = 7 end
		  new_pitch = new_pitch - Major[curr_step]
		  
		end
	else --minor
		if direction == 1 then
		  new_pitch = new_pitch + Minor[curr_step]
		  curr_step = curr_step + 1
		  if curr_step > 7 then curr_step = 1 end
		elseif direction == -1 then
		  curr_step = curr_step - 1
		  if curr_step < 1 then curr_step = 7 end
		  new_pitch = new_pitch - Minor[curr_step]		  
		end
	end
	return new_pitch, curr_step	


end






--file read functions from https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua
function file_exists(name)
   local f=io.open(name,"r")
   if f~=nil then io.close(f) return true else return false end
end

function lines_from(file)
  if not file_exists(file) then return {} end
  local filelines = {}
  for line in io.lines(file) do 
    filelines[#filelines + 1] = line
  end
  return filelines
end

function mysplit (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end



--below is taken from https://gist.github.com/josefnpat/66423a53506888bacc89
function CountSyllables(word)
  local vowels = { 'a','e','i','o','u','y' }
  local numVowels = 0
  local lastWasVowel = false

  for i = 1, #word do
    local wc = string.sub(word,i,i)
    local foundVowel = false;
    for _,v in pairs(vowels) do
      if (v == string.lower(wc) and lastWasVowel) then
        foundVowel = true
        lastWasVowel = true
      elseif (v == string.lower(wc) and not lastWasVowel) then
        numVowels = numVowels + 1
        foundVowel = true
        lastWasVowel = true
      end
    end

    if not foundVowel then
      lastWasVowel = false
    end
  end

  local exception = false
  if string.len(word) > 2 and string.sub(word,string.len(word) - 1) == "es" then
    numVowels = numVowels - 1
    exception = true
  elseif string.len(word) > 1 and string.sub(word,string.len(word)) == "e" then
    numVowels = numVowels - 1
    exception = true
  end

  return exception and math.max(1,numVowels) or numVowels
end


--below is taken from https://lua-users.org/wiki/SaveTableToFile
function exportstring( s )
  return string.format("%q", s)
end

function table.save(tbl,filename )
      local charS,charE = "   ","\n"
      local file,err = io.open( filename, "wb" )
      if err then return err end

      -- initiate variables for save procedure
      local tables,lookup = { tbl },{ [tbl] = 1 }
      file:write( "return {"..charE )

      for idx,t in ipairs( tables ) do
         file:write( "-- Table: {"..idx.."}"..charE )
         file:write( "{"..charE )
         local thandled = {}

         for i,v in ipairs( t ) do
            thandled[i] = true
            local stype = type( v )
            -- only handle value
            if stype == "table" then
               if not lookup[v] then
                  table.insert( tables, v )
                  lookup[v] = #tables
               end
               file:write( charS.."{"..lookup[v].."},"..charE )
            elseif stype == "string" then
               file:write(  charS..exportstring( v )..","..charE )
            elseif stype == "number" then
               file:write(  charS..tostring( v )..","..charE )
            end
         end

         for i,v in pairs( t ) do
            -- escape handled values
            if (not thandled[i]) then
            
               local str = ""
               local stype = type( i )
               -- handle index
               if stype == "table" then
                  if not lookup[i] then
                     table.insert( tables,i )
                     lookup[i] = #tables
                  end
                  str = charS.."[{"..lookup[i].."}]="
               elseif stype == "string" then
                  str = charS.."["..exportstring( i ).."]="
               elseif stype == "number" then
                  str = charS.."["..tostring( i ).."]="
               end
            
               if str ~= "" then
                  stype = type( v )
                  -- handle value
                  if stype == "table" then
                     if not lookup[v] then
                        table.insert( tables,v )
                        lookup[v] = #tables
                     end
                     file:write( str.."{"..lookup[v].."},"..charE )
                  elseif stype == "string" then
                     file:write( str..exportstring( v )..","..charE )
                  elseif stype == "number" then
                     file:write( str..tostring( v )..","..charE )
                  end
               end
            end
         end
         file:write( "},"..charE )
      end
      file:write( "}" )
      file:close()
   end
   
   --// The Load Function
   function table.load( sfile )
      local ftables,err = loadfile( sfile )
      if err then return _,err end
      local tables = ftables()
      for idx = 1,#tables do
         local tolinki = {}
         for i,v in pairs( tables[idx] ) do
            if type( v ) == "table" then
               tables[idx][i] = tables[v[1]]
            end
            if type( i ) == "table" and tables[i[1]] then
               table.insert( tolinki,{ i,tables[i[1]] } )
            end
         end
         -- link indices
         for _,v in ipairs( tolinki ) do
            tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
         end
      end
      return tables[1]
   end
-- close do
