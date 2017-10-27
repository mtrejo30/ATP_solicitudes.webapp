package com.atp.solicitudes.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.xhtmlrenderer.pdf.ITextRenderer;

public class GenerateGridPDFs extends HttpServlet 
{
	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
 
        try {
            String pdfBuffer = request.getParameter("pdfBuffer");
            String fileName = request.getParameter("fileName") ;
            String fileType = request.getParameter("fileType") ;
            boolean isPDF = fileType.equals("pdf");            
            if(isPDF){
                ServletOutputStream outputStream = response.getOutputStream();
                ITextRenderer renderer = new ITextRenderer();
                renderer.setDocumentFromString(pdfBuffer);
                renderer.layout();
                response.setContentType("application/octet-stream");
                response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName +"."+fileType+ "\"");
                renderer.createPDF(outputStream);
                outputStream.flush();
                outputStream.close();
 
            }else{
                response.setContentType("application/vnd.ms-excel");
                response.setHeader("Content-Disposition", "attachment;filename=\"" + fileName +"."+fileType+  "\"");
                PrintWriter out = response.getWriter();
                out.print(pdfBuffer);
                out.close();
            }
             
        } catch (Exception e) {
            System.out.println("Exception in GenerateGridPDFs : " + e);
        }
    }
 
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
 
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }
 
    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
