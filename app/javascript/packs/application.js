import Rails from "@rails/ujs";
Rails.start();

import "stylesheets/application";
import "bootstrap/dist/css/bootstrap.min.css";
import "./flash";

document.addEventListener("DOMContentLoaded", () => {
  const salaryInput = document.getElementById("salary-input");
  const inssField = document.getElementById("inss-field");
  // let contactCount = <%= @proponent.contacts.size %>;

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

  // document.getElementById('add-contact').addEventListener('click', function() {
  //   contactCount++;

  //   // Clone the first contact block
  //   const contactRow = document.querySelector('.row.g-2').cloneNode(true);

  //   // Reset the input fields to empty
  //   contactRow.querySelectorAll('input').forEach(input => {
  //     input.value = '';
  //   });

  //   // Update field names for new contact
  //   contactRow.querySelectorAll('select, input').forEach(input => {
  //     const name = input.name.replace(/\[\d+\]/, `[${contactCount}]`);
  //     input.name = name;
  //   });

  //   // Append the new contact block to the form
  //   document.getElementById('contacts').appendChild(contactRow);
  // });

  // // Remove a contact block
  // document.getElementById('contacts').addEventListener('click', function(e) {
  //   if (e.target && e.target.classList.contains('remove-contact')) {
  //     e.target.closest('.row.g-2').remove();
  //   }
  // });
});
