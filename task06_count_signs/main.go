package main

import "fmt"

func main() {
	var n int

	fmt.Print("How many numbers will be? ")
	if _, err := fmt.Scan(&n); err != nil || n < 1 {
		fmt.Println("Error: quantity must be integer and greater than 0")
		return
	}

	positive, negative, zeros := 0, 0, 0

	for i := 1; i <= n; i++ {
		var x float64
		fmt.Printf("Enter number %d: ", i)
		if _, err := fmt.Scan(&x); err != nil {
			fmt.Println("Error: need the number")
			return
		}

		if x > 0 {
			positive++
		} else if x < 0 {
			negative++
		} else {
			zeros++
		}
	}
	fmt.Println("Positive:", positive)
	fmt.Println("Negative:", negative)
	fmt.Println("Zeros:", zeros)
}
