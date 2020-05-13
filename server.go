package main

import (
	"fmt"
	"net/http"
	"sort"
)

func handleWhoami(w http.ResponseWriter, req *http.Request) {
	fmt.Fprintf(w, "%s %s %s\n", req.Method, req.URL.String(), req.Proto)
	fmt.Fprintf(w, "Host: %s\n", req.Host)
	keys := make([]string, 0, len(req.Header))
	for k := range req.Header {
		keys = append(keys, k)
	}
	sort.Strings(keys)
	for _, header := range keys {
		values := req.Header[header]
		for _, v := range values {
			fmt.Fprintf(w, "%s: %s\n", header, v)
		}
	}
}

func main() {
	http.HandleFunc("/", handleWhoami)
	http.ListenAndServe(":8080", nil)
}