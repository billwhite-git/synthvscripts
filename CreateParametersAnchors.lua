SCRIPT_TITLE = "Create Parameter Anchors v0.91"

--[[

Pretty self-explanatory. If you assign a voice to a track and sdave it, this will be able to add anchors to the voice mode parameters as well.
Roughly based upon the Randomize Parameters script from Dreamtonics. Big shout out to iviachupichu for this! https://forum.synthesizerv.com/t/topic/8091/2 for the Vocal Mode Dictionary!

かなり自明です。 ボイスをトラックに割り当てて sdave すると、ボイス モード パラメータにもアンカーを追加できます。
Dreamtonics の Randomize Parameters スクリプトに大まかに基づいています。 これについてはiviachupichuに大声で叫ぶ！ ボーカルモード辞典はhttps://forum.synthesizerv.com/t/topic/8091/2！


非常不言自明。 如果您将声音分配给轨道并保存它，这也可以将锚点添加到声音模式参数。
大致基于 Dreamtonics 的随机化参数脚本。 为此向 iviachupichu 大声喊叫！ https://forum.synthesizerv.com/t/topic/8091/2 人声模式词典！
--]]





--BIG thanks to iviachupichu for this! https://forum.synthesizerv.com/t/topic/8091/2
vocalModeDictionary = {
	["An Xiao"] = {"Airy", "Chest", "Open", "Power", "Soft"};
	["ANRI"] = {"Emotive", "Charm", "Chill", "Light"};
	["ASTERIAN"] = {"Clear", "Warm", "Gentle", "Strained", "Rough", "Open", "Closed", "Passionate", "Theatrical"};
	["Cheng Xiao"] = {"Open", "Closed", "Resonant"};
	["Cong Zheng"] = {"Soft", "Gentle", "Closed", "Vivid", "Solid", "Powerful"};
	["Eleanor Forte AI"] = {"Melancholic", "Solid", "Warm", "Powerful", "Dark", "Clear", "Tender", "Bold"};
	["Feng Yi"] = {"Chest", "Power", "Open", "Opera", "Soft", "Airy"};
	["Hanakuma Chifuyu AI"] = {"Kawaii", "Soft", "Rock", "Adult", "Piano_Ballade"};
	["JUN"] = {"Dark", "Chest", "Soul", "Power", "Light", "Tsubaki", "Soft"};
	["Koharu Rikka AI"] = {"Kawaii", "Soft", "Pops", "Emotional", "Ballade"};
	["Kevin"] = {"Belt", "Clear", "Soft", "Solid"};
	["Kyomachi Seika AI"] = {"Breathy", "Bright", "Straight", "Tight"};
	["Mai"] = {"Emotional", "Soft"};
	["MEDIUM5 Stardust"] = {"Airy", "Bright", "Cool", "Dark", "Emotional", "Power", "Solid", "Sweet"};
	["Mo Chen"] = {"Open", "Soft", "Clear"};
	["Natalie"] = {"Soft", "Soulful", "Steady", "Bold", "Warm"};
	["Natsuki Karin AI"] = {"Kawaii", "Soft", "Cool", "Happy", "Falsetto"};
	["Ninezero"] = {"Solid", "Overdrive", "Muted"};
	["Qing Su"] = {"Airy", "Chest", "Power", "Soft", "Sweet"};
	["Ryo"] = {"Open", "Soft", "Airy", "Clear", "Nasal", "Resonant"};
	["Saki AI"] = {"Chest", "Airy", "Open", "Soft"};
	["SOLARIA"] = {"Clear", "Soft", "Airy", "Power", "Passionate", "Solid", "Light"};
	["Tsuina-Chan AI"] = {"Attacky", "Breathy", "Crispy", "Soft"};
	["Tsurumaki Maki AI"] = {"Adult", "Breathy", "Power_Pop", "Twangy", "Whisper"};
	["Weina"] = {"Delicate", "Tender", "Lucid", "Firm", "Powerful", "Resonant", "Warm"};
	["Xia Yu Yao"] = {"Dark", "Soft", "Solid", "Whisper", "Sweet"};
	["Xuan Yu"] = {"Soft", "Light", "Passionate", "Solid", "Open"};
	["Yuma"] = {"Gentle", "Airy", "Powerful", "Solid"};
};


function getClientInfo()
  return {
    name = SV:T(SCRIPT_TITLE),
    author = "Bill White",
    versionNumber = 1,
    minEditorVersion = 65537,
  }
end

function getTranslations(langCode)
  if langCode == "ja-jp" then
    return {
      {"Please save file first.", "最初にファイルを保存してください。"},    
      {"No selection. Please select one or more notes.", "選択なし。 1 つまたは複数のメモを選択してください。"},    	  
      {"Place handle points inside notes.", "ノート内にハンドル ポイントを配置します。"},    	  
      {"Create Parameter Anchors", "パラメータ アンカーを作成する"},    	  	  
	  }
  end
  if langCode == "zh-cn" then
    return {
      {"Please save file first.", "请先保存文件。"},    
      {"No selection. Please select one or more notes.", "没有选择。 请选择一个或多个注释。"},    
      {"Place handle points inside notes.", "将手柄点放在注释中。"},    	  
      {"Create Parameter Anchors", "创建参数锚点"},    	  	  
    }
  end
  return {}
end



function readAll(file)
    local f = assert(io.open(file, "rb"))
    local content = f:read("*all")
    f:close()
    return content
end


function get_vocalmodes(tracks)
	vocalmodes = {}
	local currentrackname = SV:getMainEditor():getCurrentTrack():getName()
	local currentVoiceName = ""
	for i = 1, #tracks do
		if currentrackname == tracks[i].name then 
			currentVoiceName = tracks[i].mainRef.database.name
			break
		end	
	end
	if currentVoiceName ~= "" then
		vocalmodes = vocalModeDictionary[currentVoiceName]
		return vocalmodes
	end
	return nil
end


function main()
	local selection = SV:getMainEditor():getSelection()
	local selectedNotes = selection:getSelectedNotes()
	if #selectedNotes == 0 then
		SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("No selection. Please select one or more notes."))
	else	
		load_json()
		local scope = SV:getMainEditor():getCurrentGroup()
		local group = scope:getTarget()
		local ranges = getSelectedRanges()

		local filename = SV:getProject():getFileName()
		if filename == "" then
			SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("Please save file first."))
		else	
			local json_content = readAll(filename)
			local js = json.parse(json_content)
			local tracks = js.tracks
			local vocalmodeslist = get_vocalmodes(tracks)


		--if nil then

			local widget_build = {}
			local paramnames = {}
			widget_build = {
				{
				name = "doAll",
				type = "CheckBox",
				text = SV:T("ALL"),
				default = false,
				},
				{
				name = "pitchDelta",
				type = "CheckBox",
				text = SV:T("Pitch Deviation"),
				default = false,
				},
				{
				name = "vibratoEnv",
				type = "CheckBox",
				text = SV:T("Vibrato Envelope"),
				default = false,
				},
				{
				name = "loudness",
				type = "CheckBox",
				text = SV:T("Loudness"),
				default = false,
				},
				{
				name = "tension",
				type = "CheckBox",
				text = SV:T("Tension"),
				default = false,
				},
				{
				name = "breathiness",
				type = "CheckBox",
				text = SV:T("Breathiness"),
				default = false,
				},
				{
				name = "voicing",
				type = "CheckBox",
				text = SV:T("Voicing"),
				default = false,
				},
				{
				name = "gender",
				type = "CheckBox",
				text = SV:T("Gender"),
				default = false,
				},	
				{
				name = "toneShift",
				type = "CheckBox",
				text = SV:T("Tone Shift"),
				default = false,
				},	
			}
			if vocalmodeslist ~= nil then
				for i = 1, #vocalmodeslist do
					local this_widget = 
					{
						name = "vocalMode_" .. vocalmodeslist[i],
						type = "CheckBox",
						text = SV:T(vocalmodeslist[i]),
						default = false,
					}
					widget_build[#widget_build + 1] = this_widget
				end	
			end	
			widget_build[#widget_build + 1] = {
				name = "", type = "TextArea",
				label = "",
				height = 0,
				default = "",
				}				
			widget_build[#widget_build + 1] = {
				name = "midpoint",
				type = "CheckBox",
				text = SV:T("Place handle points inside notes."),
				default = false,
				}


			for i = 1, #widget_build do
				paramnames[i] = widget_build[i].name
			end
			local form = {
				title = SV:T(SCRIPT_TITLE),
				message = "",
				buttons = "OkCancel",
				widgets = widget_build,
			}
			local results = SV:showCustomDialog(form)
			if results.status then anchorize(results.answers, paramnames) end
		end  
	end		
	SV:finish()
end

-- Get an array of blick ranges for connected notes in the selection
function getSelectedRanges()
	local selection = SV:getMainEditor():getSelection()
	local selectedNotes = selection:getSelectedNotes()
	if #selectedNotes == 0 then
		return {}
	end
	table.sort(selectedNotes, function(noteA, noteB)
		return noteA:getOnset() < noteB:getOnset()
	end)

	local ranges = {}
	local bStart = selectedNotes[1]:getOnset()
	local bEnd = selectedNotes[1]:getEnd()
	for i = 2, #selectedNotes do
		ranges[#ranges + 1] = {bStart, bEnd}	  
		bStart = selectedNotes[i]:getOnset()
		bEnd = selectedNotes[i]:getEnd()
	end
	ranges[#ranges + 1] = {bStart, bEnd}  
	return ranges
end

function anchorize(options, paramnames)
	local scope = SV:getMainEditor():getCurrentGroup()
	local group = scope:getTarget()
	local ranges = getSelectedRanges()
	local count= 0	
	local doAll = options.doAll
	local addMid = options.midpoint
	
	if doAll == true then
		for n = 1, #paramnames do options[paramnames[n]] = true end
	end
	options.doAll = false
	options.midpoint = false

	for n = 1, #paramnames do
		if options[paramnames[n]] == true then
			local am = group:getParameter(paramnames[n])
			for i, r in ipairs(ranges) do
				if r[2] - r[1] > 1000 then
					local origLeft, origRight = am:get(r[1]), am:get(r[2])
					if addMid == true then
						local mid = (r[2] - r[1])*.125 + r[1]
						local origmid = am:get(mid)
						am:add(mid, origmid)				   
						mid = (r[2] - r[1])*.875 + r[1]
						origmid = am:get(mid)
						am:add(mid, origmid)				   
					end
					am:add(r[1], origLeft)
					am:add(r[2], origRight)
					local b = r[1]
				end	
			end
		end
	end
end


--https://gist.github.com/tylerneylon/59f4bcf316be525b30ab
--[[ json.lua

A compact pure-Lua JSON library.
The main functions are: json.stringify, json.parse.

## json.stringify:

This expects the following to be true of any tables being encoded:
 * They only have string or number keys. Number keys must be represented as
   strings in json; this is part of the json spec.
 * They are not recursive. Such a structure cannot be specified in json.

A Lua table is considered to be an array if and only if its set of keys is a
consecutive sequence of positive integers starting at 1. Arrays are encoded like
so: `[2, 3, false, "hi"]`. Any other type of Lua table is encoded as a json
object, encoded like so: `{"key1": 2, "key2": false}`.

Because the Lua nil value cannot be a key, and as a table value is considerd
equivalent to a missing key, there is no way to express the json "null" value in
a Lua table. The only way this will output "null" is if your entire input obj is
nil itself.

An empty Lua table, {}, could be considered either a json object or array -
it's an ambiguous edge case. We choose to treat this as an object as it is the
more general type.

To be clear, none of the above considerations is a limitation of this code.
Rather, it is what we get when we completely observe the json specification for
as arbitrary a Lua object as json is capable of expressing.

## json.parse:

This function parses json, with the exception that it does not pay attention to
\u-escaped unicode code points in strings.

It is difficult for Lua to return null as a value. In order to prevent the loss
of keys with a null value in a json string, this function uses the one-off
table value json.null (which is just an empty table) to indicate null values.
This way you can check if a value is null with the conditional
`val == json.null`.

If you have control over the data and are using Lua, I would recommend just
avoiding null values in your data to begin with.

--]]

function load_json()
	json = {}


	-- Internal functions.

	local function kind_of(obj)
	  if type(obj) ~= 'table' then return type(obj) end
	  local i = 1
	  for _ in pairs(obj) do
		if obj[i] ~= nil then i = i + 1 else return 'table' end
	  end
	  if i == 1 then return 'table' else return 'array' end
	end

	local function escape_str(s)
	  local in_char  = {'\\', '"', '/', '\b', '\f', '\n', '\r', '\t'}
	  local out_char = {'\\', '"', '/',  'b',  'f',  'n',  'r',  't'}
	  for i, c in ipairs(in_char) do
		s = s:gsub(c, '\\' .. out_char[i])
	  end
	  return s
	end

	-- Returns pos, did_find; there are two cases:
	-- 1. Delimiter found: pos = pos after leading space + delim; did_find = true.
	-- 2. Delimiter not found: pos = pos after leading space;     did_find = false.
	-- This throws an error if err_if_missing is true and the delim is not found.
	local function skip_delim(str, pos, delim, err_if_missing)
	  pos = pos + #str:match('^%s*', pos)
	  if str:sub(pos, pos) ~= delim then
		if err_if_missing then
		  error('Expected ' .. delim .. ' near position ' .. pos)
		end
		return pos, false
	  end
	  return pos + 1, true
	end

	-- Expects the given pos to be the first character after the opening quote.
	-- Returns val, pos; the returned pos is after the closing quote character.
	local function parse_str_val(str, pos, val)
	  val = val or ''
	  local early_end_error = 'End of input found while parsing string.'
	  if pos > #str then error(early_end_error) end
	  local c = str:sub(pos, pos)
	  if c == '"'  then return val, pos + 1 end
	  if c ~= '\\' then return parse_str_val(str, pos + 1, val .. c) end
	  -- We must have a \ character.
	  local esc_map = {b = '\b', f = '\f', n = '\n', r = '\r', t = '\t'}
	  local nextc = str:sub(pos + 1, pos + 1)
	  if not nextc then error(early_end_error) end
	  return parse_str_val(str, pos + 2, val .. (esc_map[nextc] or nextc))
	end

	-- Returns val, pos; the returned pos is after the number's final character.
	local function parse_num_val(str, pos)
	  local num_str = str:match('^-?%d+%.?%d*[eE]?[+-]?%d*', pos)
	  local val = tonumber(num_str)
	  if not val then error('Error parsing number at position ' .. pos .. '.') end
	  return val, pos + #num_str
	end


	-- Public values and functions.

	function json.stringify(obj, as_key)
	  local s = {}  -- We'll build the string as an array of strings to be concatenated.
	  local kind = kind_of(obj)  -- This is 'array' if it's an array or type(obj) otherwise.
	  if kind == 'array' then
		if as_key then error('Can\'t encode array as key.') end
		s[#s + 1] = '['
		for i, val in ipairs(obj) do
		  if i > 1 then s[#s + 1] = ', ' end
		  s[#s + 1] = json.stringify(val)
		end
		s[#s + 1] = ']'
	  elseif kind == 'table' then
		if as_key then error('Can\'t encode table as key.') end
		s[#s + 1] = '{'
		for k, v in pairs(obj) do
		  if #s > 1 then s[#s + 1] = ', ' end
		  s[#s + 1] = json.stringify(k, true)
		  s[#s + 1] = ':'
		  s[#s + 1] = json.stringify(v)
		end
		s[#s + 1] = '}'
	  elseif kind == 'string' then
		return '"' .. escape_str(obj) .. '"'
	  elseif kind == 'number' then
		if as_key then return '"' .. tostring(obj) .. '"' end
		return tostring(obj)
	  elseif kind == 'boolean' then
		return tostring(obj)
	  elseif kind == 'nil' then
		return 'null'
	  else
		error('Unjsonifiable type: ' .. kind .. '.')
	  end
	  return table.concat(s)
	end

	json.null = {}  -- This is a one-off table to represent the null value.

	function json.parse(str, pos, end_delim)
	  pos = pos or 1
	  if pos > #str then error('Reached unexpected end of input.') end
	  local pos = pos + #str:match('^%s*', pos)  -- Skip whitespace.
	  local first = str:sub(pos, pos)
	  if first == '{' then  -- Parse an object.
		local obj, key, delim_found = {}, true, true
		pos = pos + 1
		while true do
		  key, pos = json.parse(str, pos, '}')
		  if key == nil then return obj, pos end
		  if not delim_found then error('Comma missing between object items.') end
		  pos = skip_delim(str, pos, ':', true)  -- true -> error if missing.
		  obj[key], pos = json.parse(str, pos)
		  pos, delim_found = skip_delim(str, pos, ',')
		end
	  elseif first == '[' then  -- Parse an array.
		local arr, val, delim_found = {}, true, true
		pos = pos + 1
		while true do
		  val, pos = json.parse(str, pos, ']')
		  if val == nil then return arr, pos end
		  if not delim_found then error('Comma missing between array items.') end
		  arr[#arr + 1] = val
		  pos, delim_found = skip_delim(str, pos, ',')
		end
	  elseif first == '"' then  -- Parse a string.
		return parse_str_val(str, pos + 1)
	  elseif first == '-' or first:match('%d') then  -- Parse a number.
		return parse_num_val(str, pos)
	  elseif first == end_delim then  -- End of an object or array.
		return nil, pos + 1
	  else  -- Parse true, false, or null.
		local literals = {['true'] = true, ['false'] = false, ['null'] = json.null}
		for lit_str, lit_val in pairs(literals) do
		  local lit_end = pos + #lit_str - 1
		  if str:sub(pos, lit_end) == lit_str then return lit_val, lit_end + 1 end
		end
		local pos_info_str = 'position ' .. pos .. ': ' .. str:sub(pos, pos + 10)
		error('Invalid json syntax starting at ' .. pos_info_str)
	  end
	end

	return json
end

