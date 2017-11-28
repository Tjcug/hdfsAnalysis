package com.basic.controller;

import com.basic.util.HDFSAnalysisUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.File;
import java.io.IOException;

/**
 * locate com.basic.controller
 * Created by mastertj on 2017/11/28.
 */
@Controller
public class HDFSAnalysisContorller extends BaseController{
    public static Logger logger= LoggerFactory.getLogger(HDFSAnalysisContorller.class);

    /**
     * 测试HDFS读写性能
     * @param filesize
     * @param filenum
     * @param modelRadios
     * @return
     *
     */
    @RequestMapping(value = "/hdfsAnalysis/testDFSIO"
            ,produces = "application/json;charset=UTF-8")
    @ResponseBody()
    public String testDFSIO(@RequestParam Integer filesize,@RequestParam Integer filenum,@RequestParam String modelRadios) throws IOException {
        logger.info("filesize = [" + filesize + "], filenum = [" + filenum + "], modelRadios = [" + modelRadios + "]");
        System.out.println("filesize = [" + filesize + "], filenum = [" + filenum + "], modelRadios = [" + modelRadios + "]");
        String str = hdfsAnalysisService.testDFSIO(filesize, filenum, modelRadios);
        return gson.toJson(str);
    }

    /**
     * 清除临时文件
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/hdfsAnalysis/cleanTemporaryFiles"
            ,produces = "application/json;charset=UTF-8")
    @ResponseBody()
    public String cleanTemporaryFiles() throws IOException {
        String str = hdfsAnalysisService.cleanTemporaryFiles();
        return gson.toJson(str);
    }

    /**
     * 显示当前测试结果
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/hdfsAnalysis/showresult"
            ,produces = "application/json;charset=UTF-8")
    @ResponseBody()
    public String showresult() throws IOException {
        File file = new File(resultDFSIOPath);
        String result="";
        if(!file.exists())
            return gson.toJson(result);
        result= HDFSAnalysisUtil.readFileToString(file);
        return gson.toJson(result);
    }

    /**
     * 清除当前测试结果
     * @return
     * @throws IOException
     */
    @RequestMapping(value = "/hdfsAnalysis/cleanresult"
            ,produces = "application/json;charset=UTF-8")
    @ResponseBody()
    public String cleanresult() throws IOException {
        new File(resultDFSIOPath).delete();
        return gson.toJson("success");
    }

}
