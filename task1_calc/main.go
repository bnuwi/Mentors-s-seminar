package main

import "fmt"

func main() {
	var a, b float64
	var op string

	fmt.Print("Enter first number: ")
	if _, err := fmt.Scan(&a); err != nil {
		fmt.Println("Error: need a number")
		return
	}

	fmt.Print("Enter operation (+, -, *, /): ")
	fmt.Scan(&op)

	fmt.Print("Enter second number: ")
	if _, err := fmt.Scan(&b); err != nil {
		fmt.Println("Error: need a number")
		return
	}

	var result float64

	switch op {
	case "+":
		result = a + b
	case "-":
		result = a - b
	case "*":
		result = a * b
	case "/":
		if b == 0 {
			fmt.Println("Error: division by zero is impossible")
			return
		}
		result = a / b
	default:
		fmt.Println("Error: unknown operation", op)
		return
	}
	
	fmt.Printf("%g %s %g = %g\n", a, op, b, result)
}