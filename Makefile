.PHONY : all clean debug

## Markdown extension (e.g. md, markdown, mdown).
MEXT = md

SRCDIR = srcs
OBJDIR = objs

SRCS = $(wildcard $(SRCDIR)/*.$(MEXT))
PDFS = $(patsubst %.$(MEXT), ${OBJDIR}/%.pdf, $(notdir ${SRCS}))
HTML = $(patsubst %.$(MEXT), ${OBJDIR}/%.html, $(notdir ${SRCS}))
REVEAL = $(patsubst %.$(MEXT), ${OBJDIR}/%.slides.html, $(notdir ${SRCS}))

all:	$(REVEAL) $(HTML)

debug:

show:
	@echo $(SRCS)
	@echo $(PDFS)
	@echo $(HTML)
	@echo $(REVEAL)

$(OBJDIR)/%.slides.html:	$(SRCDIR)/%.md
	pandoc -t revealjs -f markdown \
	--template=custom \
	--include-in-header=pandoc_custom/css/revealjs.css \
	-V slideNumber=true -V margin=0.1 \
	-V revealjs-url=../reveal.js \
	-o $@ $<

$(OBJDIR)/%.html:	$(SRCDIR)/%.md
	pandoc -t html5 -f markdown \
	--template github \
	--css=stylesheets/github.css \
	-s -S \
	-o $@ $<

clean:
	rm -f $(OBJDIR)/*.html $(OBJDIR)/*.pdf $(OBJDIR)/*.slides.html

again:
	make clean
	make
