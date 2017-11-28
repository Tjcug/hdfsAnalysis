package com.basic.controller;

import com.basic.service.HDFSAnalysisService;
import com.basic.util.JedisPoolUtil;
import com.google.gson.Gson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import redis.clients.jedis.JedisPool;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by dell-pc on 2016/4/21.
 */
public class BaseController {

    protected static final Logger log = LoggerFactory.getLogger(BaseController.class);
    //后台项目基础url
    protected String mainPath="manage/";

    protected JedisPool jedisPool= JedisPoolUtil.getJedisPoolInstance();

    protected Gson gson=new Gson();

    @ModelAttribute("BasePath")
    public String getBasePath(HttpServletRequest httpServletRequest) {
        return httpServletRequest.getContextPath();
    }

    @Value("#{prop.resultDFSIOPath}")
    protected String resultDFSIOPath;

    @Autowired
    protected HDFSAnalysisService hdfsAnalysisService;
}
