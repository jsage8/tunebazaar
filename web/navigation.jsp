            <%@ page import="tunebazaar.AvailableGenres" %>
            <% 
                List<String> genres = (List<String>) request.getAttribute("genres");
                if (genres == null) {
                    genres = (List<String>) AvailableGenres.getAvailableGenres();
                    request.setAttribute("genres", genres);
                }
            %>

            <nav class="standard_section" id="menu">
                <h2>Genres</h2>
                <ul>
                    <% for(int i = 0; i < genres.size(); i++) { %>
                        <li><a class="genre_name" href="SearchDisplayServlet?searchAction=searchByGenre&searchByGenreString=<%= genres.get(i) %>"><%= genres.get(i) %></a>
                    <% } %>
                </ul>
            </nav>