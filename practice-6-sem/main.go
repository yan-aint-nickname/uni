package main

import (
	"fmt"
	"net/http"
	"time"
	"log"
	"encoding/json"
)

type HelloHandler struct {
	Path string
	HandlerFunc func(http.ResponseWriter, *http.Request)
	Method string
}

func (h HelloHandler) GetPattern() string {
	return fmt.Sprintf("%s %s", h.Method, h.Path)
}

func (h HelloHandler) GetHandlerFunc() func(http.ResponseWriter, *http.Request) {
	return h.HandlerFunc
}

type Handler interface {
	GetPattern() string
	GetHandlerFunc() func(http.ResponseWriter, *http.Request)
}

func main() {
	router := ServerMuxDep()

	helloHandler := HelloHandler{
		Path: "/hello",
		HandlerFunc: helloHandlerFunc,
		Method: "GET",
	}
	SetupHandlers(router, helloHandler)
	srv := BuildServer(router)

	if err := RunServer(srv); err != nil {
		log.Fatal(err)
	}
}

func ServerMuxDep() *http.ServeMux {
	return http.NewServeMux()
}

func helloHandlerFunc(w http.ResponseWriter, r *http.Request) {
	log.Print("helloHandlerFunc GET")
	w.Header().Set("Content-Type", "application/json")
	v := r.URL.Query().Get("v")
	res, _ := json.Marshal(fmt.Sprintf("{'data': 'Hello %s'}", v))
	_, _ = w.Write(res)
}

func SetupHandlers(router *http.ServeMux, handlers ...Handler) {
	for _, h := range handlers {
		router.HandleFunc(h.GetPattern(), h.GetHandlerFunc())
	}
}

func BuildServer(smd *http.ServeMux) *http.Server  {
	return &http.Server{
		Addr:           ":8080",
		Handler:        smd,
		ReadTimeout:    10 * time.Second,
		WriteTimeout:   10 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}
}

func RunServer(srv *http.Server) error {
	log.Printf("Server running on localhost%s", srv.Addr)
	return srv.ListenAndServe()
}
