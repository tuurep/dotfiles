// Vivify directory listing:
// Toggle shown/hidden on .-prefixed filenames

function toggle_hidden_files() {
    document.querySelectorAll(".dir-list > [name^='.']").forEach((el) => {
        if (el.style.display === "none") {
            el.style.display = "block";
        } else {
            el.style.display = "none";
        }
    });
}

window.addEventListener("keypress", (e) => {
    if (e.key === "h") {
        toggle_hidden_files();
    }
});

// Set hidden initially
toggle_hidden_files();
