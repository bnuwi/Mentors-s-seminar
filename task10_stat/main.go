package main

import (
	"fmt"
	"strconv"
)

func main() {
	var n int

	fmt.Print("How many numbers will be? ")
	if _, err := fmt.Scan(&n); err != nil || n < 1 {
		fmt.Println("Error: quantity must be integer and greater than 0")
		return
	}

	sum := 0
	var maxVal, minVal int
	evenCount, oddCount := 0, 0

	for i := 1; i <= n; i++ {
	var input string
	fmt.Printf("Enter integer %d: ", i)
	fmt.Scan(&input)

	x, err := strconv.Atoi(input)
	if err != nil {
		fmt.Println("Error: need integer, try again")
		i--
		continue
	}

		sum += x

		if i == 1 || x > maxVal {
			maxVal = x
		}
		if i == 1 || x < minVal {
			minVal = x
		}

		if x%2 == 0 {
			evenCount++
		} else {
			oddCount++
		}
	}
	average := float64(sum) / float64(n)
	fmt.Println()
	fmt.Println("Sum:", sum)
	fmt.Printf("Average: %.2f\n", average)
	fmt.Println("Max:", maxVal)
	fmt.Println("Min:", minVal)
	fmt.Println("Even:", evenCount)
	fmt.Println("Odd:", oddCount)
}
