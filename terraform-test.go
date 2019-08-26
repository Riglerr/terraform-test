package main

import (
	"net/http"
	"time"

	"github.com/gin-contrib/zap"
	"github.com/gin-gonic/gin"
	"go.uber.org/zap"
)

type response struct {
	Message string
	Data    string
}

func nameEndpoint(c *gin.Context) {
	name := c.Param("name")
	response := response{Message: "hello", Data: name}
	zap.L().Info("Hey")
	c.JSON(http.StatusOK, response)
}

func panicEndpoint(c *gin.Context) {
	panic("Help")
}

func main() {
	router := gin.New()
	logger, _ := zap.NewProduction()
	zap.ReplaceGlobals(logger)
	router.Use(ginzap.Ginzap(logger, time.RFC3339, true))
	router.Use(ginzap.RecoveryWithZap(logger, true))

	router.GET("/hello/:name", nameEndpoint)
	router.GET("/panic", panicEndpoint)
	router.Run()
}
