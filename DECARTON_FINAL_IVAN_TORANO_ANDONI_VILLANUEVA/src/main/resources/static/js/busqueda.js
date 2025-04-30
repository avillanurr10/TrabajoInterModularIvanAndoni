document.addEventListener('DOMContentLoaded', function() {
    const logo = document.querySelector('.logo');

    if (logo) {
        logo.addEventListener('mouseenter', () => {
            logo.style.transform = 'scale(1.08) rotate(1deg)';
        });

        logo.addEventListener('mouseleave', () => {
            logo.style.transform = 'scale(1) rotate(0)';
        });

        logo.addEventListener('click', () => {
            logo.style.transform = 'scale(0.95)';
            setTimeout(() => {
                logo.style.transform = 'scale(1.05)';
            }, 150);
        });
    }

    const searchForm = document.querySelector('form');
    const searchInput = document.querySelector('input[name="query"]');

    if (searchForm && searchInput) {
        searchForm.addEventListener('submit', () => {
            searchInput.disabled = true;
            searchInput.placeholder = "Buscando...";
        });
    }
});
