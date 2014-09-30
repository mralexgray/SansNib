all:
	@echo "sans make system.. tada"
	@echo ""
	@echo "Usage:"
	@echo "  make templates"
	@echo "  make lib"
	@echo "  make demo"
	@echo ""

lib:
	mkdir -p ~/Library/Developer/Xcode/Templates/Custom
	utils/geticns.sh
	cp -r CodaPlugin.xctemplate ~/Library/Developer/Xcode/Templates/Custom

templates:
	mkdir -p /Library/Developer/Xcode/Templates/Application/Project\ Templates/Mac/Application
	cp -r sans.xctemplate /Library/Developer/Xcode/Templates/Application/Project\ Templates/Mac/Application 
