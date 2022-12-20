package models

import (
	"gorm.io/gorm"
)

type Transaction struct {
	gorm.Model
	TotalAmount int	`json:"totalamount"`
	Status 		string	`json:"status"`
	UserID		int
	User 		*User
}