package main

import (
	"fmt"
	"net/http"
	"time"
	"log"
	"encoding/json"
	"encoding/xml"
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
		HandlerFunc: handlerFuncHello,
		Method: "GET",
	}
	SetupHandlers(router, helloHandler)
	srv := BuildServer(router)

	if err := RunServer(srv); err != nil {
		log.Fatal(err)
	}
}

type Greeting struct {
	To string `xml:"to,attr" json:"to"`
}

type GreetingResp struct {
	Greeting Greeting `xml:"greeting" json:"greeting"`
}

func ServerMuxDep() *http.ServeMux {
	return http.NewServeMux()
}

func handlerFuncHello(w http.ResponseWriter, r *http.Request) {
	log.Print("helloHandlerFunc GET")

	v := r.URL.Query().Get("value")
	t := r.URL.Query().Get("type")

	greeting := GreetingResp{
		Greeting: Greeting{To: fmt.Sprintf("Hello %s", v)},
	}

	switch t {
	case "json":
		w.Header().Set("Content-Type", "application/json")
		res, _ := json.Marshal(greeting)
		_, _ = w.Write(res)
	case "xml":
		w.Header().Set("Content-Type", "application/xml")
		res, _ := xml.Marshal(greeting)
		_, _ = w.Write(res)
	default:
		http.Error(w, "Not a valid format", http.StatusBadRequest)
	}
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
