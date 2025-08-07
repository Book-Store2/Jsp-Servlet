package org.example.bookstorecode.controller;

import org.example.bookstorecode.model.Category;
import org.example.bookstorecode.model.Status;
import org.example.bookstorecode.service.CategoryDao;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CategoryServlet", urlPatterns = {"/manage-categories", "/category-create", "/category-edit", "/category-delete", "/category-update"})
public class CategoryServlet extends HttpServlet {
    private final CategoryDao categoryDao = new CategoryDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getServletPath();

        switch (action) {
            case "/manage-categories":
                List<Category> list = categoryDao.findAll();
                req.setAttribute("categories", list);
                req.getRequestDispatcher("/admin/manage-categories.jsp").forward(req, resp);
                break;

            case "/category-edit":
                int idEdit = Integer.parseInt(req.getParameter("id"));
                Category cat = categoryDao.findById(idEdit);
                req.setAttribute("category", cat);
                req.getRequestDispatcher("/admin/edit-category.jsp").forward(req, resp);
                break;

            case "/category-delete":
                int idDelete = Integer.parseInt(req.getParameter("id"));
                categoryDao.softDelete(idDelete);
                resp.sendRedirect("/manage-categories");
                break;

            default:
                resp.sendRedirect("/manage-categories");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getServletPath();
        String name = req.getParameter("name");
        Status status = Status.ACTIVE;

        switch (action) {
            case "/category-create":
                categoryDao.add(new Category(name, status));
                resp.sendRedirect("/manage-categories");
                return;

            case "/category-update":
                int id = Integer.parseInt(req.getParameter("id"));
                Category category = categoryDao.findActiveById(id);
                if (category == null) {
                    req.setAttribute("error", "Danh mục này đã bị xóa hoặc không tồn tại.");
                    List<Category> list = categoryDao.findAll();
                    req.setAttribute("categories", list);
                    req.getRequestDispatcher("/admin/manage-categories.jsp").forward(req, resp);
                    return;
                }

                categoryDao.update(new Category(id, name, status));
                resp.sendRedirect("/manage-categories");
        }
    }

}

