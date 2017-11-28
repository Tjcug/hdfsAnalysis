package com.basic.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;

/**
 * locate com.basic.util
 * Created by mastertj on 2017/11/28.
 */
public class HDFSAnalysisUtil {
    public static String readFileToString(File file) throws IOException {
        BufferedReader bufferedReader=new BufferedReader(new FileReader(file));
        StringBuilder stringBuilder=new StringBuilder();
        String str="";
        while ((str=bufferedReader.readLine())!=null){
            stringBuilder.append(str+"\r\n");
        }
        return stringBuilder.toString();
    }
}
