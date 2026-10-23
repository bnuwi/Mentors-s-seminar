package main

import "fmt"

func main() {
	var n int

	fmt.Print("Enter number N (N >= 1): ")
	if _, err := fmt.Scan(&n); err != nil {
		fmt.Println("Error: need integer")
		return
	}
	if n < 1 {
		fmt.Println("Error: N must be >= 1")
		return
	}

	sum := 0
	for i := 1; i <= n; i++ {
		sum += i
	}

	average := float64(sum) / float64(n)
	fmt.Printf("Sum from 1 to %d: %d\n", n, sum)
	fmt.Printf("Average: %.2f\n", average)
}
