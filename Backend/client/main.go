package main

import (
	pb "AnsSheetChecker/AnsSheetCheckerGenerated"
	"context"
	"flag"
	"google.golang.org/grpc"
	"io"
	"log"
	"time"
)

const connectionFailed = "connection failed - "
const couldNotAddSubmission = "could not add submission - "
const submissionNotFound = "submission not found - "
const urlNotFound = "could not find url - "
const basePath = "e:/go/AnsSheetChecker/uploads/"

var (
	addr = flag.String("address", "localhost:443", "the address to connect to")
)

func main() {
	flag.Parse()

	//connecting to the server
	conn, err := grpc.Dial(*addr, grpc.WithInsecure())
	if err != nil {
		log.Println(connectionFailed + err.Error())
		return
	}
	defer func(conn *grpc.ClientConn) {
		err := conn.Close()
		if err != nil {
			log.Println(connectionFailed + err.Error())
			return
		}
	}(conn)

	//creating client stub
	client := pb.NewAnsSheetCheckerClient(conn)

	//creating timeout context
	cxt, cancel := context.WithTimeout(context.Background(), 5*time.Second)
	defer cancel()

	//buff, err := os.ReadFile("../uploads/hello.txt")
	//if err != nil {
	//	log.Println(err.Error())
	//}

	//s := &pb.Submission{
	//	StudentName:  "Test",
	//	StudentEmail: "Test",
	//	File: &pb.File{
	//		FileName:      "hello.txt",
	//		LocalFileName: "hello.txt",
	//		FilePath:      basePath + "hello.txt",
	//		FileBuffer:    buff,
	//	},
	//}

	//addSubmission
	//log.Println(pb.Url_AddSubmission.String())
	//response, err := client.AddSubmission(cxt, s)
	//if err != nil {
	//	log.Println(couldNotAddSubmission + err.Error())
	//	return
	//}
	//log.Println(response)

	//download file
	stream, err := client.DownloadFiles(cxt, &pb.Empty{})
	if err != nil {
		log.Println(err.Error())
		return
	}
	for {
		file, err := stream.Recv()
		if err != nil {
			log.Println(err.Error())
			return
		}
		if err == io.EOF {
			break
		}
		log.Println(file)
	}

	////upload file
	//filebuff1, err := os.ReadFile(basePath + "hello.txt")
	//if err != nil {
	//	log.Println("1" + err.Error())
	//	return
	//}
	//filebuff2, err := os.ReadFile(basePath + "123Testhello.txt")
	//if err != nil {
	//	log.Println("2" + err.Error())
	//	return
	//}
	//file1 := pb.File{
	//	FileName:   "hello.txt",
	//	FileBuffer: filebuff1,
	//}
	//
	//file2 := pb.File{
	//	FileName:   "123Testhello.txt",
	//	FileBuffer: filebuff2,
	//}
	//fileArray := pb.FileArray{File: []*pb.File{&file1, &file2}}
	//
	//stream2, err := client.UploadFiles(cxt)
	//if err != nil {
	//	log.Println(err.Error())
	//	return
	//}
	//
	//for _, fileTemp := range fileArray.File {
	//	err = stream2.Send(fileTemp)
	//	if err != nil {
	//		log.Println("3" + err.Error())
	//		return
	//	}
	//}
	//
	//reply, err := stream2.CloseAndRecv()
	//if err != nil {
	//	log.Println(err.Error())
	//	return
	//}
	//log.Println(reply)

	////getSubmissionById
	//log.Println(pb.Url_GetSubmissionById.String())
	//response, err = client.GetSubmissionById(cxt, &pb.ByIdRequest{Id: 33})
	//if err != nil {
	//	log.Println(submissionNotFound + err.Error())
	//	return
	//}
	//log.Println(response)
	//
	////getSubmissionByIds
	//log.Println(pb.Url_GetAllSubmissionsByIds.String())
	//responseArr, err := client.GetAllSubmissionsByIds(cxt, &pb.ByIdsRequest{Ids: []int64{21, 33}})
	//if err != nil {
	//	log.Println(submissionNotFound + err.Error())
	//	return
	//}
	//log.Println(responseArr)
	//
	////getAllSubmissions
	//log.Println(pb.Url_GetAllSubmissions.String())
	//responseArr, err = client.GetAllSubmissions(cxt, &pb.Empty{})
	//if err != nil {
	//	log.Println(submissionNotFound + err.Error())
	//	return
	//}
	//log.Println(responseArr)
	//
	////updateSubmission
	//log.Println(pb.Url_UpdateSubmissionById.String())
	//updateResponse, err := client.UpdateSubmissionById(cxt, &pb.Submission{
	//	Id:           33,
	//	StudentName:  "Anushka",
	//	StudentEmail: "mail@mail.com",
	//})
	//if err != nil {
	//	log.Println(submissionNotFound + err.Error())
	//	return
	//}
	//log.Println(updateResponse)
	//
	////deleteSubmission
	//log.Println(pb.Url_DeleteSubmissionById.String())
	//deleteResponse, err := client.DeleteSubmissionById(cxt, &pb.ByIdRequest{Id: 33})
	//if err != nil {
	//	log.Println(submissionNotFound + err.Error())
	//	return
	//}
	//log.Println(deleteResponse)
	//
	////getAllSubmissions
	//log.Println(pb.Url_GetAllSubmissions.String())
	//responseArr, err = client.GetAllSubmissions(cxt, &pb.Empty{})
	//if err != nil {
	//	log.Println(submissionNotFound + err.Error())
	//	return
	//}
	//log.Println(responseArr)
	//
	////get url request counter
	//log.Println(pb.Url_GetUrlRequestCounter.String())
	//hits, err := client.GetUrlRequestCounter(cxt, &pb.GetUrlRequestCounterRequest{Url: pb.Url_GetUrlRequestCounter})
	//if err != nil {
	//	log.Println(urlNotFound + err.Error())
	//	return
	//}
	//log.Println(pb.Url_GetUrlRequestCounter.String())
	//log.Println(hits)
	//
	//hits2, err := client.GetUrlRequestCounter(cxt, &pb.GetUrlRequestCounterRequest{Url: pb.Url_AddSubmission})
	//if err != nil {
	//	log.Println(urlNotFound + err.Error())
	//	return
	//}
	//log.Println(pb.Url_AddSubmission.String())
	//log.Println(hits2)

}
