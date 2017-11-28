package com.basic.service;

import com.basic.util.LinuxShellUitl;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import java.io.IOException;

/**
 * locate com.basic.service
 * Created by mastertj on 2017/11/28.
 */
@Service
public class HDFSAnalysisService {
    private Logger logger= LoggerFactory.getLogger(HDFSAnalysisService.class);

    @Value("#{prop.hostname}")
    private String hostname;
    @Value("#{prop.username}")
    private String username;
    @Value("#{prop.password}")
    private String password;
    @Value("#{prop.hdfsTestJarPath}")
    private String hdfsTestJarPath;
    @Value("#{prop.hadoopPath}")
    private String hadoopPath;
    @Value("#{prop.testDFSIOOutPutPath}")
    private String testDFSIOPath;
    @Value("#{prop.cleanDFSIOOutPutPath}")
    private String cleanDFSIOPath;
    @Value("#{prop.resultDFSIOPath}")
    private String resultDFSIOPath;

    public String testDFSIO(Integer fileSize,Integer fileNum,String modelRadios) throws IOException {
        String execs="";
        execs+=hadoopPath+"/bin/hadoop jar "+hdfsTestJarPath+" TestDFSIO -"+modelRadios+" -nrFiles "+fileNum+" -size "+fileSize+" -resFile "+resultDFSIOPath;
        logger.info(execs);
        Long startTimeMillis=System.currentTimeMillis();
        LinuxShellUitl.exec(hostname,username,password,22,execs,testDFSIOPath);
        Long dealyTimeMillis=System.currentTimeMillis()-startTimeMillis;
        double throughput = (fileSize * fileNum) / (dealyTimeMillis / 1000);
        return String.valueOf(throughput);
    }

    public String cleanTemporaryFiles() throws IOException {
        String execs="";
        execs+=hadoopPath+"/bin/hadoop jar "+hdfsTestJarPath+" TestDFSIO -clean -resFile "+resultDFSIOPath;
        logger.info(execs);
        return LinuxShellUitl.exec(hostname,username,password,22,execs,cleanDFSIOPath);
    }

}
