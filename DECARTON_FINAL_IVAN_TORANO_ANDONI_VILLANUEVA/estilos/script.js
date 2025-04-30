document.addEventListener('DOMContentLoaded', function() {
    const form = document.querySelector('form');
    const button = form.querySelector('button');
    const logo = document.querySelector('.logo');
    const inputs = document.querySelectorAll('input');
    
    // Efecto al enviar el formulario
    form.addEventListener('submit', function(e) {
        button.innerHTML = '<span class="loader"></span> Procesando...';
        button.classList.add('loading');
        button.disabled = true;
        
        inputs.forEach(input => {
            input.disabled = true;
        });
    });
    
    // Efectos interactivos para el logo
    logo.addEventListener('mouseenter', () => {
        logo.style.transform = 'scale(1.08) rotate(2deg)';
    });
    
    logo.addEventListener('mouseleave', () => {
        logo.style.transform = 'scale(1) rotate(0)';
    });
    
    // Efecto pulsación al hacer clic en el logo
    logo.addEventListener('click', () => {
        logo.style.transform = 'scale(0.95)';
        setTimeout(() => {
            logo.style.transform = 'scale(1.05)';
        }, 150);
    });
    
    // Mejor feedback para inputs
    inputs.forEach(input => {
        input.addEventListener('focus', () => {
            input.parentNode.querySelector('label').style.color = '#00ACC1';
            input.style.background = '#fff';
        });
        
        input.addEventListener('blur', () => {
            input.parentNode.querySelector('label').style.color = '#555';
        });
    });
    
    // Efecto de carga (mejorado)
    const loaderHTML = `
        <style>
            .loader {
                display: inline-block;
                width: 18px;
                height: 18px;
                border: 3px solid rgba(255,255,255,0.3);
                border-radius: 50%;
                border-top-color: #fff;
                animation: spin 1s ease-in-out infinite;
                vertical-align: middle;
                margin-right: 8px;
            }
            @keyframes spin {
                to { transform: rotate(360deg); }
            }
        </style>
    `;
    document.head.insertAdjacentHTML('beforeend', loaderHTML);
});