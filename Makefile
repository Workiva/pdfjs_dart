all:
	npm install
	cp -r \
		node_modules/pdfjs-dist/build/pdf{,.worker}.min.js \
		node_modules/pdfjs-dist/build/pdf{,.worker}.js.map \
		node_modules/pdfjs-dist/web/pdf_viewer.{css,js} \
		node_modules/pdfjs-dist/web/images \
		lib/static/

clean:
	rm -rf node_modules/
	rm lib/static/*
