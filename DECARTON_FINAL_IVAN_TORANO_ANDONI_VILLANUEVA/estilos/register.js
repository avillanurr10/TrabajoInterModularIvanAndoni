document.addEventListener('DOMContentLoaded', function() {
    const passwordInput = document.getElementById('password');
    const strengthBar = document.getElementById('strengthBar');
    const form = document.querySelector('form');
    const submitButton = form.querySelector('button');
    
    // Indicador de fuerza de contraseña
    passwordInput.addEventListener('input', function() {
        const strength = calculatePasswordStrength(this.value);
        updateStrengthBar(strength);
    });
    
    function calculatePasswordStrength(password) {
        let strength = 0;
        
        // Longitud
        if (password.length > 7) strength += 1;
        if (password.length > 11) strength += 1;
        
        // Complejidad
        if (/[A-Z]/.test(password)) strength += 1;
        if (/[0-9]/.test(password)) strength += 1;
        if (/[^A-Za-z0-9]/.test(password)) strength += 1;
        
        return Math.min(strength, 5);
    }
    
    function updateStrengthBar(strength) {
        const colors = ['#ff5252', '#ff6e40', '#ffab40', '#ffd740', '#9ccc65', '#2e7d32'];
        const width = (strength / 5) * 100;
        
        strengthBar.style.width = `${width}%`;
        strengthBar.style.background = colors[strength];
    }
    
    // Efecto al enviar
    form.addEventListener('submit', function() {
        submitButton.innerHTML = '<span class="loader"></span> Creando cuenta...';
        submitButton.disabled = true;
    });
    
    // Efecto hover en el logo
    const logo = document.querySelector('.logo');
    logo.addEventListener('mouseenter', () => {
        logo.style.transform = 'scale(1.08) rotate(2deg)';
    });
    
    logo.addEventListener('mouseleave', () => {
        logo.style.transform = 'scale(1) rotate(0)';
    });
});

// Loader CSS dinámico
const loaderStyle = document.createElement('style');
loaderStyle.textContent = `
    .loader {
        display: inline-block;
        width: 18px;
        height: 18px;
        border: 3px solid rgba(255,255,255,0.3);
        border-radius: 50%;
        border-top-color: #fff;
        animation: spin 1s ease-in-out infinite;
        vertical-align: middle;
        margin-right: 10px;
    }
    @keyframes spin {
        to { transform: rotate(360deg); }
    }
`;
document.head.appendChild(loaderStyle);