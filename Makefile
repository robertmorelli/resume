install_fonts:
	mkdir -p "$(HOME)/.local/share/fonts/Cartograph\ CF"
	cp ./fonts/*.woff* "$(HOME)/.local/share/fonts/Cartograph\ CF/"
	fc-cache -f
	fc-list | grep -i "Cartograph\ CF"

website:
	typst fonts --font-path "/home/runner/.local/share/fonts/Cartograph CF" | head -200
	typst fonts --font-path "/home/runner/.local/share/fonts/Cartograph CF" | grep -i cartograph
	ls
	typst c resume.typ --font-path "$(HOME)/.local/share/fonts"
	ls
	mv resume.pdf docs/index.pdf
	ls
