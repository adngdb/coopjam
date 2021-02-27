build:
	rm -r html_export/
	mkdir html_export
	cp convert.sh html_export/
	cd Qlas && /Applications/Godot.app/Contents/MacOS/Godot --export HTML5 ../html_export/index.html
	cd html_export/ && ./convert.sh index && rm *.bak

release:  build
	git worktree add -b deploy deploying/ origin/deploy
	rm -rf deploying/*
	cp -r html_export/* deploying/
	- cd deploying/ && \
		git add . && \
		git commit -am "Publishing" && \
		git push
	git worktree remove deploying
	git branch -d deploy
.PHONY: release
