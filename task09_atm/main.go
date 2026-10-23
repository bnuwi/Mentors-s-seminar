package main

import "fmt"

func main() {
	var balance float64

	fmt.Print("Enter start balance: ")
	if _, err := fmt.Scan(&balance); err != nil || balance < 0 {
		fmt.Println("Error: balance must be positive")
		return
	}

	for {
		fmt.Println()
		fmt.Println("Select an action:")
		fmt.Println("1 — Check balance")
		fmt.Println("2 — Deposit funds")
		fmt.Println("3 — Withdraw cash")
		fmt.Println("0 — Exit")
		fmt.Print("Your choice: ")

		var choice int
		if _, err := fmt.Scan(&choice); err != nil {
			fmt.Println("Input error, exit")
			return
		}

		switch choice {
		case 1:
			fmt.Printf("Current balance: %.2f\n", balance)

		case 2:
			var amount float64
			fmt.Print("Deposit amount: ")
			fmt.Scan(&amount)
			if amount <= 0 {
				fmt.Println("Error: amount must be greater than 0")
			} else {
				balance += amount
				fmt.Printf("Balance updated successfully. New balance: %.2f\n", balance)
			}

		case 3:
			var amount float64
			fmt.Print("Withdraw amount: ")
			fmt.Scan(&amount)
			if amount <= 0 {
				fmt.Println("Error: amount must be greater than 0")
			} else if amount > balance {
				fmt.Printf("Insufficient funds. Available balance: %.2f\n", balance)
			} else {
				balance -= amount
				fmt.Printf("Amount dispensed %.2f. Remaining balance: %.2f\n", amount, balance)
			}

		case 0:
			fmt.Println("See you!")
			return

		default:
			fmt.Println("Invalid action. Please, try again")
		}
	}
}
