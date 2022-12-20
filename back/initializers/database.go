package initializers

import (
	"log"

	"gorm.io/driver/mysql"
	"gorm.io/gorm"
)

var DB *gorm.DB
// var err error

func ConnectToDB() {
	var err error
	dsn := "root:root@tcp(127.0.0.1:3306)/mycash?charset=utf8mb4&parseTime=True&loc=Local"
	DB, err = gorm.Open(mysql.Open(dsn), &gorm.Config{})
	if err != nil {
		log.Fatal("Failed to connect to database")
		panic(err.Error())
	}else {
		log.Println("berhasil connect")
	}
	
}