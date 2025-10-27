# Makefile for biblatex with biber

MAIN = template-en
PDF = $(MAIN).pdf
BIBER = biber

all: $(PDF)

$(PDF): $(MAIN).tex elegantpaper.cls reference.bib
	@echo "第一步: 运行 pdflatex 生成辅助文件..."
	pdflatex -interaction=nonstopmode $(MAIN)
	
	@echo "第二步: 运行 biber 处理参考文献..."
	$(BIBER) $(MAIN)
	
	@echo "第三步: 再次运行 pdflatex 解析引用..."
	pdflatex -interaction=nonstopmode $(MAIN)
	
	@echo "第四步: 最终运行 pdflatex 确保所有引用正确..."
	pdflatex -interaction=nonstopmode $(MAIN)
	
	@echo "编译完成: $(PDF)"

# 快速编译（仅用于查看布局）
quick:
	pdflatex -interaction=nonstopmode $(MAIN)

# 仅运行biber（当只更新了参考文献时）
run-biber:
	$(BIBER) $(MAIN)

# 检查biber是否安装
check-biber:
	@which $(BIBER) >/dev/null && echo "✓ biber 已安装" || echo "✗ biber 未安装，请安装: sudo apt install biber"

# 清理文件
clean:
	rm -f *.aux *.log *.out *.toc *.lof *.lot
	rm -f *.bbl *.blg *.bcf *.run.xml
	rm -f *.nav *.snm *.vrb *.synctex.gz
	rm -f *.fdb_latexmk *.fls

cleanall: clean
	rm -f $(PDF)

view: $(PDF)
	@if [ -f $(PDF) ]; then xdg-open $(PDF); fi

.PHONY: all quick run-biber check-biber clean cleanall view