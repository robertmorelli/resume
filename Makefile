install_fonts:
	mkdir -p "$(HOME)/.local/share/fonts/Cartograph CF"
	cp ./fonts/*.woff* "$(HOME)/.local/share/fonts/Cartograph CF/"
	fc-cache -f
	fc-list | grep -i "Cartograph CF"

website:
	ls
	typst c resume.typ --font-path "$(HOME)/.local/share/fonts"
	ls
	mv resume.pdf docs/index.pdf
	ls
