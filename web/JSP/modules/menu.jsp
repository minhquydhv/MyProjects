<%-- 
    Document   : index
    Created on : Jul 31, 2015, 1:42:59 PM
    Author     : quang quy
--%>
<script src="${pageContext.request.contextPath}JS/dropdownMenu.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}JS/jquery-1.11.1.min.js" type="text/javascript"></script>
<div id="menu-wrapper">
    <ul id="nav">
        <li><a href="${pageContext.request.contextPath}/JSP/index.jsp">Home</a></li>
        <li><a href="#">Company &darr;</a>
          <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=company&&ac=setting">Setting KPI</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=company&&ac=evaluate">Evaluate KPI</a>
                </li>
            </ul>   
        <li><a href="#">Department &darr;</a>
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=department&&ac=setting">Setting KPI</a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=department&&ac=evaluate">Evaluate KPI</a>
                </li>
            </ul>   
        </li>

        <li><a href="#">Individual &darr;</a>
            <ul>
                <li><a href="#">KPI Individual &raquo;</a>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=setting">Setting KPI</a></li>
                        <li><a href="${pageContext.request.contextPath}/JSP/index.jsp?page=individual&&subPage=kpiIndividual&&ac=confirmed">Confirmed KPI</a></li>
                    </ul>
                </li>
                <li><a href="#">Worker &raquo;</a>
                    <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=individual&&subPage=worker&&ac=evaluate">Evaluate KPI</a>
                        </li>
                    </ul>   
                </li>
                <li><a href="#">Staff &raquo;</a>
                    <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=individual&&subPage=staff&&ac=competency">Competency</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=individual&&subPage=staff&&ac=performance">Performance</a>
                        </li>
                    </ul>   
                </li>
                <li><a href="#">Team leader &raquo;</a>
                    <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=individual&&subPage=teamleader&&ac=competency">Competency</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=individual&&subPage=teamleader&&ac=performance">Performance</a>
                        </li>
                    </ul>   
                </li>
                <li><a href="#">HOD &raquo;</a>
                    <ul>
                        <li>
                            <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=individual&&subPage=hod&&ac=competency">Competency</a>
                        </li>
                        <li>
                            <a href="${pageContext.request.contextPath}/JSP/index.jsp?page=individual&&subPage=hod&&ac=performance">Performance</a>
                        </li>
                    </ul>   
                </li>
            </ul>
        </li>
        <div class="clearfix"></div>
    </ul>
    <!-- end nav -->

</div>
<!-- end menu-wrapper -->
