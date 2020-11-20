include Makefile.common

SRCS+= src/utmp_bsd.go

build:
	@echo "Building..."
	@mkdir -p dist
	@go build -o dist/${DISTFILE} ${SRCS} src/login_pam.go
	@gzip -c res/emptty.1 > dist/emptty.1.gz
	@echo "Done"

build-nopam:
	@echo "Building..."
	@mkdir -p dist
	@go build -o dist/${DISTFILE} ${SRCS} src/login_nopam.go src/login_nopam_bsd.go
	@gzip -c res/emptty.1 > dist/emptty.1.gz
	@echo "Done"