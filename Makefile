include Makefile.common

SRCS+= src/utmp_linux.go

build:
	@echo "Building..."
	@mkdir -p dist
	@go build -o dist/${DISTFILE} ${SRCS} src/utmp_glibc.go src/login_pam.go
	@gzip -c res/emptty.1 > dist/emptty.1.gz
	@echo "Done"

build-musl:
	@echo "Building..."
	@mkdir -p dist
	@go build -o dist/${DISTFILE} ${SRCS} src/utmp_musl.go src/login_pam.go
	@gzip -c res/emptty.1 > dist/emptty.1.gz
	@echo "Done"

build-nopam:
	@echo "Building..."
	@mkdir -p dist
	@go build -o dist/${DISTFILE} ${SRCS} src/utmp_glibc.go src/login_nopam.go src/login_nopam_linux.go
	@gzip -c res/emptty.1 > dist/emptty.1.gz
	@echo "Done"

build-musl-nopam:
	@echo "Building..."
	@mkdir -p dist
	@go build -o dist/${DISTFILE} ${SRCS} src/utmp_musl.go src/login_nopam.go src/login_nopam_linux.go
	@gzip -c res/emptty.1 > dist/emptty.1.gz
	@echo "Done"