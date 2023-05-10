package main

import (
	pb "AnsSheetChecker/AnsSheetCheckerGenerated"
	"context"
	"log"
	"os"
	"reflect"
	"regexp"
	"strconv"
	"testing"
	"time"
)

const idIncorrect = "id incorrect"
const nameIncorrect = "name incorrect"
const emailIncorrect = "email incorrect"
const fileNameIncorrect = "file name incorrect"
const localFileNameIncorrect = "local file name incorrect"
const filePathIncorrect = "file path incorrect"
const fileSizeZero = "file size zero"
const fileBufferEmpty = "file buffer empty"
const notDeleted = "not deleted"
const notANumber = "not a number"
const incorrectResponse = "incorrect response"
const wrongFile = "wrong file"

func TestServer_AddSubmission(t *testing.T) {
	wantId := regexp.MustCompile(`\d{1,2}`)
	wantName := regexp.MustCompile("Test")
	wantMail := regexp.MustCompile("test@mail.com")
	wantFileName := regexp.MustCompile("hello.txt")
	wantLocalFileName := regexp.MustCompile("[0-9]*" + "Test" + "hello.txt")
	wantPath := regexp.MustCompile(basePath + `[0-9]*` + "Test" + "hello.txt")

	cxt, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	buff, err := os.ReadFile(basePath + "hello.txt")
	if err != nil {
		log.Println(err.Error())
	}

	s := &pb.Submission{
		StudentName:  "Test",
		StudentEmail: "test@mail.com",
		File: &pb.File{
			FileName:   "hello.txt",
			FileBuffer: buff,
		},
	}

	msg, err := pb.AnsSheetCheckerServer.AddSubmission(&server{}, cxt, s)

	if err != nil {
		t.Errorf(err.Error())
	}

	if !wantId.MatchString(strconv.Itoa(int(msg.Id))) {
		t.Errorf(idIncorrect)
	}

	if !wantName.MatchString(msg.StudentName) {
		t.Errorf(nameIncorrect)
	}

	if !wantMail.MatchString(msg.StudentEmail) {
		t.Errorf(emailIncorrect)
	}

	if msg.File == nil {
		t.Errorf(fileMissing)
	}

	if !wantFileName.MatchString(msg.File.FileName) {
		t.Errorf(fileNameIncorrect)
	}
	if !wantLocalFileName.MatchString(msg.File.LocalFileName) {
		t.Errorf(localFileNameIncorrect)
	}

	if !wantPath.MatchString(msg.File.FilePath) {
		t.Errorf(filePathIncorrect)
	}
}

// todo: do not use regex
// todo: compare arrays using reflect.DeepEqual
func TestServer_GetSubmissionById(t *testing.T) {
	wantId := int64(66)
	wantName := "Test"
	wantMail := "test@mail.com"
	wantFileName := "hello.txt"
	wantLocalFileName := "1234Testhello.txt"
	wantPath := basePath + wantLocalFileName

	cxt, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	msg, err := pb.AnsSheetCheckerServer.GetSubmissionById(&server{}, cxt, &pb.ByIdRequest{Id: 66})

	if err != nil {
		t.Errorf(err.Error())
		return
	}

	if wantId != msg.Id {
		t.Errorf(idIncorrect)
	}

	if wantName != msg.StudentName {
		t.Errorf(nameIncorrect)
	}

	if wantMail != msg.StudentEmail {
		t.Errorf(emailIncorrect)
	}

	if msg.File == nil {
		t.Errorf(fileMissing)
	}

	if wantFileName != msg.File.FileName {
		t.Errorf(fileNameIncorrect)
	}
	if wantLocalFileName != msg.File.LocalFileName {
		t.Errorf(localFileNameIncorrect)
	}

	if wantPath != msg.File.FilePath {
		t.Errorf(filePathIncorrect)
	}

	if msg.File.FileSize == 0 {
		t.Errorf(fileSizeZero)
	}

	if !(len(msg.File.FileBuffer) > 0) {
		t.Errorf(fileBufferEmpty)
	}

	var readFileBuff, _ = os.ReadFile(msg.File.FilePath)
	if !reflect.DeepEqual(readFileBuff, msg.File.FileBuffer) {
		t.Errorf(wrongFile)
	}

}

func TestServer_GetAllSubmissionsByIds(t *testing.T) {
	wantId := regexp.MustCompile(`\d{1,2}`)
	wantName := regexp.MustCompile("[a-zA-Z]+")
	wantMail := regexp.MustCompile("[a-zA-Z]+")
	wantFileName := regexp.MustCompile("[a-zA-Z]+")
	wantLocalFileName := regexp.MustCompile("[0-9]*" + "[a-zA-Z]+")
	wantPath := regexp.MustCompile(basePath + `[0-9]*` + "[a-zA-Z]+")

	cxt, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	msg, err := pb.AnsSheetCheckerServer.GetAllSubmissionsByIds(&server{}, cxt, &pb.ByIdsRequest{Ids: []int64{30, 21}})

	if err != nil {
		t.Errorf(err.Error())
		return
	}

	for _, submission := range msg.Submission {
		if !wantId.MatchString(strconv.Itoa(int(submission.Id))) {
			t.Errorf(idIncorrect)
		}

		if !wantName.MatchString(submission.StudentName) {
			t.Errorf(nameIncorrect)
		}

		if !wantMail.MatchString(submission.StudentEmail) {
			t.Errorf(emailIncorrect)
		}

		if submission.File == nil {
			t.Errorf(fileMissing)
		}

		if !wantFileName.MatchString(submission.File.FileName) {
			t.Errorf(fileNameIncorrect)
		}
		if !wantLocalFileName.MatchString(submission.File.LocalFileName) {
			t.Errorf(localFileNameIncorrect)
		}

		if !wantPath.MatchString(submission.File.FilePath) {
			t.Errorf(filePathIncorrect)
		}

		if submission.File.FileSize == 0 {
			t.Errorf(fileSizeZero)
		}

		if !(len(submission.File.FileBuffer) > 0) {
			t.Errorf(fileBufferEmpty)
		}

		var readFileBuff, _ = os.ReadFile(submission.File.FilePath)
		if !reflect.DeepEqual(readFileBuff, submission.File.FileBuffer) {
			t.Errorf(wrongFile)
		}
	}
}

func TestServer_GetAllSubmissions(t *testing.T) {
	wantId := regexp.MustCompile(`\d{1,2}`)
	wantName := regexp.MustCompile("[a-zA-Z]+")
	wantMail := regexp.MustCompile("[a-zA-Z]+")
	wantFileName := regexp.MustCompile("[a-zA-Z]+")
	wantLocalFileName := regexp.MustCompile("[0-9]*" + "[a-zA-Z]+")
	wantPath := regexp.MustCompile(basePath + `[0-9]*` + "[a-zA-Z]+")

	cxt, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	msg, err := pb.AnsSheetCheckerServer.GetAllSubmissions(&server{}, cxt, &pb.Empty{})

	if err != nil {
		t.Errorf(err.Error())
		return
	}

	for _, submission := range msg.Submission {
		if !wantId.MatchString(strconv.Itoa(int(submission.Id))) {
			t.Errorf(idIncorrect)
		}

		if !wantName.MatchString(submission.StudentName) {
			t.Errorf(nameIncorrect)
		}

		if !wantMail.MatchString(submission.StudentEmail) {
			t.Errorf(emailIncorrect)
		}

		if submission.File == nil {
			t.Errorf(fileMissing)
		}

		if !wantFileName.MatchString(submission.File.FileName) {
			t.Errorf(fileNameIncorrect)
		}
		if !wantLocalFileName.MatchString(submission.File.LocalFileName) {
			t.Errorf(localFileNameIncorrect)
		}

		if !wantPath.MatchString(submission.File.FilePath) {
			t.Errorf(filePathIncorrect)
		}

		if submission.File.FileSize == 0 {
			t.Errorf(fileSizeZero)
		}

		if !(len(submission.File.FileBuffer) > 0) {
			t.Errorf(fileBufferEmpty)
		}
	}
}

func TestServer_UpdateSubmissionById(t *testing.T) {
	wantId := regexp.MustCompile(`\d{1,2}`)
	wantName := regexp.MustCompile("Anushka")
	wantMail := regexp.MustCompile("test@mail.com")
	wantFileName := regexp.MustCompile("hello.txt")
	wantLocalFileName := regexp.MustCompile("[0-9]*" + "Test" + "hello.txt")
	wantPath := regexp.MustCompile(basePath + `[0-9]*` + "Test" + "hello.txt")

	cxt, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	s := &pb.Submission{
		Id:           66,
		StudentName:  "Anushka",
		StudentEmail: "test@mail.com",
	}

	msg, err := pb.AnsSheetCheckerServer.UpdateSubmissionById(&server{}, cxt, s)

	if err != nil {
		t.Errorf(err.Error())
	}

	if !wantId.MatchString(strconv.Itoa(int(msg.Id))) {
		t.Errorf(idIncorrect)
	}

	if !wantName.MatchString(msg.StudentName) {
		t.Errorf(nameIncorrect)
	}

	if !wantMail.MatchString(msg.StudentEmail) {
		t.Errorf(emailIncorrect)
	}

	if msg.File == nil {
		t.Errorf(fileMissing)
	}

	if !wantFileName.MatchString(msg.File.FileName) {
		t.Errorf(fileNameIncorrect)
	}
	if !wantLocalFileName.MatchString(msg.File.LocalFileName) {
		t.Errorf(localFileNameIncorrect)
	}

	if !wantPath.MatchString(msg.File.FilePath) {
		t.Errorf(filePathIncorrect)
	}

}

func TestServer_DeleteSubmissionById(t *testing.T) {
	cxt, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err := pb.AnsSheetCheckerServer.DeleteSubmissionById(&server{}, cxt, &pb.ByIdRequest{Id: 75})

	if err != nil {
		t.Errorf(err.Error())
	}

	_, found := db[75]
	if found {
		t.Errorf(notDeleted)
	}
}

func TestServer_GetUrlRequestCounter(t *testing.T) {
	wantNumber := regexp.MustCompile(`\d+`)

	cxt, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	_, err := pb.AnsSheetCheckerServer.AddSubmission(&server{}, cxt, &pb.Submission{})
	if err != nil {
		log.Println(err.Error())
	}
	msg, err := pb.AnsSheetCheckerServer.GetUrlRequestCounter(&server{}, cxt, &pb.GetUrlRequestCounterRequest{Url: pb.Url_AddSubmission})

	if err != nil {
		t.Errorf(err.Error())
	}

	if !wantNumber.MatchString(strconv.Itoa(int(msg.N))) {
		t.Errorf(notANumber)
	}

	if msg.N != 1 {
		t.Errorf(incorrectResponse)
	}
}
