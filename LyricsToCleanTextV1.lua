local SCRIPT_TITLE = 'Copy Clean Lyrics to Clipboard v.1'

--[[

Suggested lua file name: LyricsToCleanTextV1.lua

This will extract the lyrics from the selected notes, purge any "br" or "hh" etc., and put the result on the clipboard. If there ae uppercase letters in the text, it will line break on them. (This presents a problem with "I" and proper names. You'll have to clean those up manually.)

It will put in an extra line break if there is a blank measure between lyrics.

No idea if or how this will work in languages other than English.

--]]


function table.contains(table, element)
  for _, value in pairs(table) do
    if value == element then
      return true
    end
  end
  return false
end

function IsUpper(s)
    return (s == string.upper(s));
end		

function getClientInfo() 
  return {
    name = SV:T(SCRIPT_TITLE),
    author = 'Bill White',
    versionNumber = 1,
    minEditorVersion = 65537
  }
end

function copyToClipboard() 
  local editor = SV:getMainEditor()
  local selected = editor:getSelection()
  local selectedNotes = selected:getSelectedNotes()
  local timeAxis = SV:getProject():getTimeAxis()
  local current_measure = 1
  lyrics = ''
  if #selectedNotes > 0 then 
		local ignoreList = {'br', '-', 'hh', '+'}
		for _, lyric_current in pairs(selectedNotes) do
			local test_measure = timeAxis:getMeasureAt(lyric_current:getOnset())
			if string.len(lyrics) > 0 and test_measure > current_measure then
				if test_measure > current_measure + 1 then lyrics = lyrics .. '\n' end
				current_measure = timeAxis:getMeasureAt(lyric_current:getOnset())
			end
			curr = lyric_current:getLyrics()
			if (table.contains(ignoreList,curr) == false) and string.sub(curr, 1, 1) ~= '.' then
				if string.len(lyrics) > 0 and IsUpper(string.sub(curr, 1, 1)) then lyrics = lyrics .. '\n' end
				lyrics = lyrics .. lyric_current:getLyrics() .. ' '
			end
		end
		SV:setHostClipboard(lyrics)	  
		SV:showMessageBox(SV:T(SCRIPT_TITLE), SV:T("Lyrics placed on clipboard."))		
	else
		SV:showMessageBox(SV:T("No notes selected"), SV:T("Please select at least one note."))
	end  
end

function main() 
  copyToClipboard()
  SV:finish()
end

