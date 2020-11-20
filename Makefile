DISTFILE=emptty

SRCS = src/main.go
SRCS+= src/config.go
SRCS+= src/daemon.go
SRCS+= src/desktop.go
SRCS+= src/login.go
SRCS+= src/motd.go
SRCS+= src/password.go
SRCS+= src/sysuser.go
SRCS+= src/utils.go
SRCS+= src/utmp.go
SRCS+= src/xlib.go

clean:
	@echo "Cleaning..."
	@rm -f dist/${DISTFILE}
	@rm -f dist/emptty.1.gz
	@rm -rf dist
	@echo "Done"

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
	@go build -o dist/${DISTFILE} ${SRCS} src/utmp_glibc.go src/login_nopam.go
	@gzip -c res/emptty.1 > dist/emptty.1.gz
	@echo "Done"

build-musl-nopam:
	@echo "Building..."
	@mkdir -p dist
	@go build -o dist/${DISTFILE} ${SRCS} src/utmp_musl.go src/login_nopam.go
	@gzip -c res/emptty.1 > dist/emptty.1.gz
	@echo "Done"

install:
	@echo "Installing..."
	@install -DZs dist/${DISTFILE} -m 755 -t ${DESTDIR}/usr/bin
	@echo "Done"

install-config:
	@echo "Installing config..."
	@install -DZ res/conf -m 644 -T ${DESTDIR}/etc/${DISTFILE}/conf
	@echo "Done"

install-manual:
	@echo "Installing manual..."
	@install -D dist/emptty.1.gz -t ${DESTDIR}/usr/share/man/man1
	@echo "Done"

install-motd-gen:
	@echo "Installing motd-gen.sh..."
	@install -DZ res/motd-gen.sh -m 744 -t ${DESTDIR}/etc/${DISTFILE}/
	@echo "Done"

install-pam:
	@echo "Installing pam file..."
	@install -DZ res/pam -m 644 -T ${DESTDIR}/etc/pam.d/${DISTFILE}
	@echo "Done"

install-pam-debian:
	@echo "Installing pam-debian file..."
	@install -DZ res/pam-debian -m 644 -T ${DESTDIR}/etc/pam.d/${DISTFILE}
	@echo "Done"

install-all: install install-manual install-pam

install-runit:
	@echo "Installing runit service..."
	@install -DZ res/runit-run -m 755 -T ${DESTDIR}/etc/sv/${DISTFILE}/run
	@echo "Done"

install-systemd:
	@echo "Installing systemd service..."
	@install -DZ res/systemd-service -m 644 -T ${DESTDIR}/usr/lib/systemd/system/${DISTFILE}.service
	@echo "Done"

install-openrc:
	@echo "Installing OpenRC service..."
	@install -DZ res/openrc-service -m 755 -T ${DESTDIR}/etc/init.d/${DISTFILE}
	@echo "Done"

uninstall:
	@echo "Uninstalling..."
	@rm -rf ${DESTDIR}/etc/sv/${DISTFILE}
	@rm -f ${DESTDIR}/usr/lib/systemd/system/${DISTFILE}.service
	@rm -f ${DESTDIR}/etc/init.d/${DISTFILE}
	@rm -f ${DESTDIR}/usr/share/man/man1/emptty.1.gz
	@rm -f ${DESTDIR}/etc/pam.d/emptty
	@rm -rf ${DESTDIR}/usr/bin/${DISTFILE}
	@echo "Done"
