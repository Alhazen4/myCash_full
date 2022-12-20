package initializers

import (
	"log"
	"os"

	"github.com/joho/godotenv"
)

var Port, UserDB, PassDB, Host string

func LoadEnvVariables() {
	err := godotenv.Load()

	if err != nil {
		log.Fatal("Error loading .env file")
	}

	Port = os.Getenv("PORT")
	UserDB = os.Getenv("USER_DB")
	PassDB = os.Getenv("PASSWORD_DB")
	Host = os.Getenv("HOST")
}