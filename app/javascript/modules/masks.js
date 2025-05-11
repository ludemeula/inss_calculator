import Inputmask from 'inputmask';

export function applyAllMasks() {
  applyCepMask();
  applyCpfMask();
  applyContactMasks();
}

function applyCepMask() {
  document.querySelectorAll('.cep-mask').forEach((input) => {
    Inputmask('99999-999').mask(input);
  });
}

function applyCpfMask() {
  const cpfInput = document.querySelector('.cpf-mask');
  if (cpfInput) {
    Inputmask('999.999.999-99', {
      placeholder: '_',
      clearIncomplete: true,
    }).mask(cpfInput);
  }
}

export function applyContactMasks() {
  document.querySelectorAll("select[name*='[contact_type]']").forEach((select) => {
    const input = select.closest('.row')?.querySelector('input');
    if (!input) return;

    const setMask = () => {
      const type = select.value;
      if (type === 'celular' || type === 'whatsapp') {
        Inputmask({
          mask: '(99) 99999-9999',
          placeholder: '_',
          clearIncomplete: true,
        }).mask(input);
      } else if (type === 'email') {
        Inputmask({ alias: 'email', clearIncomplete: true }).mask(input);
      } else {
        Inputmask.remove(input);
      }
    };

    setMask();
    select.addEventListener('change', setMask);
  });
}
