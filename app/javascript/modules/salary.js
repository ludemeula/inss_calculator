export function setupSalaryListener() {
  const salaryInput = document.getElementById('salary-input');
  const inssField = document.getElementById('inss-field');

  if (!salaryInput || !inssField) return;

  salaryInput.addEventListener('change', () => {
    const salary = parseFloat(salaryInput.value);
    if (isNaN(salary)) return;

    fetch(`/proponents/calculate_inss?salary=${salary}`)
      .then((res) => res.json())
      .then((data) => {
        inssField.value = new Intl.NumberFormat('pt-BR', {
          style: 'currency',
          currency: 'BRL',
        }).format(data.inss_discount);
      });
  });
}
