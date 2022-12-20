package query

import (
	"github.com/fajarhdev/go-mycash/initializers"
	"github.com/fajarhdev/go-mycash/models"
)

//GetAllUsers Fetch all user data
func GetAllUsers(user *[]models.User) {
	initializers.DB.Find(&user)
}

// login user find
func FindUser(user *models.User, email string ) int64 {
	results := initializers.DB.Where("email = ?", email).First(&user)
	return results.RowsAffected
}

//CreateUser ... Insert New data
func CreateUser(user models.User) {
	initializers.DB.Create(&user)
}

//GetUserByID ... Fetch only one user by Id
func GetUserByID(user *models.User, id string) {
	initializers.DB.Where("id = ?", id).First(&user)
}

//UpdateUser ... Update user
func UpdateUser(user *models.User, update models.User ) {
	initializers.DB.Model(&user).Updates(&update)
	// initializers.DB.Save(user)
}

//DeleteUser ... Delete user
func DeleteUser(user *models.User, id string) (err error) {
	initializers.DB.Delete(&user, id)
	return
}