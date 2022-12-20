package controllers

import (
	"net/http"
	"strconv"
	
	"github.com/fajarhdev/go-mycash/models"
	"github.com/fajarhdev/go-mycash/query"
	"github.com/gin-gonic/gin"
)

func TransactionCore(c *gin.Context) (UserStatus string, TotalAmount int) {
	id, _ := strconv.Atoi(c.Params.ByName("id"))
	var income models.Income
	var expense models.Expense
	var transactions models.Transaction

	// get sum income
	query.Income(&income, id)
	sumIncome := income.Amount
	
	// get sum expense
	query.Expense(&expense, id)
	sumExpense := expense.Amount
	// fmt.Println(sumIncome)
	// fmt.Println(sumExpense)

	// var UserStatus string
	// var TotalAmount int

	// user status logic
	if TotalAmount = sumIncome - sumExpense; TotalAmount > 0 {
		UserStatus = "Health"
	}else if TotalAmount < 0 {
		UserStatus = "Minus"
	} else {
		UserStatus = "Balance"
	}

	transaction := models.Transaction{
		TotalAmount: TotalAmount,
		Status: UserStatus,
		UserID: id,
	}

	// fmt.Println(query.GetAllTransactionByUser(&transactions, id))

	// post it to the db
	if result := query.GetAllTransactionByUser(&transactions, id); result > 0 {
		query.UpdateTransaction(&transactions, &transaction, id)
	}else {
		query.PostTransaction(transaction)
		// fmt.Println("LOHHH KOK KESINIIII")
	}

	return 
}


func Transaction(c *gin.Context) {
	// id, _ := strconv.Atoi(c.Params.ByName("id"))
	// var income models.Income
	// var expense models.Expense
	// var transactions models.Transaction

	// // get sum income
	// query.Income(&income, id)
	// sumIncome := income.Amount
	
	// // get sum expense
	// query.Expense(&expense, id)
	// sumExpense := expense.Amount
	// // fmt.Println(sumIncome)
	// // fmt.Println(sumExpense)

	// var userStatus string
	// var totalAmount int

	// // user status logic
	// if totalAmount = sumIncome - sumExpense; totalAmount > 0 {
	// 	userStatus = "Health"
	// }else if totalAmount < 0 {
	// 	userStatus = "Minus"
	// } else {
	// 	userStatus = "Balance"
	// }

	// transaction := models.Transaction{
	// 	TotalAmount: totalAmount,
	// 	Status: userStatus,
	// 	UserID: id,
	// }

	// // fmt.Println(query.GetAllTransactionByUser(&transactions, id))

	// // post it to the db
	// if result := query.GetAllTransactionByUser(&transactions, id); result > 0 {
	// 	query.UpdateTransaction(&transactions, &transaction, id)
	// }else {
	// 	query.PostTransaction(transaction)
	// 	// fmt.Println("LOHHH KOK KESINIIII")
	// }

	var userStatus, totalAmount = TransactionCore(c)

	c.JSON(http.StatusOK, gin.H{
		"status": http.StatusOK,
		"user_status": userStatus,
		"total_amount": totalAmount,
	})

}


// get all of the income transaction of specific user
// get all of the expense transaction od specific user
// fetch only the amount of each transaction
// calculate each transaction
// calculate the income - expense
// if the result is minus the deficit or not health
// if the result is zero than it balance
// if the result is plus than its surplus or healthy