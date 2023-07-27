package main

import (
	"encoding/json"
	"log"
	"net/http"
)

const Secret = "authorization"

func toErro(w http.ResponseWriter, data any, status int) {
	me := map[string]any{"error": data}
	toJson(w, me, status)
}

func toJson(w http.ResponseWriter, data any, status int) {
	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(status)

	json.NewEncoder(w).Encode(data)
}

func simpleHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodGet {
		toErro(w, http.StatusText(405), http.StatusMethodNotAllowed)
		return
	}

	auth := r.Header.Get("Authorization")
	if auth == "" || auth != Secret {
		toErro(w, http.StatusText(401), http.StatusUnauthorized)
		return
	}

	var body map[string]any

	if err := json.NewDecoder(r.Body).Decode(&body); err != nil {
		toErro(w, http.StatusText(405), http.StatusBadRequest)
		return
	}

	name, ok := body["name"].(string)
	if !ok {
		toErro(w, http.StatusText(405), http.StatusBadRequest)
		return
	}

	toJson(w, map[string]any{"message": "hello " + name}, http.StatusOK)
}

func main() {

	mux := http.NewServeMux()
	mux.HandleFunc("/", simpleHandler)

	log.Println("server starting port 3000")
	log.Fatal(http.ListenAndServe(":3000", mux))
}
