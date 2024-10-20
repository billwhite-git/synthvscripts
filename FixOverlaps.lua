SCRIPT_TITLE = "Fix Overlaps"

--[[
This script will remember settings between runs. To make it automatic, set the parameters as desired and check the box "Save as defaults and don't prompt again." If you do that and you change your mind, you'll need to find and delete the file "fixoverlaps.cfg." On Windows, it's usually at "C:\Program Files\Synthesizer V Studio Pro\fixoverlaps.cfg," and on Mac, in your Home folder.
--------------------------------------------------------------------------------------------------
このスクリプトは、実行間の設定を記憶します。 自動化するには、必要に応じてパラメータを設定し、[デフォルトとして保存して、再度プロンプトを表示しない] チェックボックスをオンにします。 それを行って気が変わった場合は、ファイル「fixoverlaps.cfg」を見つけて削除する必要があります。 通常、Windows では「C:\Program Files\Synthesizer V Studio Pro\fixoverlaps.cfg」にあり、Mac ではホーム フォルダーにあります。
--------------------------------------------------------------------------------------------------
此脚本将记住运行之间的设置。 要使其自动运行，请根据需要设置参数并选中“保存为默认值并且不再提示”框。 如果您这样做后改变了主意，您将需要找到并删除文件“fixoverlaps.cfg”。 在 Windows 上，它通常位于“C:\Program Files\Synthesizer V Studio Pro\fixoverlaps.cfg”，在 Mac 上，位于您的主文件夹中。
--]]


processed_count = 0

function getClientInfo() 
  return {
    name = SV:T(SCRIPT_TITLE),
    author = "Bill White based on DreamTonics 'Remove Silences' script",
    versionNumber = 1,
    minEditorVersion = 66048,
  }
end

function getTranslations(langCode) 
	if(langCode == "ja-jp") then
		return {
			{"Fix Overlaps", "重複を修正"},
			{"Method", "方法"},
			{"Preserve First Note", "最初の音を保持する"},
			{"Split the Difference", "違いを分割する"},
			{"Preserve Second Note", "2番目の音符を保存する"},
			{"Scope", "スコープ"},
			{"Selected Notes", "選択されたノート"},
			{"Current Track", "現在のトラック"},
			{"Entire Project", "プロジェクト全体"},
			{"Save as defaults and don't prompt again.", "デフォルトとして保存し、再度プロンプトを表示しません。"},
			{"These settings will be saved as default and run automatically whenever you invoke this script. To reset behavior, delete the file ", "これらの設定はデフォルトとして保存され、このスクリプトを呼び出すたびに自動的に実行されます。 動作をリセットするには、ファイルを削除します "},
			{"This process will create a note that ends before it begins. I can't handle that.","このプロセスにより、開始前に終了するノートが作成されます。私にはそれができません。"},
			{"No overlaps found.","重複は見つかりませんでした。"}
		}
		end
	if(langCode == "zh-cn") then
		return {
			{"Fix Overlaps", "修复重叠"},
			{"Method", "方法"},
			{"Preserve First Note", "保留第一个音符"},
			{"Split the Difference", "平分秋色"},
			{"Preserve Second Note", "保留第二个音符"},
			{"Scope", "作用范围"},
			{"Selected Notes", "所选音符"},
			{"Current Track", "当前音轨"},
			{"Entire Project", "整个项目"},
			{"Save as defaults and don't prompt again.", "保存为默认值，不再提示。"},
			{"These settings will be saved as default and run automatically whenever you invoke this script. To reset behavior, delete the file ", "这些设置将保存为默认设置，并在您调用此脚本时自动运行。 要重置行为，请删除文件 "},
			{"This process will create a note that ends before it begins. I can't handle that.","此过程将创建一个在开始之前结束的注释。我无法处理这个。"},
			{"No overlaps found.","没有发现重叠。"}
		}
		end
	return {}
end

function noteGetter(tNoteGoup, index, groupType) 
	if groupType == "array" then
		return tNoteGoup[index]
	else 
		return tNoteGoup:getNote(index)
  end
end

function showErrMsg() 
	SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("This process will create a note that ends before it begins. I can't handle that."))
end

function processNoteSequence(tNoteGoup, N, method, groupType) 
  for i = 2, N do
    local currOnset = noteGetter(tNoteGoup, i, groupType):getOnset()
    local prevEnd = noteGetter(tNoteGoup, i-1,groupType):getEnd()
    if (currOnset < prevEnd) then
		local prevnote = noteGetter(tNoteGoup, i - 1,groupType)
		local currnote = noteGetter(tNoteGoup, i ,groupType)
		local prevOnset = prevnote:getOnset()
		local currDuration = currnote:getDuration()		
		local prevDuration = prevnote:getDuration()		
		local difference = prevEnd - currOnset
	    local splitDiff = math.floor(difference / 2)
		if method == 0 then     --Preserve First Note
		    if currDuration - difference > 0 then
				currnote:setOnset(prevOnset + prevDuration)
				currnote:setDuration(currDuration - difference)
			else
				showErrMsg()
			end
		elseif method == 1 then   --Split the Difference
		    if prevDuration - splitDiff > 0 and currDuration - splitDiff > 0 then		
				prevnote:setDuration(prevDuration - splitDiff)		
				currnote:setDuration(currDuration - splitDiff)					
				currnote:setOnset(prevOnset + prevDuration - splitDiff)
			else
				showErrMsg()
			end
		else   --Preserve Second Note 
		    if currOnset - prevOnset > 0 then				
				prevnote:setDuration(currOnset - prevOnset)
			else
				showErrMsg()
			end
		end
		processed_count = processed_count + 1
    end
  end
end

function determine_OS()
	local hostinfo = SV:getHostInfo()
	return hostinfo.osType
end

function readConfig()
	local OS = determine_OS()
	local def_cfgfile = "fixoverlaps.cfg"
	if OS ~= "Windows" then  -- "macOS", "Linux", "Unknown"
		def_cfgfile = os.getenv("HOME") .. "/" .. def_cfgfile
	end
	local mydefaults = {}, err
	if file_exists(def_cfgfile) then
		mydefaults,err = table.load( def_cfgfile )
		for idx,t in pairs( mydefaults ) do
			if t == "saved_false" then
				mydefaults[idx] = false	
			elseif t == "saved_true" then
				mydefaults[idx] = true
			end
		end
		assert( err == nil )
	else
		mydefaults.scope = 1
		mydefaults.method = 1
		mydefaults.stopprompt = false
	end
	return mydefaults, def_cfgfile
end

function saveConfig(mydefaults, configfilename)
	for idx,t in pairs( mydefaults ) do
		if t == false then
			mydefaults[idx] = "saved_false"
		elseif t == true then
			mydefaults[idx] = "saved_true"
		end
	end
	table.save(mydefaults, configfilename)
end


function main() 
	local mydefaults = {}
	local def_cfgfile
	mydefaults, def_cfgfile = readConfig()
	local myForm = {
		title = SV:T("Fix Overlaps"),
		buttons = "OkCancel",
		widgets = {
			{
				name = "method", 
				type = "ComboBox",
				label = SV:T("Method"),
				choices = {SV:T("Preserve First Note"), SV:T("Split the Difference"), SV:T("Preserve Second Note")},
				default = mydefaults.method
			},
			{
				name = "scope", 
				type = "ComboBox",
				label = SV:T("Scope"),
				choices = {SV:T("Selected Notes"), SV:T("Current Track"), SV:T("Entire Project")},
				default = mydefaults.scope
			},
			{
				name = "stopprompt",
				type = "CheckBox",
				text = SV:T("Save as defaults and don't prompt again."),
				default = mydefaults.stopprompt
			},
			
		}
	}
	local result = {}
	if mydefaults.stopprompt == false then
		result = SV:showCustomDialog(myForm)
		if result.status == true and result.answers.stopprompt == true then
			SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("These settings will be saved as default and run automatically whenever you invoke this script. To reset behavior, delete the file " .. def_cfgfile))			
		end
	else
		result.status = true
		result.answers = mydefaults
	end	
	local method = result.answers.method
	local groupType = "group"
	if result.status == true then
		mydefaults = result.answers
		saveConfig(mydefaults, def_cfgfile)
		if result.answers.scope == 0 then
			local selection = SV:getMainEditor():getSelection()
			local selectedNotes = selection:getSelectedNotes()
			table.sort(selectedNotes, function(noteA, noteB) return noteA:getOnset() < noteB:getOnset()	end )
			groupType = "array"
			processNoteSequence(selectedNotes, #selectedNotes, method, groupType)
		elseif result.answers.scope == 1 then
			local track = SV:getMainEditor():getCurrentTrack()
			local trackGroupN = track:getNumGroups()
			local visited = {}
			for i = 1, trackGroupN do
				local group = track:getGroupReference(i):getTarget()
				if visited[group:getUUID()] == nil then
					processNoteSequence(group, group:getNumNotes(), method, groupType)
					visited[group:getUUID()] = 1
				end
			end
		else 
			local project = SV:getProject()
			local numNoteGroups = project:getNumNoteGroupsInLibrary()		
			for i = 1, numNoteGroups do
				local group = project:getNoteGroup(i)
				processNoteSequence(group, group:getNumNotes(), method, groupType)
			end
			for i = 1, project:getNumTracks() do
				local track = project:getTrack(i)
				local mainGroup = track:getGroupReference(1):getTarget()
				processNoteSequence(mainGroup, mainGroup:getNumNotes(), method, groupType)
			end
		end
	end
	if processed_count == 0 then SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("No overlaps found.")) end
	SV:finish()
end



--below is taken from https://lua-users.org/wiki/SaveTableToFile
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

function exportstring( s )
  return string.format("%q", s)
end


function file_exists(name)
	local f=io.open(name,"r")
	if f~=nil then 
		io.close(f) 
		return true 
	else 
		return false 
	end	
end
