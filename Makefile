.PHONY : all clean debug

## Markdown extension (e.g. md, markdown, mdown).
MEXT = md

SRCDIR = srcs
OBJDIR = objs

SRCS = $(wildcard $(SRCDIR)/*.$(MEXT))
PDFS = $(patsubst %.$(MEXT), ${OBJDIR}/%.pdf, $(notdir ${SRCS}))
HTML = $(patsubst %.$(MEXT), ${OBJDIR}/%.html, $(notdir ${SRCS}))
REVEAL = $(patsubst %.$(MEXT), ${OBJDIR}/%.slides.html, $(notdir ${SRCS}))

all:	$(REVEAL)

debug:

show:
	@echo $(SRCS)
	@echo $(PDFS)
	@echo $(HTML)
	@echo $(REVEAL)

$(OBJDIR)/%.slides.html:	$(SRCDIR)/%.md
	pandoc -t revealjs -f markdown \
	--template=pandoc_custom/templates/custom \
	--include-in-header=pandoc_custom/css/revealjs.css \
	-V slideNumber=true \
	-V revealjs-url=../reveal.js \
	-o $@ $<

clean:
	rm -f $(OBJDIR)/*.html $(OBJDIR)/*.pdf $(OBJDIR)/*.slides.html

again:
	make clean
	make
