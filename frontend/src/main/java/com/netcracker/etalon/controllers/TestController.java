/*
 This software is the confidential information and copyrighted work of
 NetCracker Technology Corp. ("NetCracker") and/or its suppliers and
 is only distributed under the terms of a separate license agreement
 with NetCracker.
 Use of the software is governed by the terms of the license agreement.
 Any use of this software not in accordance with the license agreement
 is expressly prohibited by law, and may result in severe civil
 and criminal penalties. 
 
 Copyright (c) 1995-2017 NetCracker Technology Corp.
 
 All Rights Reserved.
 
*/
/*
 * Copyright 1995-2017 by NetCracker Technology Corp.,
 * University Office Park III
 * 95 Sawyer Road
 * Waltham, MA 02453
 * United States of America
 * All rights reserved.
 */
package com.netcracker.etalon.controllers;
import com.netcracker.devschool.dev4.etalon.entity.Head_of_practice;
import com.netcracker.devschool.dev4.etalon.entity.Student;
import com.netcracker.devschool.dev4.etalon.entity.User;
import com.netcracker.devschool.dev4.etalon.repository.UserRepository;
import com.netcracker.devschool.dev4.etalon.service.FacultyService;
import com.netcracker.devschool.dev4.etalon.service.Head_of_practiceService;
import com.netcracker.devschool.dev4.etalon.service.StudentService;
import com.netcracker.devschool.dev4.etalon.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Role;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import java.util.ArrayList;
import java.util.List;

/**
 * @author anpi0316
 *         Date: 06.10.2017
 *         Time: 14:04
 */
@Controller
public class TestController {
    @Autowired
    private UserService userService;


    @Autowired
    private StudentService studentService;

    @Autowired
    private Head_of_practiceService headOfPracticeService;

    @Autowired
    private FacultyService facultyService;

    @RequestMapping(value = {"/", "/welcome**"}, method = RequestMethod.GET)
    public ModelAndView defaultPage() {

        ModelAndView model = new ModelAndView();
        model.addObject("title", "Spring Security Login Form - Database Authentication");
        model.addObject("message", "This is default page!");
        model.setViewName("hello");
        return model;

    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView login(@RequestParam(value = "error", required = false) String error,
                              @RequestParam(value = "logout", required = false) String logout) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();

        if (!(auth instanceof AnonymousAuthenticationToken)) {

    /* The user is logged in :) */
            String role = auth.getAuthorities().toString();

            String targetUrl = "";
            if (role.contains("STUDENT")) {
                targetUrl = "/student";
            } else if (role.contains("HOP")) {
                targetUrl = "/hop";
            } else if (role.contains("ADMIN")) {
                targetUrl = "/admin";
            }

            return new ModelAndView("redirect:" + targetUrl);

        }

        ModelAndView model = new ModelAndView();
        if (error != null) {
            model.addObject("error", "Invalid username and password!");
        }

        if (logout != null) {
            model.addObject("msg", "You've been logged out successfully.");
        }
        model.setViewName("loginnew");

        return model;

    }

    @RequestMapping(value = "/student", method = RequestMethod.GET)
    @PreAuthorize("hasRole('ROLE_STUDENT')")
    public ModelAndView pageStudent() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        ModelAndView model = new ModelAndView();
        String name = auth.getName();
        int id = userService.getIdByName(name);
        Student student = studentService.findById(id);
        if (student != null) {
            model.addObject("name", student.getFirst_name() + " " + student.getLast_name());
            model.addObject("imageUrl", "images/" + student.getImageurl());
            model.addObject("id", student.getIdStudent());
            model.addObject("faculties", facultyService.findAll());
        }
        model.setViewName("student");
        return model;
    }


    @RequestMapping(value = "/hop", method = RequestMethod.GET)
    @PreAuthorize("hasRole('ROLE_HOP')")
    public ModelAndView pageHop() {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        ModelAndView model = new ModelAndView();
        String name = auth.getName();
        int id = userService.getIdByName(name);
        Head_of_practice headOfPractice = headOfPracticeService.findById(id);
        if (headOfPractice != null) {
            model.addObject("name", headOfPractice.getFirst_name() + " " + headOfPractice.getLast_name());
            model.addObject("imageUrl", "images/" + headOfPractice.getImageurl());
            model.addObject("company", headOfPractice.getCompany());
            model.addObject("id", headOfPractice.getIdhead_of_practice());
            model.addObject("faculties", facultyService.findAll());
        }
        model.setViewName("head_of_practice");
        return model;
    }

    @RequestMapping(value = "/admin", method = RequestMethod.GET)
    @PreAuthorize("hasRole('ROLE_ADMIN')")
    public String pageAdmin() {
        return "admin";
    }

    //for 403 access denied page
    @RequestMapping(value = "/403", method = RequestMethod.GET)
    public ModelAndView accesssDenied() {

        ModelAndView model = new ModelAndView();

        //check if user is login
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (!(auth instanceof AnonymousAuthenticationToken)) {
            UserDetails userDetail = (UserDetails) auth.getPrincipal();
            model.addObject("username", userDetail.getUsername());
        }

        model.setViewName("403");
        return model;

    }
    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public String goTologinnewPage() {
        return "register";
    }

    @RequestMapping(value = "/logout", method = RequestMethod.GET)
    public String logoutPage(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/login?logout";//You can redirect wherever you want, but generally it's a good practice to show login screen again.
    }

   /* @RequestMapping(value = "/users-view", method = RequestMethod.GET)
    public ModelAndView getUsersAsModelWithView() {

        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("login");
        modelAndView.addObject("users", getStubUsers());
        return modelAndView;
    }
    @RequestMapping(value = "/usersAsJson", method = RequestMethod.GET)
    @ResponseBody
    public List<UserViewModel> getUsersAsJson() {
        return getStubUsers();
    }

    private List<UserViewModel> getStubUsers() {
        List<UserViewModel> userViewModels = new ArrayList<>();
        UserViewModel userViewModelIvan  = new UserViewModel();
        userViewModelIvan.setId("113");
        userViewModelIvan.setName("Ivan");
        UserViewModel userViewModelLeopold = new UserViewModel();
        userViewModelLeopold.setId("114");
        userViewModelLeopold.setName("Leopold");
        userViewModels.add(userViewModelIvan);
        userViewModels.add(userViewModelLeopold);
        return userViewModels;
    }*/


}
/*
 WITHOUT LIMITING THE FOREGOING, COPYING, REPRODUCTION, REDISTRIBUTION,
 REVERSE ENGINEERING, DISASSEMBLY, DECOMPILATION OR MODIFICATION
 OF THE SOFTWARE IS EXPRESSLY PROHIBITED, UNLESS SUCH COPYING,
 REPRODUCTION, REDISTRIBUTION, REVERSE ENGINEERING, DISASSEMBLY,
 DECOMPILATION OR MODIFICATION IS EXPRESSLY PERMITTED BY THE LICENSE
 AGREEMENT WITH NETCRACKER. 
 
 THIS SOFTWARE IS WARRANTED, IF AT ALL, ONLY AS EXPRESSLY PROVIDED IN
 THE TERMS OF THE LICENSE AGREEMENT, EXCEPT AS WARRANTED IN THE
 LICENSE AGREEMENT, NETCRACKER HEREBY DISCLAIMS ALL WARRANTIES AND
 CONDITIONS WITH REGARD TO THE SOFTWARE, WHETHER EXPRESS, IMPLIED
 OR STATUTORY, INCLUDING WITHOUT LIMITATION ALL WARRANTIES AND
 CONDITIONS OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE,
 TITLE AND NON-INFRINGEMENT.
 
 Copyright (c) 1995-2017 NetCracker Technology Corp.
 
 All Rights Reserved.
*/