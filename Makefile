release:
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
