import Rails from "@rails/ujs";
import Inputmask from "inputmask";
Rails.start();

import "stylesheets/application";
import "bootstrap/dist/css/bootstrap.min.css";
import "./flash";

document.addEventListener("DOMContentLoaded", () => {

  
  const salaryInput = document.getElementById("salary-input");
  const inssField = document.getElementById("inss-field");
  const cpfInput = document.querySelector("input[name='proponent[cpf]']");

  // salaryInput.addEventListener("input", function (e) {
  //   let value = e.target.value.replace(/\D/g, "");
  //   value = (parseInt(value, 10) / 100).toFixed(2) + "";
  //   value = value.replace(".", ",");
  //   value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ".");
  //   e.target.value = value;
  // });

  // salaryInput.addEventListener("blur", function (e) {
  //   if (e.target.value === "") {
  //     e.target.value = "0,00";
  //   }
  // });

  const wrapper = document.getElementById("contacts-wrapper");
  const template = document.getElementById("contact-template")?.innerHTML;
  const addContactButton = document.getElementById("add-contact");

  // if (salaryInput) {
  //   Inputmask({
  //     alias: "currency",
  //     prefix: "R$ ",
  //     groupSeparator: ".",
  //     radixPoint: ",",
  //     autoGroup: true,
  //     digits: 2,
  //     digitsOptional: false,
  //     removeMaskOnSubmit: true,
  //     unmaskAsNumber: true,
  //   }).mask(salaryInput);
  // }

  const applyContactMasks = () => {
    document
      .querySelectorAll("select[name*='[contact_type]']")
      .forEach((select) => {
        const input = select.closest(".row")?.querySelector("input");

        if (!input) return;

        const setMask = () => {
          const type = select.value;

          if (type === "celular" || type === "whatsapp") {
            Inputmask({
              mask: "(99) 99999-9999",
              placeholder: "_",
              clearIncomplete: true,
            }).mask(input);
          } else if (type === "email") {
            Inputmask({
              alias: "email",
              clearIncomplete: true,
            }).mask(input);
          } else {
            Inputmask.remove(input);
          }
        };

        setMask();
        select.addEventListener("change", setMask);
      });
  };

  if (salaryInput) {
    salaryInput.addEventListener("change", () => {
      const salary = parseFloat(salaryInput.value);
      if (isNaN(salary)) return;

      fetch(`/proponents/calculate_inss?salary=${salary}`)
        .then((res) => res.json())
        .then((data) => {
          inssField.value = new Intl.NumberFormat("pt-BR", {
            style: "currency",
            currency: "BRL",
          }).format(data.inss_discount);
        });
    });
  }

  if (cpfInput) {
    Inputmask("999.999.999-99", {
      placeholder: "_",
      clearIncomplete: true,
    }).mask(cpfInput);
  }

  let index = document.querySelectorAll(".contact-fields").length;

    // document.getElementById("add-contact").addEventListener("click", () => {
    //   const newField = template.replace(/INDEX/g, index);
    //   wrapper.insertAdjacentHTML("beforeend", newField);
    //   index++;
    // });

    // wrapper.addEventListener("click", (e) => {
    //   if (e.target.classList.contains("remove-contact")) {
    //     e.target.closest(".contact-fields").remove();
    //   }
    // });

  // let index = parseInt(wrapper?.dataset.initialCount || "0");

  // addContactButton?.addEventListener("click", () => {
  //   if (!template) return;
  //   const timestamp = Date.now();
  //   const newField = template.replace(/INDEX/g, timestamp);
  //   wrapper.insertAdjacentHTML("beforeend", newField);
  //   // applyContactMasks();
  //   index++;
  // });

  // wrapper?.addEventListener("click", (e) => {
  //   if (e.target.classList.contains("remove-contact")) {
  //     const fieldWrapper = e.target.closest(".contact-fields");
  //     const isExisting = fieldWrapper?.dataset.existing === "true";

  //     if (isExisting) {
  //       fieldWrapper.querySelector(".destroy-flag").value = "1";
  //       fieldWrapper.style.display = "none";
  //     } else {
  //       fieldWrapper.remove();
  //     }
  //   }
  // });

  const validateCPF = (cpf) => {
    cpf = cpf.replace(/[^\d]+/g, "");
    if (cpf.length !== 11 || /^(\d)\1+$/.test(cpf)) return false;
  
    let sum = 0;
    for (let i = 0; i < 9; i++) sum += parseInt(cpf[i]) * (10 - i);
    let firstCheck = (sum * 10) % 11;
    if (firstCheck === 10 || firstCheck === 11) firstCheck = 0;
    if (firstCheck !== parseInt(cpf[9])) return false;
  
    sum = 0;
    for (let i = 0; i < 10; i++) sum += parseInt(cpf[i]) * (11 - i);
    let secondCheck = (sum * 10) % 11;
    if (secondCheck === 10 || secondCheck === 11) secondCheck = 0;
  
    return secondCheck === parseInt(cpf[10]);
  };
  
  // Opcional: exibir erro visual
  cpfInput?.addEventListener("blur", () => {
    if (!validateCPF(cpfInput.value)) {
      cpfInput.classList.add("is-invalid");
      if (!cpfInput.nextElementSibling || !cpfInput.nextElementSibling.classList.contains("invalid-feedback")) {
        const feedback = document.createElement("div");
        feedback.className = "invalid-feedback";
        feedback.innerText = "CPF inválido.";
        cpfInput.parentNode.appendChild(feedback);
      }
    } else {
      cpfInput.classList.remove("is-invalid");
      if (cpfInput.nextElementSibling?.classList.contains("invalid-feedback")) {
        cpfInput.nextElementSibling.remove();
      }
    }
  });


  // const secondaryAddressBtn = document.getElementById("add-secondary-address");
  // const secondaryAddressCtn = document.getElementById("secondary-address-container");

  // if (secondaryAddressBtn && secondaryAddressCtn) {
  //   secondaryAddressBtn.addEventListener("click", function () {
  //     secondaryAddressCtn.style.display = "block";
  //     secondaryAddressBtn.style.display = "none";
  //   });
  // }
  
});
