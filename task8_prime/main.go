package main

import "fmt"

func isPrime(n int) bool {
	if n < 2 {
		return false
	}
	if n == 2 {
		return true
	}
	if n%2 == 0 {
		return false
	}
	for i := 3; i*i <= n; i += 2 {
		if n%i == 0 {
			return false
		}
	}
	return true
}

func main() {
	var n int

	fmt.Print("Enter integer: ")
	if _, err := fmt.Scan(&n); err != nil {
		fmt.Println("Error: need integer")
		return
	}
	if isPrime(n) {
		fmt.Println(n, "— is prime number")
	} else {
		fmt.Println(n, "— isn't prime number")
	}
}
