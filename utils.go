package main

import (
	"fmt"
	"os"
	"strconv"

	"github.com/akamensky/argparse"
)

func get_desc() string {
	var desc = `Gobuild demo
    This is a demo build
    `
	return desc
}

// parse command line options if given
func parseArgsV2(args []string) map[string]string {
	var err error
	retVal := make(map[string]string)
	desc := get_desc()
	parser := argparse.NewParser("godeploy-demo", desc)
	host := parser.String("i", "host", &argparse.Options{Help: "IP address to run on", Default: "0.0.0.0"})
	port := parser.String("p", "port", &argparse.Options{Help: "Port to listen on ", Default: "8999"})
	region := parser.String("r", "region", &argparse.Options{Help: "AWS region to connect"})
	environment := parser.String("e", "env", &argparse.Options{Help: "Environment to run in"})
	debug := parser.Flag("d", "debug", &argparse.Options{Help: "Run program under debug mode"})
	// Parse input
	err = parser.Parse(args)
	if err != nil {
		// In case of error print error and print usage
		// This can also be done by passing -h or --help flags
		fmt.Print(parser.Usage(err))
		os.Exit(1)
	}

	retVal["host"] = string(*host)
	retVal["port"] = string(*port)
	retVal["region"] = string(*region)
	retVal["environment"] = string(*environment)
	retVal["debug"] = strconv.FormatBool(*debug)

	return retVal

}
