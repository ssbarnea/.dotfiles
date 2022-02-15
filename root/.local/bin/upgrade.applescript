tell application "iTerm"
	-- --Create initial window
	-- create window with default profile

	--Create a second tab in the initial window
	tell current window
		create tab with default profile
	end tell

	--Send a command to the first tab
	tell current session of current window
		write text "softwareupdate --all --install --force && brew upgrade"
	end tell

end
