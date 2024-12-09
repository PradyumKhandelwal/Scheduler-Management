/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.strutActions;

import com.schedulerOperations.schedulerOperations;
import java.io.PrintWriter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.struts.action.Action;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.json.simple.JSONArray;

/**
 *
 * @author pradyumkhandelwal
 */
public class schAction extends org.apache.struts.action.Action {

    private static final String SUCCESS = "success";

    @Override
    public ActionForward execute(ActionMapping mapping, ActionForm form,
            HttpServletRequest request, HttpServletResponse response)
            throws Exception {

        schedulerOperations schObj = new schedulerOperations();
        PrintWriter out = response.getWriter();

        String flag = request.getParameter("flag");
        System.out.println("Action flag ->" + flag);
        try {
            switch (flag) {
                case "Postdata":
                    String schname = request.getParameter("schName");
                    String sType = request.getParameter("sType");
                    String sHr = request.getParameter("sHr");
                    String sMin = request.getParameter("sMin");
                    String hr = "";
                    String min = "";
                    int h = Integer.parseInt(sHr);
                    int m = Integer.parseInt(sMin);
                    if (h < 10) {
                        hr = String.format("%02d", h);
                    } else {
                        hr = h + "";
                    }
                    if (m < 10) {
                        min = String.format("%02d", m);
                    } else {
                        min = m + "";
                    }
                    String sMonth = request.getParameter("sMonth");
                    String sDay = request.getParameter("sDay");
                    System.out.println("Hi I am called 1  ->" + schname);
                    System.out.println("Hi I am called 2  ->" + sType);
                    System.out.println("Hi I am called 3  ->" + hr);
                    System.out.println("Hi I am called 4  ->" + min);
                    System.out.println("Hi I am called 5  ->" + sMonth);
                    System.out.println("Hi I am called 6  ->" + sDay);

                    schObj.insertSchInfo(schname, sType, hr, min, sMonth, sDay);
                    break;

                case "FetchData":

                    JSONArray resArr = schObj.fetchData();
                    out.println(resArr);
                    break;

                case "updateSchStatus":
                    String id = request.getParameter("id");
                    String status = request.getParameter("status");
                    //schObj.update(id, status);
                    out.print(schObj.update(id, status));
                    break;

                default:
                    System.out.println("Action flag ->" + flag + " did not match with any case.");

            }
            String update = request.getParameter("update");
            System.out.println("Update flag ->" + update);
        } catch (Exception e) {
            System.out.println("Error" + e);
        }
        return mapping.findForward("SUCCESS");
    }

}
