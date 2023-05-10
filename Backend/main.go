package main

import (
	pb "AnsSheetChecker/AnsSheetCheckerGenerated"
	"encoding/json"
	"io"
	"log"
	"math/rand"
	"net/http"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
)

const maxUploadSize = 32 << 20
const basePath = "e:/go/AnsSheetChecker/uploads/"
const StudentName = "StudentName"
const StudentEmail = "StudentEmail"
const file = "file"

const methodUnsupported = "Method Unsupported"
const submissionNotFound = "Could not find submission"
const deletedSuccessfully = "Deleted successfully"

type urlCountChannel struct {
	add         chan int
	getById     chan int
	getAllByIds chan int
	getAll      chan int
	update      chan int
	delete      chan int
	urlCount    chan int
}

type apiMutex struct {
	addMutex             sync.Mutex
	getSubByIdMutex      sync.Mutex
	getAllSubsByIdsMutex sync.Mutex
	getAllSubsMutex      sync.Mutex
	updateSubMutex       sync.Mutex
	deleteSubMutex       sync.Mutex
	counterMutex         sync.Mutex
}

var db = make(map[int64]*pb.Submission)
var apiHits = make(map[string]int)

var mutex = apiMutex{
	addMutex:             sync.Mutex{},
	getAllSubsByIdsMutex: sync.Mutex{},
	getSubByIdMutex:      sync.Mutex{},
	getAllSubsMutex:      sync.Mutex{},
	updateSubMutex:       sync.Mutex{},
	deleteSubMutex:       sync.Mutex{},
	counterMutex:         sync.Mutex{},
}

var countChan = map[string]chan int{
	pb.Url_AddSubmission.String():          urlCountChan.add,
	pb.Url_GetSubmissionById.String():      urlCountChan.getById,
	pb.Url_GetAllSubmissionsByIds.String(): urlCountChan.getAllByIds,
	pb.Url_GetAllSubmissions.String():      urlCountChan.getAll,
	pb.Url_UpdateSubmissionById.String():   urlCountChan.update,
	pb.Url_DeleteSubmissionById.String():   urlCountChan.delete,
	pb.Url_GetUrlRequestCounter.String():   urlCountChan.urlCount,
}

var urlCountChan = urlCountChannel{}

//var countChan = make(map[string]chan int)

var s = &pb.Submission{
	Id:           30,
	StudentName:  "Test",
	StudentEmail: "Test",
	File: &pb.File{
		FileName:      "hello.txt",
		LocalFileName: "hello.txt",
		FilePath:      basePath + "hello.txt",
		FileSize:      maxUploadSize,
	},
	Timestamp: time.Now().UnixMilli(),
}

func random() int64 {
	rand.Seed(time.Now().UnixNano())
	return rand.Int63n(100)
}

func addSubmission(w http.ResponseWriter, r *http.Request) {
	log.Println("add submission...")
	mutex.addMutex.Lock()
	//counting api hits
	n, found := apiHits[pb.Url_AddSubmission.String()]
	if !found {
		urlCountChan.add = make(chan int, 2)
		urlCountChan.add <- 1
		apiHits[pb.Url_AddSubmission.String()] = 1
		close(urlCountChan.add)
	} else {
		urlCountChan.add = make(chan int, 2)
		urlCountChan.add <- n + 1
		apiHits[pb.Url_AddSubmission.String()] = n + 1
		close(urlCountChan.add)
	}
	mutex.addMutex.Unlock()

	//unsupported method handle
	if r.Method != http.MethodPost {
		http.Error(w, methodUnsupported, http.StatusMethodNotAllowed)
		return
	}

	//parsing multipart form
	err := r.ParseMultipartForm(maxUploadSize)
	if err != nil {
		http.Error(w, err.Error(), http.StatusBadRequest)
		return
	}
	name := r.FormValue(StudentName)
	email := r.FormValue(StudentEmail)
	fileInput, header, err := r.FormFile(file)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	//create folder uploads
	err = os.MkdirAll(basePath, os.ModePerm)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	mutex.addMutex.Lock()
	id := random()
	timestamp := time.Now().UnixMilli()
	mutex.addMutex.Unlock()

	fileName := header.Filename
	size := header.Size
	timeString := strconv.FormatInt(timestamp, 10)
	localFileName := name + timeString + fileName
	path := basePath + localFileName
	buff := make([]byte, size)
	_, err = fileInput.Read(buff)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	tempFile := &pb.File{FileName: fileName, FilePath: path, LocalFileName: localFileName, FileSize: size, FileBuffer: buff}
	submission := &pb.Submission{Id: id, StudentName: name, StudentEmail: email, Timestamp: timestamp, File: tempFile}

	//create file
	fileCreated, err := os.Create(path)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	reader := strings.NewReader(string(submission.File.FileBuffer))
	_, err = io.Copy(fileCreated, reader)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	err = fileCreated.Close()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	mutex.addMutex.Lock()
	db[id] = submission
	mutex.addMutex.Unlock()

	//return response
	err = json.NewEncoder(w).Encode(submission)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func getSubmissionById(w http.ResponseWriter, r *http.Request) {
	log.Println("get sub by id")
	mutex.getSubByIdMutex.Lock()
	//counting api hits
	n, found := apiHits[pb.Url_GetSubmissionById.String()]
	if !found {
		urlCountChan.getById = make(chan int, 2)
		urlCountChan.getById <- 1
		apiHits[pb.Url_GetSubmissionById.String()] = 1
		close(urlCountChan.getById)
	} else {
		urlCountChan.getById = make(chan int, 2)
		urlCountChan.getById <- n + 1
		apiHits[pb.Url_GetSubmissionById.String()] = n + 1
		close(urlCountChan.getById)
	}
	mutex.getSubByIdMutex.Unlock()

	//unsupported method handle
	if r.Method != http.MethodPost {
		http.Error(w, methodUnsupported, http.StatusMethodNotAllowed)
		return
	}

	//reading id from request body
	id := &pb.ByIdRequest{}
	err := json.NewDecoder(r.Body).Decode(&id)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	//finding and reading requested file
	submission, found := db[id.Id]
	if !found {
		http.Error(w, submissionNotFound, http.StatusInternalServerError)
		return
	}

	tempFile, err := os.Open(submission.File.FilePath)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	buff := make([]byte, submission.File.FileSize)

	_, err = tempFile.Read(buff)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	err = tempFile.Close()
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	submission.File.FileBuffer = buff

	err = json.NewEncoder(w).Encode(submission)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func getAllSubmissionsByIds(w http.ResponseWriter, r *http.Request) {
	log.Println("get all submissions by ids")
	mutex.getAllSubsByIdsMutex.Lock()
	//counting api hits
	n, found := apiHits[pb.Url_GetAllSubmissionsByIds.String()]
	if !found {
		urlCountChan.getAllByIds = make(chan int, 2)
		urlCountChan.getAllByIds <- 1
		apiHits[pb.Url_GetAllSubmissionsByIds.String()] = 1
		close(urlCountChan.getAllByIds)
	} else {
		urlCountChan.getAllByIds = make(chan int, 2)
		urlCountChan.getAllByIds <- n + 1
		apiHits[pb.Url_GetAllSubmissionsByIds.String()] = n + 1
		close(urlCountChan.getAllByIds)
	}
	mutex.getAllSubsByIdsMutex.Unlock()

	//unsupported method handle
	if r.Method != http.MethodPost {
		http.Error(w, methodUnsupported, http.StatusMethodNotAllowed)
		return
	}

	ids := &pb.ByIdsRequest{}

	err := json.NewDecoder(r.Body).Decode(&ids)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	res := make(map[int64]*pb.Submission)

	wg := new(sync.WaitGroup)
	wg.Add(len(ids.Ids))
	log.Println(len(ids.Ids))
	for _, id := range ids.Ids {
		log.Println(id)
		submissionTemp, found := db[id]
		if !found {
			log.Println(id)
			wg.Done()
			continue
		}

		go func() {
			defer wg.Done()
			tempFile, err := os.Open(submissionTemp.File.FilePath)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			buff := make([]byte, submissionTemp.File.FileSize)

			_, err = tempFile.Read(buff)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			err = tempFile.Close()
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			submissionTemp.File.FileBuffer = buff
			mutex.getAllSubsByIdsMutex.Lock()
			res[submissionTemp.Id] = submissionTemp
			mutex.getAllSubsByIdsMutex.Unlock()
		}()
	}

	wg.Wait()

	err = json.NewEncoder(w).Encode(res)
	if err != nil {
		log.Println("here")
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func getAllSubmissions(w http.ResponseWriter, _ *http.Request) {
	log.Println("get all submissions...")
	mutex.getAllSubsMutex.Lock()
	//counting api hits
	n, found := apiHits[pb.Url_GetAllSubmissions.String()]
	if !found {
		urlCountChan.getAll = make(chan int, 2)
		urlCountChan.getAll <- 1
		apiHits[pb.Url_GetAllSubmissions.String()] = 1
		close(urlCountChan.getAll)
	} else {
		urlCountChan.getAll = make(chan int, 2)
		urlCountChan.getAll <- n + 1
		apiHits[pb.Url_GetAllSubmissions.String()] = n + 1
		close(urlCountChan.getAll)
	}
	mutex.getAllSubsMutex.Unlock()

	res := make(map[int64]*pb.Submission)

	wg := new(sync.WaitGroup)
	wg.Add(len(db))
	log.Println(len(db))
	for _, submissionTemp := range db {
		submissionTemp := submissionTemp
		go func() {
			defer wg.Done()
			tempFile, err := os.Open(submissionTemp.File.FilePath)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			buff := make([]byte, submissionTemp.File.FileSize)

			_, err = tempFile.Read(buff)
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			err = tempFile.Close()
			if err != nil {
				http.Error(w, err.Error(), http.StatusInternalServerError)
				return
			}

			submissionTemp.File.FileBuffer = buff
			mutex.getAllSubsMutex.Lock()
			res[submissionTemp.Id] = submissionTemp
			mutex.getAllSubsMutex.Unlock()
		}()
	}

	wg.Wait()

	log.Println(len(res))

	err := json.NewEncoder(w).Encode(res)
	if err != nil {
		log.Println("here")
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func updateSubmissionById(w http.ResponseWriter, r *http.Request) {
	log.Println("Update submission...")
	mutex.updateSubMutex.Lock()
	//counting api hits
	n, found := apiHits[pb.Url_UpdateSubmissionById.String()]
	if !found {
		urlCountChan.update = make(chan int, 2)
		urlCountChan.update <- 1
		apiHits[pb.Url_UpdateSubmissionById.String()] = 1
		close(urlCountChan.update)
	} else {
		urlCountChan.update = make(chan int, 2)
		urlCountChan.update <- n + 1
		apiHits[pb.Url_UpdateSubmissionById.String()] = n + 1
		close(urlCountChan.update)
	}
	mutex.updateSubMutex.Unlock()

	//unsupported method handle
	if r.Method != http.MethodPost {
		http.Error(w, methodUnsupported, http.StatusMethodNotAllowed)
		return
	}

	reqData := &pb.Submission{}
	err := json.NewDecoder(r.Body).Decode(&reqData)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	log.Println(reqData.Id)

	submissionTemp, found := db[reqData.Id]
	if !found {
		log.Println(submissionNotFound)
		http.Error(w, submissionNotFound, http.StatusInternalServerError)
		return
	}

	if reqData.StudentName != "" {
		submissionTemp.StudentName = reqData.StudentName
	}

	if reqData.StudentEmail != "" {
		submissionTemp.StudentEmail = reqData.StudentEmail
	}

	mutex.updateSubMutex.Lock()
	db[reqData.Id] = submissionTemp
	mutex.updateSubMutex.Unlock()

	err = json.NewEncoder(w).Encode(submissionTemp)
	if err != nil {
		log.Println(err.Error())
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}
}

func deleteSubmissionById(w http.ResponseWriter, r *http.Request) {
	log.Println("delete submission...")
	mutex.deleteSubMutex.Lock()
	//counting api hits
	n, found := apiHits[pb.Url_DeleteSubmissionById.String()]
	if !found {
		urlCountChan.delete = make(chan int, 2)
		urlCountChan.delete <- 1
		apiHits[pb.Url_DeleteSubmissionById.String()] = 1
		close(urlCountChan.delete)
	} else {
		urlCountChan.delete = make(chan int, 2)
		urlCountChan.delete <- n + 1
		apiHits[pb.Url_DeleteSubmissionById.String()] = n + 1
		close(urlCountChan.delete)
	}
	mutex.deleteSubMutex.Unlock()

	//unsupported method handle
	if r.Method != http.MethodPost {
		http.Error(w, methodUnsupported, http.StatusMethodNotAllowed)
		return
	}

	id := &pb.ByIdRequest{}
	err := json.NewDecoder(r.Body).Decode(&id)
	if err != nil {
		log.Println(r.Body)
		log.Println("decode body")
		log.Println(err.Error())
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	log.Println(id.Id)

	submission, found := db[id.Id]
	if !found {
		log.Println("search submission")
		log.Println(err.Error())
		http.Error(w, submissionNotFound, http.StatusInternalServerError)
		return
	}

	err = os.Remove(submission.File.FilePath)
	if err != nil {
		log.Println("os remove")
		log.Println(err.Error())
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	mutex.deleteSubMutex.Lock()
	//removing from map
	delete(db, id.Id)
	mutex.deleteSubMutex.Unlock()

	//returning deleted submission
	err = json.NewEncoder(w).Encode(deletedSuccessfully)
	if err != nil {
		log.Println("json encode")
		log.Println(err.Error())
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

}

func getUrlRequestCounter(w http.ResponseWriter, r *http.Request) {
	mutex.counterMutex.Lock()
	//counting api hits
	n, found := apiHits[pb.Url_GetUrlRequestCounter.String()]
	if !found {
		urlCountChan.urlCount = make(chan int, 2)
		urlCountChan.urlCount <- 1
		apiHits[pb.Url_GetUrlRequestCounter.String()] = 1
		close(urlCountChan.urlCount)
	} else {
		urlCountChan.urlCount = make(chan int, 2)
		urlCountChan.urlCount <- n + 1
		apiHits[pb.Url_GetUrlRequestCounter.String()] = n + 1
		close(urlCountChan.urlCount)
	}
	mutex.counterMutex.Unlock()

	url := &pb.GetUrlRequestCounterRequest{}
	err := json.NewDecoder(r.Body).Decode(&url)
	if err != nil {
		http.Error(w, err.Error(), http.StatusInternalServerError)
		return
	}

	select {
	case res := <-countChan[url.Url.String()]:
		err = json.NewEncoder(w).Encode(res)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		return
	default:
		res, found := apiHits[url.Url.String()]
		if !found {
			res = 0
		}
		err = json.NewEncoder(w).Encode(res)
		if err != nil {
			http.Error(w, err.Error(), http.StatusInternalServerError)
			return
		}
		return
	}

}

func main() {
	log.Println("hello")
	db[30] = s
	http.HandleFunc("/addSubmission", addSubmission)
	http.HandleFunc("/getSubmissionById", getSubmissionById)
	http.HandleFunc("/getSubmissionsByIds", getAllSubmissionsByIds)
	http.HandleFunc("/getAllSubmissions", getAllSubmissions)
	http.HandleFunc("/updateSubmissionById", updateSubmissionById)
	http.HandleFunc("/deleteSubmissionById", deleteSubmissionById)
	http.HandleFunc("/getUrlRequestCounter", getUrlRequestCounter)
	log.Println("Server connecting...")
	err := http.ListenAndServe("localhost:8080", nil)
	log.Println("Server running...")
	if err != nil {
		log.Println("Cannot run server")
		return
	}
	log.Println("Server running...")
}
