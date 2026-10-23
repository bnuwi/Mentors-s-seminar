package main

import "fmt"

func printTable(n int) {
	fmt.Printf("Multiplication table for %d:\n", n)
	for i := 1; i <= 10; i++ {
		fmt.Printf("%d x %2d = %d\n", n, i, n*i)
	}
}

func main() {
	var n int

	fmt.Print("Enter number: ")
	if _, err := fmt.Scan(&n); err != nil {
		fmt.Println("Error: need integer")
		return
	}
	printTable(n)
}
