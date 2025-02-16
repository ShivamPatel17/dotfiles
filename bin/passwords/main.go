// generate the binary and move to dotfiles/bin/.config/bin/
// go build -o passwordgen main.go

package main

import (
	"crypto/rand"
	"fmt"
	"math/big"
)

const (
	lowerChars  = "abcdefghijklmnopqrstuvwxyz"
	upperChars  = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	numberChars = "0123456789"
	symbolChars = "!@#$%^&*()-_=+[]{}<>?/|"
	allChars    = lowerChars + upperChars + numberChars + symbolChars
)

func main() {
	password, err := GeneratePassword(36) // Change 12 to desired length
	if err != nil {
		fmt.Println("Error:", err)
		return
	}
	fmt.Println("Generated Password:\n", password)
}

// GeneratePassword generates a random password of the given length
func GeneratePassword(length int) (string, error) {
	if length < 4 {
		return "", fmt.Errorf("password length must be at least 4")
	}

	password := make([]byte, length)

	// Ensure password contains at least one character from each category
	categories := []string{lowerChars, upperChars, numberChars, symbolChars}
	for i := 0; i < len(categories); i++ {
		char, err := getRandomChar(categories[i])
		if err != nil {
			return "", err
		}
		password[i] = char
	}

	// Fill the rest with random characters from allChars
	for i := 4; i < length; i++ {
		char, err := getRandomChar(allChars)
		if err != nil {
			return "", err
		}
		password[i] = char
	}

	// Shuffle the password to avoid predictable patterns
	shuffle(password)

	return string(password), nil
}

// getRandomChar picks a random character from a given string
func getRandomChar(charset string) (byte, error) {
	n, err := rand.Int(rand.Reader, big.NewInt(int64(len(charset))))
	if err != nil {
		return 0, err
	}
	return charset[n.Int64()], nil
}

// shuffle randomly shuffles a byte slice
func shuffle(data []byte) {
	for i := len(data) - 1; i > 0; i-- {
		j, _ := rand.Int(rand.Reader, big.NewInt(int64(i+1)))
		data[i], data[j.Int64()] = data[j.Int64()], data[i]
	}
}
