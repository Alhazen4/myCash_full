package models

import "gorm.io/gorm"

type Expense struct {
	gorm.Model
	Amount 	int	`json:"amount"`
	UserID 	int
	User 	*User
}