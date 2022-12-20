package models

import "gorm.io/gorm"

type Income struct {
	gorm.Model
	Amount 	int 	`json:"amount"`
	UserID 	int
	User	*User
}