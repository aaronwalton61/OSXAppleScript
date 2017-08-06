tell application "iTunes"
	if selection is not {} then -- there ARE tracks selected...
		set mySelection to selection
		repeat with aTrack in mySelection
			-- set theDialogT to name of aTrack
			-- display dialog theDialogT
			log (get name of aTrack)
			set theText to name of aTrack
			set delimiter to "-"
			set ArtistSong to splitText(theText, delimiter) of me
			
			if length of ArtistSong = 2 then
				log (item 1 of ArtistSong)
				set artist of aTrack to trimText(item 1 of ArtistSong, " ", "end") of me
				--> set artist of aTrack to 
				log (item 2 of ArtistSong)
				set name of aTrack to trimText(item 2 of ArtistSong, " ", "beginning") of me
			else
				log ("error skip")
			end if
		end repeat
	end if
end tell

on displayerror(theText)
	display dialog theText
end displayerror

on splitText(theText, theDelimiter)
	set AppleScript's text item delimiters to theDelimiter
	set theTextItems to every text item of theText
	set AppleScript's text item delimiters to ""
	return theTextItems
end splitText

on trimText(theText, theCharactersToTrim, theTrimDirection)
	set theTrimLength to length of theCharactersToTrim
	if theTrimDirection is in {"beginning", "both"} then
		repeat while theText begins with theCharactersToTrim
			try
				set theText to characters (theTrimLength + 1) thru -1 of theText as string
			on error
				-- text contains nothing but trim characters
				return ""
			end try
		end repeat
	end if
	if theTrimDirection is in {"end", "both"} then
		repeat while theText ends with theCharactersToTrim
			try
				set theText to characters 1 thru -(theTrimLength + 1) of theText as string
			on error
				-- text contains nothing but trim characters
				return ""
			end try
		end repeat
	end if
	return theText
end trimText
