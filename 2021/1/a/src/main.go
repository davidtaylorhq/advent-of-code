package main

import (
	"fmt"
	"os"
	"strconv"
	"strings"
)

func check(e error) {
	if e != nil {
		panic(e)
	}
}

func main() {
	dat, err := os.ReadFile("input.txt")
	check(err)
	stringData := string(dat)
	values := strings.Split(stringData, "\n")

	numbers := make([]int, 0, len(values))

	for _, v := range values {
		intValue, err := strconv.Atoi(v)
		check(err)
		numbers = append(numbers, intValue)
	}

	numberOfIncreases := 0
	for i := 0; i < len(numbers)-1; i++ {
		if numbers[i+1] > numbers[i] {
			numberOfIncreases++
		}
	}

	fmt.Print(numberOfIncreases, " values were increasing")
}
