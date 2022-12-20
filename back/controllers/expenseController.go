package controllers

import (
	"net/http"
	"strconv"

	"github.com/fajarhdev/go-mycash/models"
	"github.com/fajarhdev/go-mycash/query"
	"github.com/gin-gonic/gin"
)

// adding the expenses
func AddExpense(c *gin.Context) {
	var expense models.Expense

	if err := c.BindJSON(&expense); err != nil {
		return
	}

	query.AddExpense(&expense)

	var userStatus, totalAmount = TransactionCore(c)
	
	c.JSON(http.StatusCreated, gin.H{
		"message":"Successfuly created income",
		"status":http.StatusCreated,
		"data":expense,
		"user_status":userStatus,
		"total_amount":totalAmount,
	})
}


// fetch all of the expenses transaction by spesific user
func GetAllExpense(c *gin.Context){
	var expense []models.Expense
	
	id, _ := strconv.Atoi(c.Params.ByName("id"))

	query.GetAllExpense(&expense, id)

	c.JSON(http.StatusOK, gin.H{
		"status":http.StatusOK,
		"message":"Found expenses data",
		"data":expense,
	})
}

func UpdateExpense(c *gin.Context)  {
	var expense models.Expense
	var expenseBody models.Expense
	

	if err := c.BindJSON(&expenseBody); err != nil {
		return
	}

	id, _ := strconv.Atoi(c.Params.ByName("id"))

	query.UpdateExpense(&expense, expenseBody, id)

	var userStatus, totalAmount = TransactionCore(c)

	c.JSON(http.StatusOK, gin.H{
		"status": http.StatusOK,
		"message":"Success updating",
		"data":expenseBody,
		"user_status":userStatus,
		"total_amount":totalAmount,
	})
}

func DeleteExpense(c *gin.Context)  {
	var expense models.Expense
	
	id, _ := strconv.Atoi(c.Params.ByName("id"))

	query.DeleteExpense(&expense, id)

	var userStatus, totalAmount = TransactionCore(c)
	
	c.JSON(http.StatusOK, gin.H{
		"status":http.StatusOK,
		"message":"Income has successfuly deleted",
		"user_status":userStatus,
		"total_amount":totalAmount,
	})
}