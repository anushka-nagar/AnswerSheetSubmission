package main

import (
	pb "AnsSheetChecker/AnsSheetCheckerGenerated"
	"context"
	"errors"
	"fmt"
	"google.golang.org/grpc"
	"io"
	"log"
	"math/rand"
	"net"
	"os"
	"strconv"
	"strings"
	"sync"
	"time"
)

const basePath = "e:/go/AnsSheetChecker/uploads/"
const submissionNotFound = "could not find submission"
const empty = ""

const detailsMissing = "details missing: could not add submission"
const fileMissing = "file missing: could not add submission"

type server struct {
	pb.AnsSheetCheckerServer
}

var submissionTest = &pb.Submission{
	Id:           30,
	StudentName:  "Test30",
	StudentEmail: "test@mail.com",
	File: &pb.File{
		FileName:      "hello.txt",
		LocalFileName: "123Testhello.txt",
		FilePath:      basePath + "123Testhello.txt",
		FileSize:      3,
	},
}

var submissionTest2 = &pb.Submission{
	Id:           66,
	StudentName:  "Test66",
	StudentEmail: "test@mail.com",
	File: &pb.File{
		FileName:      "hello.txt",
		LocalFileName: "1234Testhello.txt",
		FilePath:      basePath + "1234Testhello.txt",
		FileSize:      3,
	},
}

var submissionTest3 = &pb.Submission{
	Id:           75,
	StudentName:  "Test75",
	StudentEmail: "test@mail.com",
	File: &pb.File{
		FileName:      "hello.txt",
		LocalFileName: "12345Testhello.txt",
		FilePath:      basePath + "12345Testhello.txt",
		FileSize:      3,
	},
}
var db = map[int64]*pb.Submission{
	30: submissionTest,
	66: submissionTest2,
	75: submissionTest3,
}

type apiMutex struct {
	addMutex             sync.Mutex
	getSubByIdMutex      sync.Mutex
	getAllSubsByIdsMutex sync.Mutex
	getAllSubsMutex      sync.Mutex
	updateSubMutex       sync.Mutex
	deleteSubMutex       sync.Mutex
	counterMutex         sync.Mutex
	updateDeleteMutex    sync.Mutex
}

type urlCountChannel struct {
	add         chan int
	getById     chan int
	getAllByIds chan int
	getAll      chan int
	update      chan int
	delete      chan int
	urlCount    chan int
}

var urlCountChan = urlCountChannel{}
var apiHits = make(map[string]int)

var countChan = map[string]chan int{
	pb.Url_AddSubmission.String():          urlCountChan.add,
	pb.Url_GetSubmissionById.String():      urlCountChan.getById,
	pb.Url_GetAllSubmissionsByIds.String(): urlCountChan.getAllByIds,
	pb.Url_GetAllSubmissions.String():      urlCountChan.getAll,
	pb.Url_UpdateSubmissionById.String():   urlCountChan.update,
	pb.Url_DeleteSubmissionById.String():   urlCountChan.delete,
	pb.Url_GetUrlRequestCounter.String():   urlCountChan.urlCount,
}

var mutex = apiMutex{
	addMutex:             sync.Mutex{},
	getAllSubsByIdsMutex: sync.Mutex{},
	getSubByIdMutex:      sync.Mutex{},
	getAllSubsMutex:      sync.Mutex{},
	updateSubMutex:       sync.Mutex{},
	deleteSubMutex:       sync.Mutex{},
	counterMutex:         sync.Mutex{},
	updateDeleteMutex:    sync.Mutex{},
}

func random() int64 {
	rand.Seed(time.Now().UnixNano())
	return rand.Int63n(100)
}

func (s *server) AddSubmission(_ context.Context, req *pb.Submission) (*pb.Submission, error) {
	//counting api hits
	mutex.addMutex.Lock()
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

	//validation
	if req.StudentName == empty || req.StudentEmail == empty {
		return nil, errors.New(detailsMissing)
	}

	if req.File == nil {
		return nil, errors.New(fileMissing)
	}

	if req.File.FileName == empty || len(req.File.FileBuffer) == 0 {
		return nil, errors.New(fileMissing)
	}

	response := &pb.Submission{}
	responseFile := &pb.File{}

	mutex.addMutex.Lock()
	response.Id = random()
	response.Timestamp = time.Now().UnixMilli()
	mutex.addMutex.Unlock()

	response.StudentName = req.StudentName
	response.StudentEmail = req.StudentEmail

	//making uploads directory
	err := os.MkdirAll(basePath, os.ModePerm)
	if err != nil {
		return nil, err
	}
	fileName := req.File.FileName
	localFileName := strconv.FormatInt(response.Timestamp, 10) + req.StudentName + fileName
	filePath := basePath + localFileName

	//creating file
	fileCreated, err := os.Create(filePath)
	if err != nil {
		return nil, err
	}

	reader := strings.NewReader(string(req.File.FileBuffer))
	_, err = io.Copy(fileCreated, reader)
	if err != nil {
		return nil, err
	}

	responseFile.FileName = req.File.FileName
	responseFile.FileSize = int64(len(req.File.FileBuffer))
	responseFile.LocalFileName = localFileName
	responseFile.FilePath = filePath

	response.File = responseFile

	mutex.addMutex.Lock()
	db[response.Id] = response
	mutex.addMutex.Unlock()
	return response, nil
}

func (s *server) GetSubmissionById(_ context.Context, req *pb.ByIdRequest) (*pb.Submission, error) {
	//counting api hits
	mutex.getSubByIdMutex.Lock()
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

	id := req.Id
	sub, found := db[id]
	if !found {
		return nil, errors.New(submissionNotFound)
	}

	//reading file from storage
	buff, err := os.ReadFile(sub.File.FilePath)
	if err != nil {
		return nil, err
	}

	mutex.getSubByIdMutex.Lock()
	sub.File.FileBuffer = buff
	mutex.getSubByIdMutex.Unlock()
	return sub, nil
}

func (s *server) GetAllSubmissionsByIds(_ context.Context, req *pb.ByIdsRequest) (*pb.SubmissionsArray, error) {
	//counting api hits
	mutex.getAllSubsByIdsMutex.Lock()
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

	ids := req.Ids
	response := &pb.SubmissionsArray{}
	wg := new(sync.WaitGroup)
	wg.Add(len(ids))

	//looping over requested ids
	for _, id := range ids {
		sub, found := db[id]
		if !found {
			wg.Done()
			continue
		}

		//running go routines to load files
		go func() {
			defer wg.Done()
			//opening file from storage
			buff, err := os.ReadFile(sub.File.FilePath)
			if err != nil {
				log.Println(err.Error())
				return
			}
			sub.File.FileBuffer = buff
			mutex.getAllSubsByIdsMutex.Lock()
			response.Submission = append(response.Submission, sub)
			mutex.getAllSubsByIdsMutex.Unlock()
		}()
	}
	wg.Wait()
	return response, nil
}

func (s *server) GetAllSubmissions(_ context.Context, _ *pb.Empty) (*pb.SubmissionsArray, error) {
	//counting api hits
	mutex.getAllSubsMutex.Lock()
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

	response := &pb.SubmissionsArray{}
	wg := new(sync.WaitGroup)
	wg.Add(len(db))

	//looping over all submissions
	for _, submission := range db {
		//running go routines to load files
		submissionTemp := submission
		go func() {
			defer wg.Done()
			//opening file from storage
			buff, err := os.ReadFile(submissionTemp.File.FilePath)
			if err != nil {
				log.Println(err.Error())
				return
			}
			submissionTemp.File.FileBuffer = buff
			mutex.getAllSubsMutex.Lock()
			response.Submission = append(response.Submission, submissionTemp)
			mutex.getAllSubsMutex.Unlock()
		}()
	}
	wg.Wait()
	return response, nil
}

func (s *server) UpdateSubmissionById(_ context.Context, req *pb.Submission) (*pb.Submission, error) {
	//counting api hits
	mutex.updateSubMutex.Lock()
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

	response := &pb.Submission{}
	id := req.Id
	submission, found := db[id]
	if !found {
		return nil, errors.New(submissionNotFound)
	}

	if submission.StudentName == empty || submission.StudentEmail == empty {
		return nil, errors.New(detailsMissing)
	}

	mutex.updateDeleteMutex.Lock()
	submission.StudentName = req.StudentName
	submission.StudentEmail = req.StudentEmail
	mutex.updateDeleteMutex.Unlock()
	response = submission
	return response, nil
}

func (s *server) DeleteSubmissionById(_ context.Context, req *pb.ByIdRequest) (*pb.Empty, error) {
	//counting api hits
	mutex.deleteSubMutex.Lock()
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

	id := req.Id
	submission, found := db[id]
	if !found {
		return nil, errors.New(submissionNotFound)
	}
	err := os.Remove(submission.File.FilePath)
	if err != nil {
		log.Println(err.Error())
	}
	mutex.updateDeleteMutex.Lock()
	delete(db, id)
	mutex.updateDeleteMutex.Unlock()
	return &pb.Empty{}, nil
}

func (s *server) GetUrlRequestCounter(_ context.Context, req *pb.GetUrlRequestCounterRequest) (*pb.GetUrlRequestCounterResponse, error) {
	//counting api hits
	mutex.counterMutex.Lock()
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

	response := &pb.GetUrlRequestCounterResponse{}
	url := req.Url
	select {
	case res := <-countChan[url.String()]:
		response.N = int64(res)
		return response, nil
	default:
		res, found := apiHits[url.String()]
		if !found {
			response.N = 0
		}
		response.N = int64(res)
		return response, nil
	}
}

func (s *server) DownloadFiles(_ *pb.Empty, stream pb.AnsSheetChecker_DownloadFilesServer) error {
	for _, submission := range db {
		file := &pb.File{}
		if submission.File == nil {
			log.Println(fileMissing)
			return errors.New(fileMissing)
		}
		file = submission.File

		readFile, err := os.ReadFile(file.FilePath)
		if err != nil {
			return err
		}

		file.FileBuffer = readFile

		err = stream.Send(file)
		if err != nil {
			return err
		}
	}
	return nil
}

func (s *server) UploadFiles(stream pb.AnsSheetChecker_UploadFilesServer) error {
	responseFileArray := &pb.FileArray{}
	for {
		file, err := stream.Recv()
		if err != nil {
			return err
		}

		if err == io.EOF {
			err := stream.SendAndClose(responseFileArray)
			if err != nil {
				return err
			}
		}

		if file == nil {
			return errors.New(fileMissing)
		}

		if file.FileName == empty || len(file.FileBuffer) == 0 {
			return errors.New(fileMissing)
		}

		localFileName := strconv.FormatInt(random(), 10) + file.FileName
		filePath := basePath + localFileName

		//creating file
		fileCreated, err := os.Create(filePath)
		if err != nil {
			return err
		}

		reader := strings.NewReader(string(file.FileBuffer))
		_, err = io.Copy(fileCreated, reader)
		if err != nil {
			return err
		}

		responseFile := &pb.File{}
		responseFile.FileName = file.FileName
		responseFile.LocalFileName = localFileName
		responseFile.FilePath = filePath
		responseFile.FileSize = int64(len(file.FileBuffer))
		responseFileArray.File = append(responseFileArray.File, responseFile)
	}
}

func main() {
	lis, err := net.Listen("tcp", fmt.Sprintf(":%d", 443))
	if err != nil {
		log.Printf("failed to listen: %v", err)
		return
	}
	s := grpc.NewServer()
	pb.RegisterAnsSheetCheckerServer(s, &server{})
	log.Printf("server listening at %v", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Printf("failed to serve: %v", err)
		return
	}
}
