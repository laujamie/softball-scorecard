package main

import (
	"context"
	"fmt"
	"log"
	"net/http"

	"github.com/a-h/templ"
	"github.com/labstack/echo/v4"
	"github.com/laujamie/scoresheet/components/pages"
	"github.com/laujamie/scoresheet/components/pages/createscorecard"
)

var count uint64

func main() {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return render(c, http.StatusOK, pages.Home(count))
	})

	e.POST("/add", func(c echo.Context) error {
		count++
		return c.String(http.StatusOK, fmt.Sprintf("%d", count))
	})

	e.GET("/scorecards/new", func(c echo.Context) error {
		return render(c, http.StatusOK, createscorecard.CreateScoreCard(
			createscorecard.CreateScorecardFormValues{}, createscorecard.CreateScorecardFormErrors{},
		))
	})

	e.POST("/scorecards/new", func(c echo.Context) error {
		log.Printf("lmao xd")
		homeTeam := c.FormValue("home-team")
		awayTeam := c.FormValue("away-team")
		errors := createscorecard.CreateScorecardFormErrors{}
		if len(homeTeam) == 0 {
			errors.HomeTeam = "Home team cannot be empty"
		} else if len(homeTeam) > 30 {
			errors.HomeTeam = "Home team has a maximum length of 30"
		}
		if len(awayTeam) == 0 {
			errors.AwayTeam = "Away team cannot be empty"
		} else if len(awayTeam) > 30 {
			errors.AwayTeam = "Away team has a maximum length of 30"
		}
		return render(c, http.StatusOK, createscorecard.Form(
			createscorecard.CreateScorecardFormValues{
				HomeTeam: homeTeam,
				AwayTeam: awayTeam,
			},
			errors,
		))
	})

	e.Logger.Fatal(e.Start(":42069"))
}

// render renders a templ component
func render(c echo.Context, status int, component templ.Component) error {
	c.Response().Writer.WriteHeader(status)
	err := component.Render(context.Background(), c.Response().Writer)
	if err != nil {
		return c.String(http.StatusInternalServerError, "failed to render response")
	}

	return nil
}
