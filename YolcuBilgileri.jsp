<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Yolcu Bilgileri</title>
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-5">
        <h2>Yolcu Bilgileri</h2>
        <form action="SonSayfaBilgileri.jsp" method="post">
            <input type="hidden" name="passengerCount" value="<%= request.getParameter("passengerCount") %>">

            <% for (int i = 1; i <= Integer.parseInt(request.getParameter("passengerCount")); i++) { %>
                <div class="card mb-3">
                    <div class="card-header">Yolcu <%= i %></div>
                    <div class="card-body">
                         <!-- Ad ve Soyad -->
                        <div class="form-group">
                            <label for="name<%= i %>">Ad ve Soyad:</label>
                            <input type="text" class="form-control" id="name<%= i %>" name="name<%= i %>" placeholder="Adınızı ve Soyadınızı giriniz" " required pattern="^[a-zA-ZğüşıöçĞÜŞİÖÇ\s]+$" title="Geçerli bir ad ve soyad girin. Rakam veya özel karakter içeremez.">
                            <div id="nameError<%= i %>" class="text-danger"></div>
                        </div>
                      <!-- Cinsiyet -->
                        <div class="form-group">
                            <label for="gender<%= i %>">Cinsiyet:</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="male<%= i %>" name="gender<%= i %>" value="male" required>
                                <label class="form-check-label" for="male<%= i %>">Erkek</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="female<%= i %>" name="gender<%= i %>" value="female" required>
                                <label class="form-check-label" for="female<%= i %>">Kadın</label>
                            </div>
                        </div>
                       <label for="birthday">Doğum Günü:</label>
            <input type="date" id="birthday" name="birthday" max="2023-12-31" required>
            <br><br>

                        <!-- Kimlik Türü -->
                        <div class="form-group">
                            <label>Uyruk:</label>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="turkish<%= i %>" name="identityType<%= i %>"placeholder="T.C. Kimlik giriniz"  value="turkish" required>
                                <label class="form-check-label" for="turkish<%= i %>">Türk Vatandaşı Yolcu</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" id="foreign<%= i %>" name="identityType<%= i %>" value="foreign" required>
                                <label class="form-check-label" for="foreign<%= i %>"placeholder="Pasaport giriniz" >Yabancı Uyruklu Yolcu</label>
                            </div>
                        </div>

                        <!-- T.C. Kimlik Bilgileri -->
                        <div id="idDiv<%= i %>">
                            <div class="form-group">
                                <label for="id<%= i %>">T.C. Kimlik Numarası:</label>
                                <input type="text" class="form-control" id="id<%= i %>" name="id<%= i %>" pattern="^(?:(?!99)[0-9]{11})$" title="Geçerli bir T.C. Kimlik Numarası girin.">
                                <div id="idError<%= i %>" class="text-danger"></div>
                            </div>
                        </div>

                        <!-- Pasaport Numarası -->
                        <div id="foreignIdDiv<%= i %>">
                            <div class="form-group">
                                <label for="foreignId<%= i %>">Pasaport Numarası:</label>
                                <input type="text" class="form-control" id="foreignId<%= i %>" name="foreignId<%= i %>"
                                    pattern="^[A-Z][0-9]{6,8}$" title="Geçerli bir Pasaport Numarası girin." required>
                                <div id="foreignIdError<%= i %>" class="text-danger"></div>
                            </div>
                        </div>

                        <!-- Telefon Bilgisi -->
                        <div class="form-group">
                            <label for="phone<%= i %>">Telefon:</label>
                            <input type="tel" class="form-control" id="phone<%= i %>" name="phone<%= i %>" required pattern="(\+90\s?)?[0-9]{10}">
                            <div id="phoneError<%= i %>" class="text-danger"></div>
                        </div>

                    </div>
                </div>
            <% } %>

            <button type="submit" class="btn btn-primary" id="submitBtn">Devam Et</button>
        </form>

        <!-- JavaScript Kodu -->
        <script>
            var form = document.querySelector("form");
            form.addEventListener("submit", function (event) {
                var allowSubmit = true;

                for (var i = 1; i <= <%= Integer.parseInt(request.getParameter("passengerCount")) %>; i++) {
                    // Yaş Kontrolü, Kimlik Türü Kontrolü ve Telefon Kontrolü burada

                    // T.C. Kimlik Numarası Kontrolü
                    var idValue = document.getElementById("id" + i).value;
                    var foreignIdValue = document.getElementById("foreignId" + i).value;
                    var identityType = document.querySelector('input[name="identityType' + i + '"]:checked');
                    if (identityType) {
                        if (identityType.value === "turkish") {
                            if (!/^[1-9][0-9]{10}$/.test(idValue) || idValue.startsWith("99")) {
                                allowSubmit = false;
                                document.getElementById("idError" + i).textContent = "Geçerli bir T.C. Kimlik Numarası girin.";
                            } else {
                                document.getElementById("idError" + i).textContent = "";
                            }
                        } else if (identityType.value === "foreign") {
                            // Pasaport Numarası Kontrolü burada
                            if (!/^[A-Z][0-9]{6,8}$/.test(foreignIdValue)) {
                                allowSubmit = false;
                                document.getElementById("foreignIdError" + i).textContent = "Geçerli bir Pasaport Numarası girin.";
                            } else {
                                document.getElementById("foreignIdError" + i).textContent = "";
                            }
                        }
                    }

                    // Diğer kontroller burada
                }

                if (!allowSubmit) {
                    event.preventDefault();
                }
            });

            // Türk vatandaşı seçiliyse, pasaport alanını devre dışı bırak; yabancı uyruklu seçiliyse, TC Kimlik alanını devre dışı bırak
            document.querySelectorAll('input[name^="identityType"]').forEach(function (element) {
                element.addEventListener("change", function () {
                    var passengerIndex = this.id.match(/\d+/)[0];
                    if (this.value === "turkish") {
                        document.getElementById("foreignId" + passengerIndex).disabled = true;
                        document.getElementById("id" + passengerIndex).disabled = false;
                        document.getElementById("foreignIdDiv" + passengerIndex).style.display = "none";
                        document.getElementById("idDiv" + passengerIndex).style.display = "block";
                    } else {
                        document.getElementById("id" + passengerIndex).disabled = true;
                        document.getElementById("foreignId" + passengerIndex).disabled = false;
                        document.getElementById("idDiv" + passengerIndex).style.display = "none";
                        document.getElementById("foreignIdDiv" + passengerIndex).style.display = "block";
                    }
                });
            });
        </script>

        <!-- Session ve Cookie Eklenmesi -->
        <% 
        String passengerCount = request.getParameter("passengerCount");
        if (passengerCount != null) {
            session.setAttribute("passengerCount", passengerCount);
            Cookie passengerCountCookie = new Cookie("passengerCount", passengerCount);
            passengerCountCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(passengerCountCookie);
        }

        for (int i = 1; i <= Integer.parseInt(passengerCount); i++) {
            String identityType = request.getParameter("identityType" + i);
            String id = request.getParameter("id" + i);
            String foreignId = request.getParameter("foreignId" + i);
            String phone = request.getParameter("phone" + i);
            String name = request.getParameter("name" + i);
            String gender = request.getParameter("gender" + i);
            String age = request.getParameter("age" + i);

            session.setAttribute("identityType" + i, identityType);
            Cookie identityTypeCookie = new Cookie("identityType" + i, identityType);
            identityTypeCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(identityTypeCookie);

            session.setAttribute("id" + i, id);
            Cookie idCookie = new Cookie("id" + i, id);
            idCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(idCookie);

            session.setAttribute("foreignId" + i, foreignId);
            Cookie foreignIdCookie = new Cookie("foreignId" + i, foreignId);
            foreignIdCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(foreignIdCookie);

            session.setAttribute("phone" + i, phone);
            Cookie phoneCookie = new Cookie("phone" + i, phone);
            phoneCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(phoneCookie);

            session.setAttribute("name" + i, name);
            Cookie nameCookie = new Cookie("name" + i, name);
            nameCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(nameCookie);

            session.setAttribute("gender" + i, gender);
            Cookie genderCookie = new Cookie("gender" + i, gender);
            genderCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(genderCookie);

            session.setAttribute("age" + i, age);
            Cookie ageCookie = new Cookie("age" + i, age);
            ageCookie.setMaxAge(60 * 60 * 24); // 1 day
            response.addCookie(ageCookie);
        }
        %>
    </div>
</body>
</html>
