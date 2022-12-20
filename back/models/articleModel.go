package models

import "gorm.io/gorm"

type Article struct {
	gorm.Model
	Title 	string
	Author 	string
	Text 	string
	Img 	string
}