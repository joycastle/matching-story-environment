package main

import (
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

func main() {
	ftpl := flag.String("tpl", "", "带有模板的文件路径")
	fdata := flag.String("data", "", "带有数据的文件路径")
	fout := flag.String("output", "", "数据输出文件路径")
	flag.Parse()

	ftplcontents, err := ioutil.ReadFile(*ftpl)
	if err != nil {
		fmt.Println("format:", "read tpl file error:", *ftpl, err.Error())
		os.Exit(-1)
	}

	ftpls := string(ftplcontents)

	fdatacontents, err := ioutil.ReadFile(*fdata)
	if err != nil {
		fmt.Println("format:", "read data file error:", *fdata, err.Error())
		os.Exit(-1)
	}

	fdatas := string(fdatacontents)

	fdatamap := make(map[string]string)
	lines := strings.Split(fdatas, "\n")
	for _, line := range lines {
		line = strings.Join(strings.Fields(line), "")
		if len(line) == 0 {
			continue
		}
		arr := strings.Split(line, "=")
		if len(arr) < 2 {
			fmt.Println("format:", "parse data error:", "["+line+"]", "must split with '='")
			os.Exit(-1)
		}
		if len(arr) > 2 {
			fmt.Println("format:", "parse data error:", "["+line+"]", "delimiter '=' only one")
			os.Exit(-1)
		}
		fdatamap[arr[0]] = arr[1]
	}

	data := os.Expand(ftpls, func(k string) string { return fdatamap[k] })

	if err := ioutil.WriteFile(*fout, []byte(data), 0644); err != nil {
		fmt.Println("format:", "write file error:", err.Error())
		os.Exit(-1)
	}
	fmt.Println("success")
}
