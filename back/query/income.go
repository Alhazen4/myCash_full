package query

import (

	"github.com/fajarhdev/go-mycash/initializers"
	"github.com/fajarhdev/go-mycash/models"
)

func AddIncome(income *models.Income) {
	initializers.DB.Omit("User").Create(&income)

}

func GetAllIncome(income *[]models.Income, id int) {
	initializers.DB.Where("user_id = ?", id).Joins("User").Find(&income)
}

func UpdateIncome(income *models.Income, updateIncome models.Income, id int) {
	// initializers.DB.Model(&income).Update(&updateIncome)
	initializers.DB.Model(&income).Where("id = ?", id).Updates(&updateIncome)
}

// delete specific income
func DeleteIncome(income *models.Income, id int) (err error){
	initializers.DB.Delete(&income, id)
	return
}