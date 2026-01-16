install_fonts:
	mkdir -p "$HOME/.local/share/fonts"
	cp -r /fonts/* "$HOME/.local/share/fonts/"
	fc-cache -f

website:
	ls
	typst c resume.typ
	ls
	mv resume.pdf docs/index.pdf
	ls
