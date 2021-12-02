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
	lines := strings.Split(stringData, "\n")

	n := make([]int, 0, len(lines))

	for _, line := range lines {
		parts := strings.Split(line, " ")
		val, err := strconv.Atoi(parts[0])
		check(err)
		n = append(n, val)
	}

	numberOfIncreases := 0
	lastSum := n[0] + n[1] + n[2]
	for i := 3; i < len(n); i++ {
		newSum := n[i] + n[i-1] + n[i-2]
		if newSum > lastSum {
			numberOfIncreases++
		}
		lastSum = newSum
	}

	fmt.Print(numberOfIncreases, " values were increasing")
}
