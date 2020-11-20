// +build darwin dragonfly freebsd netbsd openbsd

package main

// #include <sys/time.h>
// #include <utmpx.h>
import "C"

// Prepares UTMP entry
func prepareUtmpx(username string, pid int, ttyNo string, xdisplay string) *C.struct_utmpx {
	utmp := &C.struct_utmpx{}

	utmp.ut_type = C.USER_PROCESS
	utmp.ut_pid = C.int(pid)
	utmp.ut_line = strToC16Char("tty" + ttyNo)
	if xdisplay != "" {
		utmp.ut_id = strToC8Char(xdisplay)
	} else {
		utmp.ut_id = strToC8Char(ttyNo)
	}
	putTimeToUtmpEntry(utmp)
	utmp.ut_user = strToC32Char(username)
	utmp.ut_host = strToC128Char(xdisplay)
	return utmp
}

// Puts UTMP entry into wtmp file
func updwtmpx(utmpx *C.struct_utmpx) {
	// Nothing to do here
}

// Puts timeval data into UTMPx entry
func putTimeToUtmpEntry(utmp *C.struct_utmpx) {
	tv := &C.struct_timeval{}
	C.gettimeofday(tv, nil)
	utmp.ut_tv.tv_sec = tv.tv_sec
	utmp.ut_tv.tv_usec = tv.tv_usec
}
