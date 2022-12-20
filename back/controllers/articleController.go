package controllers

import (
	"net/http"

	"github.com/fajarhdev/go-mycash/models"
	"github.com/fajarhdev/go-mycash/query"
	"github.com/gin-gonic/gin"
)

func GetArticles(c *gin.Context){
	var articles []models.Article

	query.GetAllArticles(&articles)

	c.JSON(http.StatusOK, articles)
}