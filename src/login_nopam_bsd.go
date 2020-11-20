// +build darwin dragonfly freebsd netbsd openbsd
package main

// Tries to authorize user with password.
func authPassword(username string, password string) bool {
	handleStrErr("NOPAM authorization not implemented for BSD")
	return false
}
