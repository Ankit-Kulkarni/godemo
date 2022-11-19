package main

import (
	"fmt"
	"net"
	"os"
)

func main() {
	var protocol, address, environment, region string
	var debugProgram bool
	protocol = "tcp"
	address = "localhost:8080"
	environment = "test"
	region = "us-east-1"
	debugProgram = false

	// collect command line arguments
	var cmd_args = os.Args

	// Arguments parsing
	parsedArgs := parseArgsV2(cmd_args)
	address = parsedArgs["host"] + ":" + parsedArgs["port"]
	if parsedArgs["debug"] == "true" {
		debugProgram = true
	}

	if parsedArgs["environment"] != "" {
		environment = parsedArgs["environment"]
	}

	if parsedArgs["region"] != "" {
		region = parsedArgs["region"]
	}

	// Run  a tcp server
	socket, err := net.Listen(protocol, address)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}

	//  Just printing strings
	fmt.Println("This program is running with following values")
	fmt.Println("environment: ", environment)
	fmt.Println("region: ", region)
	fmt.Println("Debug mode: ", debugProgram)

	// fmt.Println("hello world")

	defer socket.Close()

	// Run forever
	select {}
}
