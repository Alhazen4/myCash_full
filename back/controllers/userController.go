package controllers

import (
	// "fmt"
	"net/http"

	// "github.com/fajarhdev/go-mycash/initializers"
	"github.com/fajarhdev/go-mycash/models"
	"github.com/fajarhdev/go-mycash/query"
	"github.com/gin-gonic/gin"
)

func GetUsers(c *gin.Context) {
	var user []models.User

	query.GetAllUsers(&user)

	c.JSON(http.StatusOK, user)
	// fmt.Println(user)
}

// for login
func FindUser(c *gin.Context){
	var userModel models.User

	var user struct {
		Email 		string `json:"email"`
		Password 	string `json:"password"`
	}

	if err := c.BindJSON(&user); err != nil {
		return
	}

	// initializers.DB.Where("email = ?", user.Email).First(&userModel)
	result := query.FindUser(&userModel, user.Email)
	if result == 1 {
		c.JSON(http.StatusOK, gin.H{
			"status":http.StatusOK,
			"message":"authorized",
			"data":&userModel,
		})
	} else {
		c.JSON(http.StatusForbidden, gin.H{
			"status":http.StatusForbidden,
			"message":"Your account is not available",
		})
	}

	// fmt.Println(user.Email)
}

func CreateUser(c *gin.Context) {
	var user models.User

	if err := c.BindJSON(&user); err != nil{
		return
	}

	query.CreateUser(user)

	c.JSON(http.StatusCreated, gin.H{
		"status":http.StatusCreated,
		"message":"User successfully created",
		"user":user,
	})
}

func GetUserByID(c *gin.Context) {
	id := c.Params.ByName("id")

	var user models.User
	// if err := c.BindJSON(&user); err != nil {
	// 	return
	// }
	// kalo get gk perlu di bind data nya kecuali mau insert atau create

	query.GetUserByID(&user, id)

	c.JSON(http.StatusFound, user)
}

func UpdateUser(c *gin.Context) {
	// get id of url / user
	id := c.Params.ByName("id")
	
	
	// find the user were updating
	var user models.User
	query.GetUserByID(&user, id)
	
	// get data of body
	var userBody models.User
		if err := c.BindJSON(&userBody); err != nil {
			return
		}
	// updating user
	query.UpdateUser(&user, userBody)

	// return response
	c.JSON(http.StatusCreated, userBody)
}

func DeleteUser(c *gin.Context) {
	id := c.Params.ByName("id")
	var user models.User
	// c.BindJSON(&user)

	query.DeleteUser(&user, id)

	c.JSON(http.StatusOK, gin.H{
		"status": http.StatusGone,
	})
}