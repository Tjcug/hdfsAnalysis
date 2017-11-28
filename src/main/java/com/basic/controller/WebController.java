package com.basic.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * locate com.basic.controller
 * Created by mastertj on 2017/11/28.
 */
@Controller
public class WebController extends BaseController{

    @RequestMapping("/")
    public String index(){
        return "manage/index";
    }

    @RequestMapping("/temp")
    public String temp(){
        return "temp";
    }
}
