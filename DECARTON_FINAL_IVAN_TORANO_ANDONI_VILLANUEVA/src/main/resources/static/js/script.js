document.addEventListener("DOMContentLoaded", () => {
    // Validar campos vacíos en tiempo real
    const inputs = document.querySelectorAll("input");
    inputs.forEach(input => {
        input.addEventListener("input", () => {
            if (input.value.trim() === "") {
                input.style.borderColor = "#dc3545";
            } else {
                input.style.borderColor = "#28a745";
            }
        });
    });

    // Animación al enviar el formulario
    const forms = document.querySelectorAll("form");
    forms.forEach(form => {
        form.addEventListener("submit", () => {
            const button = form.querySelector("button");
            button.disabled = true;
            button.textContent = "Cargando...";
            setTimeout(() => {
                button.disabled = false;
                button.textContent = "Enviar";
            }, 2000); // Simula un retraso de 2 segundos
        });
    });

    });
    // Funcionalidad para el botón de mostrar usuarios
        const showUsersButton = document.getElementById("show-users-button");
        const usersTableContainer = document.getElementById("users-table-container");

        if (showUsersButton) {
            showUsersButton.addEventListener("click", async () => {
                try {
                    const response = await fetch("/users-table");
                    const tableHtml = await response.text();
                    usersTableContainer.innerHTML = tableHtml;
                } catch (error) {
                    console.error("Error al cargar la tabla de usuarios:", error);
                    usersTableContainer.innerHTML = "<p>Error al cargar la tabla de usuarios.</p>";
                }
            });
        }
});