SCRIPT_TITLE = "Categorize Scripts v0.9"

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

BACK UP YOUR SCRIPT FOLDER STRUCTURE BEFORE RUNNING THIS SCRIPT!! I can not stress this enough. This will make alterations to the internals of many of your scripts. It's trying to support both Windows and Mac/Linux for text file manipulation. It works fine on my PC and my Mac, but that doesn't mean much.

This script will categorize SynthV scripts based upon their location in the script folder structure. For a Windows example, say your username is "JanetWeiss" and your scripts are located in the folder "C:\Users\JanetWeiss\Documents\Dreamtonics\Synthesizer V Studio\scripts\." Say you then created somne subfolders underneath there named "Hotkeys" and "Lyrics" and "Notes" and "Utilities." If you placed your scripts in the appropriate folder, then ran this script, it would go through and change their categories to match the folder name, so it would all be nice and neat in SynthV.

The script searches for folders only one level beneath the root. So files in "C:\Users\JanetWeiss\Documents\Dreamtonics\Synthesizer V Studio\scripts\Utilities\New\" will not be recategorized.

There are some special folders names:
IGNORE		If you put the word "ignore" in any folder name the contents of that folder will be bypassed for processing. 
ROOT		Any scripts in the script root folder itself will also be ignored.
DECLASSIFY	If you put the word "declassify" in any folder name, all categories will be removed from its scripts, so that it will show directly under the Scripts menu in SynthV.

----------------------------------------------------------------------------------------------------------------------------
注: すべて Google によって翻訳されているため、正確ではない可能性があります。

このスクリプトを実行する前に、スクリプト フォルダ構造をバックアップしてください!! 私はこれを十分に強調することはできません。 これにより、多くのスクリプトの内部が変更されます。 テキスト ファイルの操作については、Windows と Mac/Linux の両方をサポートしようとしています。 私の PC と Mac では問題なく動作しますが、あまり意味がありません。

このスクリプトは、スクリプト フォルダー構造内の場所に基づいて SynthV スクリプトを分類します。 Windows の例として、ユーザー名が「JanetWeiss」で、スクリプトが「C:\Users\JanetWeiss\Documents\Dreamtonics\Synthesizer V Studio\scripts\」フォルダーにあるとします。 次に、その下に「Hotkeys」、「Lyrics」、「Notes」、「Utilities」という名前のサブフォルダーを作成したとします。 スクリプトを適切なフォルダーに配置してからこのスクリプトを実行すると、フォルダー名に一致するようにカテゴリが変更されるため、SynthV ではすべてが適切に整理されます。

スクリプトは、ルートの 1 レベル下のフォルダーのみを検索します。 したがって、「C:\Users\JanetWeiss\Documents\Dreamtonics\Synthesizer V Studio\scripts\Utilities\New\」にあるファイルは再分類されません。

いくつかの特別なフォルダ名があります:
IGNORE フォルダ名に「ignore」という単語を入れると、そのフォルダの内容は処理のためにバイパスされます。
ROOT スクリプト ルート フォルダ自体のスクリプトも無視されます。
DECLASSIFY フォルダ名に「declassify」という単語を入れると、すべてのカテゴリがそのスクリプトから削除され、SynthV の [スクリプト] メニューのすぐ下に表示されます。

----------------------------------------------------------------------------------------------------------------------------
注意：所有翻译均由谷歌完成，因此可能不准确。

在运行此脚本之前备份您的脚本文件夹结构！！ 我怎么强调都不为过。 这将更改许多脚本的内部结构。 它试图同时支持 Windows 和 Mac/Linux 进行文本文件操作。 它在我的 PC 和 Mac 上运行良好，但这并不重要。

该脚本将根据脚本文件夹结构中的位置对 SynthV 脚本进行分类。 对于 Windows 示例，假设您的用户名是“JanetWeiss”，您的脚本位于文件夹“C:\Users\JanetWeiss\Documents\Dreamtonics\Synthesizer V Studio\scripts\”中。 假设您随后在其下创建了一些名为“Hotkeys”、“Lyrics”、“Notes”和“Utilities”的子文件夹。 如果您将脚本放在适当的文件夹中，然后运行此脚本，它将遍历并更改它们的类别以匹配文件夹名称，因此在 SynthV 中一切都会很好、很整洁。

该脚本仅搜索根目录下一级的文件夹。 因此“C:\Users\JanetWeiss\Documents\Dreamtonics\Synthesizer V Studio\scripts\Utilities\New\”中的文件不会被重新分类。

有一些特殊的文件夹名称：
IGNORE 如果您在任何文件夹名称中加上"IGNORE"一词，该文件夹的内容将被绕过进行处理。
ROOT 脚本根文件夹本身中的任何脚本也将被忽略。
DECLASSIFY 如果您在任何文件夹名称中添加"declassify"一词，所有类别将从其脚本中删除，以便它直接显示在 SynthV 的“脚本”菜单下。

--]]

-- Internationalization

function getTranslations(langCode)
  if langCode == "ja-jp" then
    return {
		{"Categorize Scripts v0.9","スクリプトの分類 v0.9"},	
		{"This will categorize scripts based on their folder structure. It searches for files only one level beneath the root. It won't alter any scripts in the script root folder or any in a folder with 'IGNORE' in its name.","これにより、フォルダー構造に基づいてスクリプトが分類されます。 ルートの 1 レベル下のファイルのみを検索します。 スクリプト ルート フォルダー内のスクリプトや、名前に「IGNORE」が含まれるフォルダー内のスクリプトは変更されません。"},	
		{"Input script folder location.", "入力スクリプト フォルダーの場所。"},
		{"I have a current backup of my script folder.","スクリプト フォルダーの現在のバックアップがあります。"},
		{"You need to tell me where the scripts are!\n\nFor Windows, they are usually in the Dreamtonics\\Synthesizer V Studio\\scripts\\ folder under your My Documents.\n\nFor Mac/Linux, in /Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/.","スクリプトの場所を教えてください!\n\nWindows の場合は、通常、マイ ドキュメントの下の Dreamtonics\\Synthesizer V Studio\\scripts\\ フォルダにあります。\n\nMac/Linux の場合は、/Library/ にあります。 アプリケーションのサポート/Dreamtonics/シンセサイザー V Studio/scripts/."},
		{"Processed ","処理済み "},
		{" scripts. Please hit Rescan in the Scripts menu!"," スクリプト。 Scripts メニューの Rescan をクリックしてください。"},
		{"Processed no scripts!","処理されたスクリプトはありません!"}, 
		{"Please create a current backup of your script folder and subfolders.","スクリプト フォルダとサブフォルダの現在のバックアップを作成してください。"},
		{"File ","ファイル "}, 
		{" cannot be written. Bypassing. Is the file set read-only?"," 書けません。 バイパス。 ファイルセットは読み取り専用ですか?"},
		{"Error processing file ","ファイル処理エラー "},
		{". No changes were made to it.",". 変更は加えられていません。"},
		{"Altered by Categorize script","Categorize スクリプトによる変更"},
    }
  end
  if langCode == "zh-cn" then
    return {
		{"Categorize Scripts v0.9","分类脚本 v0.9"},	
		{"This will categorize scripts based on their folder structure. It searches for files only one level beneath the root. It won't alter any scripts in the script root folder or any in a folder with 'IGNORE' in its name.","这将根据脚本的文件夹结构对脚本进行分类。 它仅搜索根目录下一级的文件。 它不会更改脚本根文件夹中的任何脚本或名称中带有“忽略”的文件夹中的任何脚本。"},
		{"Input script folder location.", "输入脚本文件夹位置。"},		
		{"I have a current backup of my script folder.","我有我的脚本文件夹的当前备份。"},
		{"You need to tell me where the scripts are!\n\nFor Windows, they are usually in the Dreamtonics\\Synthesizer V Studio\\scripts\\ folder under your My Documents.\n\nFor Mac/Linux, in /Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/.","你需要告诉我脚本在哪里！\n\n对于 Windows，它们通常在我的文档下的 Dreamtonics\\Synthesizer V Studio\\scripts\\ 文件夹中。\n\n对于 Mac/Linux，在 /Library/ 应用程序支持/Dreamtonics/Synthesizer V Studio/scripts/."},
		{"Processed ","处理 "},
		{" scripts. Please hit Rescan in the Scripts menu!"," 脚本。 请点击脚本菜单中的重新扫描！"},
		{"Processed no scripts!","没有处理脚本！"}, 
		{"Please create a current backup of your script folder and subfolders.","请创建脚本文件夹和子文件夹的当前备份。"},
		{"File ","文件 "}, 
		{" cannot be written. Bypassing. Is the file set read-only?"," 不能写。 通过传递。 文件集是只读的吗？"},
		{"Error processing file ","错误处理文件 "},
		{". No changes were made to it.",". 没有对其进行任何更改。"},
		{"Altered by Categorize script","由分类脚本更改"},
    }
  end
  return {}
end


processed_count = 0
function main()
	local OS = determine_OS()
	local def_cfgfile = "categorizescripts.cfg"
	if OS ~= "Windows" then  -- "macOS", "Linux", "Unknown"
		def_cfgfile = os.getenv("HOME") .. "/" .. def_cfgfile
	end
	local mydefaults = {}, err
	mydefaults.script_folder_name = ""
	if OS ~= "Windows" then
		if folder_exists("/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/", OS) == true then
			mydefaults.script_folder_name = "/Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/"
		end
	else  -- "Windows",
		local docfolder = os.getenv("USERPROFILE")
		if docfolder then 
			docfolder = docfolder .. "\\Documents\\Dreamtonics\\Synthesizer V Studio\\scripts\\"
			if folder_exists(docfolder, OS) == true then
				mydefaults.script_folder_name = docfolder
			end
		end	
	   
	end		

	if file_exists(def_cfgfile) then
		mydefaults,err = table.load( def_cfgfile )
		assert( err == nil )
		if mydefaults.script_folder_name == "\\" then mydefaults.script_folder_name = "" end
	end
	
	local form = {
		title = SV:T(SCRIPT_TITLE),
		message = SV:T("This will categorize scripts based on their folder structure. It searches for files only one level beneath the root. It won't alter any scripts in the script root folder or any in a folder with 'IGNORE' in its name."),
		buttons = "OkCancel",
		widgets = {
			{
				name = "script_folder_name",
				type = "TextBox",
				label = SV:T("Input script folder location. "),
				default = mydefaults.script_folder_name,
			},			
			{
				name = "GoodBackup",
				type = "CheckBox",
				text = SV:T("I have a current backup of my script folder."),
				default = false
			},
		},
	}
	local results = SV:showCustomDialog(form)
	if results.status then
		if results.answers.GoodBackup == true then
			local script_folder_name = results.answers.script_folder_name
			if script_folder_name == "" then
				SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("You need to tell me where the scripts are!\n\nFor Windows, they are usually in the Dreamtonics\\Synthesizer V Studio\\scripts\\ folder under your My Documents.\n\nFor Mac/Linux, in /Library/Application Support/Dreamtonics/Synthesizer V Studio/scripts/."))
				SV:finish()				
				return
			end
			
			if OS ~= "Windows" then  --"macOS", "Linux", "Unknown"
				if script_folder_name:sub(-1) ~= "/" then 
					script_folder_name = script_folder_name .. "/" 
				end
				script_folder_name = string.gsub(script_folder_name,' ', '\\ ')
			else  --"Windows", 
				if script_folder_name:sub(-1) ~= "\\" then 
					script_folder_name = script_folder_name .. "\\" 
				end
			end
			script_folder_name = string.gsub(script_folder_name,'\\\\', '\\')								
			mydefaults.script_folder_name = script_folder_name
			table.save(mydefaults,def_cfgfile)				
			
			local full_folderlist, folderlist 
			folderlist, full_folderlist = scandir(script_folder_name, OS)
			

			local filelistJS = {}
			local filelistLUA = {}	
			for k,v in pairs(full_folderlist) do
				filelistJS[k] = getfilelist(v, "JS", OS)	
				filelistLUA[k] = getfilelist(v, "LUA", OS)	
			end	
			for k,filelist in pairs(filelistLUA) do
				for m,filename in pairs(filelist) do
					local flfile 
					flfile = script_folder_name .. folderlist[k] .. "\\" .. filename
					if OS ~= "Windows" then		
						flfile = script_folder_name .. folderlist[k] .. "/" .. filename					
						flfile = string.gsub(flfile,'//', '/')							
						flfile = string.gsub(flfile,'\\ ', ' ')	
					end
					replace_category(folderlist[k],flfile,"LUA")
				end	
			end
			for k,filelist in pairs(filelistJS) do
				for m,filename in pairs(filelist) do
					local flfile 
					flfile = script_folder_name .. folderlist[k] .. "\\" .. filename
					if OS ~= "Windows" then		
						flfile = script_folder_name .. folderlist[k] .. "/" .. filename					
						flfile = string.gsub(flfile,'//', '/')							
						flfile = string.gsub(flfile,'\\ ', ' ')	
					end
					replace_category(folderlist[k],flfile,"JS")
				end	
			end
			local results = SV:T("Processed ") .. processed_count .. SV:T(" scripts. Please hit Rescan in the Scripts menu!")
			if processed_count == 0 then results = SV:T("Processed no scripts!") end
				
			SV:showMessageBox(SV:T(SCRIPT_TITLE), results)
			SV:finish()
		else
			SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("Please create a current backup of your script folder and subfolders."))
		end
		
	end
end

function scandir(directory, OS)	
    local i, dir, popen = 0, {}, io.popen
	local full_dir = {}
    local pfile
	if OS ~= "Windows" then
		local tempfilename = os.tmpname()
		os.execute([[ls -d ]] .. directory .. [[*/ >> ]] .. tempfilename)
		if file_exists(tempfilename) then
			pfile = lines_from(tempfilename)
			os.remove(tempfilename)
			for _,foldername in pairs(pfile) do
				local testname = string.lower(foldername)
				if string.find(testname,"ignore") == nil then
					foldername = string.gsub(foldername,"//","/")
					i = i + 1
					full_dir[i] = foldername
					local start = 0, searchnew, searchold
					while true do
					  start = string.find(foldername, "/", start+1)    -- find 'next' newline
					  if start == nil then break end
					  searchold = searchnew
					  searchnew = start
					end
					dir[i] = string.sub(foldername,searchold+1)		
					dir[i] = string.gsub(dir[i],"/","")
				end	
			end
		end	
	else
		pfile = popen('dir "'..directory..'" /b /ad')
		for filename in pfile:lines() do
			local testname = string.lower(filename)
			if string.find(testname,"ignore") == nil then
				i = i + 1
				dir[i] = filename
				full_dir[i] = directory .. filename		
			end
		end
		pfile:close()
		
	end	
    return dir, full_dir
end

function getfilelist(directory, ScriptType, OS)	
    local i, fname, popen = 0, {}, io.popen
	local pfile;
	if OS ~= "Windows" then	
		directory = string.gsub(directory,' ', '\\ ')
		local tempfilename = os.tmpname()
		if ScriptType == "LUA" then
			os.execute([[ls -A ]] .. directory .. [[*.lua >> ]] .. tempfilename)
		else
			os.execute([[ls -A ]] .. directory .. [[*.js >> ]] .. tempfilename)
		end
		if file_exists(tempfilename) then
			pfile = lines_from(tempfilename)
			os.remove(tempfilename)
			for _,filename in pairs(pfile) do
				i = i + 1
				local start = 0
				local searchnew = 0
				while true do
				  start = string.find(filename, "/", start+1) 
				  if start == nil then break end
				  searchnew = start
				end
				fname[i] = string.sub(filename,searchnew)		
				fname[i] = string.gsub(fname[i],"/","")
			end
		end
	else  --windows
		if ScriptType == "JS" then
			pfile = popen('dir "'..directory..'"\\*.js /b')
		else
			pfile = popen('dir "'..directory..'"\\*.lua /b')	
		end
		for filename in pfile:lines() do
			i = i + 1
			fname[i] = filename
		end
		pfile:close()
	end	
    return fname
end



function replace_category(new_category, full_file_name, scripttype)
	if file_exists(full_file_name) then
		if string.find(string.lower(new_category),"declassify") ~= nil then new_category = "" end
        local searchstring = {}
		if scripttype == "JS" then
			searchstring = {'"category":',"'category':","category:"}
		else
			searchstring = {'category='}
		end
	
		local filelines = lines_from(full_file_name)
		local count = 0
		local foundline = -1
		local nospaces
		local test = -1
		local tt = 0
		local replacestring 
		if scripttype == "JS" then
			replacestring = '     "category": "' .. new_category .. '",  // '.. SV:T("Altered by Categorize script") .. '"'
		else
			replacestring = '     category = "' .. new_category .. '", -- '.. SV:T("Altered by Categorize script") .. '"'
		end
		for k,textline in pairs(filelines) do
			nospaces = string.lower(textline:gsub('%s', ''))
			for _,l in pairs(searchstring) do
				test = string.find(nospaces,l)
				if test ~= nil then
					foundline = k
					break
				end
			end
			if foundline ~= -1 then break end
		end
		if foundline ~= -1 then
			filelines[foundline] = replacestring
			if file_is_writable(full_file_name) then
				local filehandle = assert(io.open(full_file_name, 'w'))
				for index, value in ipairs(filelines) do
					filehandle:write(value..'\n')
				end
				filehandle:flush()			
				io.close(filehandle)
				processed_count = processed_count + 1
			else
				local proc_text =  SV:T("File ") .. full_file_name .. SV:T(" cannot be written. Bypassing. Is the file set read-only?")
				SV:showMessageBox(SV:T(SCRIPT_TITLE), proc_text)
			end
		else
			local clientFuncLoc = -1		
			for p,textline in pairs(filelines) do
				test = string.find(textline,"getClientInfo")
				if test ~= nil then
					clientFuncLoc = p
					break
				end
				if clientFuncLoc ~= -1 then break end
			end
			if clientFuncLoc ~= -1 then
				table.insert(filelines, clientFuncLoc + 3, replacestring)
				if file_is_writable(full_file_name) then
					local filehandle = assert(io.open(full_file_name, 'w'))
					for index, value in ipairs(filelines) do
						filehandle:write(value..'\n')
					end	
					filehandle:flush()
					io.close(filehandle)
					processed_count = processed_count + 1
				else	
					local proc_text =  SV:T("File ") .. full_file_name .. SV:T(" cannot be written. Bypassing. Is the file set read-only?")
					SV:showMessageBox(SV:T(SCRIPT_TITLE), proc_text)
				end
				
			else
				local proc_text =  SV:T("Error processing file ") .. full_file_name .. SV:T(". No changes were made to it.")
				SV:showMessageBox(SV:T(SCRIPT_TITLE), proc_text)
			end	
		end		
	else	
		SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("File not found."))
	end	
end
	

function determine_OS()
	local hostinfo = SV:getHostInfo()
	return hostinfo.osType
end


--file read functions from https://stackoverflow.com/questions/11201262/how-to-read-data-from-a-file-in-lua and elsewhere


function exists(file)
  -- some error codes:
  -- 13 : EACCES - Permission denied
  -- 17 : EEXIST - File exists
  -- 20	: ENOTDIR - Not a directory
  -- 21	: EISDIR - Is a directory
  local isok, errstr, errcode = os.rename(file, file)
  if isok == nil then
     if errcode == 13 then 
        -- Permission denied, but it exists
        return true
     end
     return false
  end
  return true
end

function folder_exists(foldername, OS)
	if OS ~= "Windows" then  -- "macOS", "Linux", "Unknown"
		if foldername:sub(-1) ~= "/" then foldername = foldername .. "/" end
	else	 -- "Windows",
		if foldername:sub(-1) ~= "\\" then foldername = foldername .. "\\" end	
	end
	return exists(foldername)
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

function file_is_writable(name)
	local f=io.open(name,"w")
	if f~=nil then 
		io.close(f) 
		return true 
	else 
		return false 
	end	
end


function lines_from(file)
  if not file_exists(file) then return {} end
  local filelines = {}
  for line in io.lines(file) do 
    filelines[#filelines + 1] = line
  end
  return filelines
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

