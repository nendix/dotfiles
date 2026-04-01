package main

import "fmt"

type ServerConfig struct {
	Host string
	Port int
}

func main() {
	// 1. Missing Import Error
	// Place your cursor on 'fmt'
	fmt.Println("Testing Neovim native code actions")

	var test string
	for i := 0; i < 10; i++ {
		fmt.Println(i)
		fmt.Println(test)
	}

	// 2. Struct Initialization Warning
	// Place your cursor on 'ServerConfig'
	cfg := ServerConfig{}
	// TODO: sdadsa
}
