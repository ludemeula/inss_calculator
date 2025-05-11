export function handleCPFValidation() {
  const cpfInput = document.querySelector('.cpf-mask');
  if (!cpfInput) return;

  cpfInput.addEventListener('blur', () => {
    const isValid = validateCPF(cpfInput.value);
    const existingFeedback = cpfInput.nextElementSibling;

    if (!isValid) {
      cpfInput.classList.add('is-invalid');
      if (!existingFeedback || !existingFeedback.classList.contains('invalid-feedback')) {
        const feedback = document.createElement('div');
        feedback.className = 'invalid-feedback';
        feedback.innerText = 'CPF inválido.';
        cpfInput.parentNode.appendChild(feedback);
      }
    } else {
      cpfInput.classList.remove('is-invalid');
      if (existingFeedback?.classList.contains('invalid-feedback')) {
        existingFeedback.remove();
      }
    }
  });
}

function validateCPF(cpf) {
  cpf = cpf.replace(/[^\d]+/g, '');
  if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) return false;

  let sum = 0;
  for (let i = 0; i < 9; i++) sum += parseInt(cpf[i]) * (10 - i);
  let firstCheck = (sum * 10) % 11;
  if (firstCheck >= 10) firstCheck = 0;
  if (firstCheck !== parseInt(cpf[9])) return false;

  sum = 0;
  for (let i = 0; i < 10; i++) sum += parseInt(cpf[i]) * (11 - i);
  let secondCheck = (sum * 10) % 11;
  if (secondCheck >= 10) secondCheck = 0;

  return secondCheck === parseInt(cpf[10]);
}
