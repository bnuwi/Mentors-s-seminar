package main

import "fmt"

func main() {
	var n int

	fmt.Print("How many numbers will be? ")
	if _, err := fmt.Scan(&n); err != nil || n < 1 {
		fmt.Println("Error: quantity must be integer and greater than 0")
		return
	}

	var maxVal, minVal float64

	for i := 1; i <= n; i++ {
		var x float64
		fmt.Printf("Enter number %d: ", i)
		if _, err := fmt.Scan(&x); err != nil {
			fmt.Println("Error: need the number")
			return
		}

		if i == 1 {
			maxVal, minVal = x, x
			continue
		}
		if x > maxVal {
			maxVal = x
		}
		if x < minVal {
			minVal = x
		}
	}
	fmt.Printf("Max: %g\n", maxVal)
	fmt.Printf("Min: %g\n", minVal)
}
