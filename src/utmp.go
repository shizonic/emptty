package main

// #include <paths.h>
// #include <utmpx.h>
import "C"
import (
	"log"
	"os"
)

// Adds UTMPx entry as user process
func addUtmpEntry(username string, pid int, ttyNo string) *C.struct_utmpx {
	utmp := prepareUtmpx(username, pid, ttyNo, os.Getenv(envDisplay))
	putUtmpEntry(utmp)

	return utmp
}

// End UTMPx entry by marking as dead process
func endUtmpEntry(utmp *C.struct_utmpx) {
	utmp.ut_type = C.DEAD_PROCESS
	putTimeToUtmpEntry(utmp)

	putUtmpEntry(utmp)
}

// Puts UTMPx entry into utmp file
func putUtmpEntry(utmp *C.struct_utmpx) {
	C.setutxent()
	if C.pututxline(utmp) == nil {
		log.Println("Could not write into utmp.")
	}
	C.endutxent()

	updwtmpx(utmp)
}

// Converts string to [4]C.char
func strToC4Char(data string) [4]C.char {
	result := [4]C.char{}

	for i := 0; i < 4; i++ {
		if i < len(data) {
			result[i] = C.char(data[i])
		} else {
			result[i] = 0
		}
	}
	return result
}

// Converts string to [8]C.char
func strToC8Char(data string) [8]C.char {
	result := [8]C.char{}

	for i := 0; i < 8; i++ {
		if i < len(data) {
			result[i] = C.char(data[i])
		} else {
			result[i] = 0
		}
	}
	return result
}

// Converts string to [16]C.char
func strToC16Char(data string) [16]C.char {
	result := [16]C.char{}

	for i := 0; i < 16; i++ {
		if i < len(data) {
			result[i] = C.char(data[i])
		} else {
			result[i] = 0
		}
	}
	return result
}

// Converts string to [32]C.char
func strToC32Char(data string) [32]C.char {
	result := [32]C.char{}

	for i := 0; i < 32; i++ {
		if i < len(data) {
			result[i] = C.char(data[i])
		} else {
			result[i] = 0
		}
	}
	return result
}

// Converts string to [128]C.char
func strToC128Char(data string) [128]C.char {
	result := [128]C.char{}

	for i := 0; i < 128; i++ {
		if i < len(data) {
			result[i] = C.char(data[i])
		} else {
			result[i] = 0
		}
	}
	return result
}

// Converts string to [256]C.char
func strToC256Char(data string) [256]C.char {
	result := [256]C.char{}

	for i := 0; i < 256; i++ {
		if i < len(data) {
			result[i] = C.char(data[i])
		} else {
			result[i] = 0
		}
	}
	return result
}
