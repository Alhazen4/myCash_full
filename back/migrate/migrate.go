package migrate

import (
	"github.com/fajarhdev/go-mycash/initializers"
	"github.com/fajarhdev/go-mycash/models"
)

func init() {
	initializers.LoadEnvVariables()
	initializers.ConnectToDB()
}

func Migrate(){
	initializers.DB.AutoMigrate(&models.User{})
	initializers.DB.AutoMigrate(&models.Income{})
	initializers.DB.AutoMigrate(&models.Expense{})
	initializers.DB.AutoMigrate(&models.Transaction{})
	initializers.DB.AutoMigrate(&models.Article{})
}