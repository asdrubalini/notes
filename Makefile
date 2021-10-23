clean:
	find . -type f -name "*.aux" -delete
	find . -type f -name "*.fls" -delete
	find . -type f -name "*.fdb_latexmk" -delete
	find . -type f -name "*.log" -delete
	find . -type f -name "*.gz" -delete
	find . -type f -name "__latexindent_temp" -delete
	find . -type f -name "*.out" -delete
	find . -type f -name "*.pdf" -delete
