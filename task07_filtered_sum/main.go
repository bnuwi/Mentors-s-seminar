package main

import "fmt"

func main() {
	var n int

	fmt.Print("Enter number N: ")
	if _, err := fmt.Scan(&n); err != nil {
		fmt.Println("Error: need integer")
		return
	}

	sum := 0
	var found []int

	for i := 1; i <= n; i++ {
		if i%2 == 0 && i%3 == 0 {
			sum += i
			found = append(found, i)
		}
	}

	if len(found) == 0 {
		fmt.Println("From 1 to", n, "no suitable numbers, sum: 0")
		return
	}
	fmt.Println("Suitable numbers:", found)
	fmt.Println("Sum:", sum)
}
