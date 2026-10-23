package main

import "fmt"

func main() {
	var n int

	fmt.Print("Enter first number N: ")
	if _, err := fmt.Scan(&n); err != nil {
		fmt.Println("Error: need integer")
		return
	}

	if n > 0 {
		fmt.Println("Is positive")
	} else if n < 0 {
		fmt.Println("Is negative")
	} else {
		fmt.Println("Equal to zero (neither positive nor negative)")
	}

	if n%2 == 0 {
		fmt.Println("Is even")
	} else {
		fmt.Println("Is odd")
	}

	div3 := n%3 == 0
	div5 := n%5 == 0

	if div3 && div5 {
		fmt.Println("Is divisible by both 3 and 5")
	} else if div3 {
		fmt.Println("Is divisible by 3 but not by 5")
	} else if div5 {
		fmt.Println("Is divisible by 5 but not by 3")
	} else {
		fmt.Println("Is not divisible by either 3 or 5")
	}
}