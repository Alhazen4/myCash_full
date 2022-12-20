package query

import (
	"github.com/fajarhdev/go-mycash/initializers"
	"github.com/fajarhdev/go-mycash/models"
)

func GetAllArticles(article *[]models.Article) {
	initializers.DB.Find(&article)
}