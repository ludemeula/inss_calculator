//= require rails-ujs

import "stylesheets/application";

import "bootstrap/dist/css/bootstrap.min.css";

document.addEventListener("DOMContentLoaded", () => {
  const salaryInput = document.getElementById("salary-input");
  const inssField = document.getElementById("inss-field");

  if (salaryInput) {
    salaryInput.addEventListener("input", () => {
      const salary = parseFloat(salaryInput.value);
      if (isNaN(salary)) return;

      fetch(`/proponents/calculate_inss?salary=${salary}`)
        .then((res) => res.json())
        .then((data) => {
          inssField.value = data.inss_discount.toFixed(2);
        });
    });
  }
});
