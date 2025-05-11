import { applyContactMasks } from './masks';

export function setupAddRemoveContacts() {
  let index = document.querySelectorAll('.contact-fields').length;

  document.getElementById('add-contact')?.addEventListener('click', () => {
    const template = document.getElementById('contact-template').innerHTML;
    const newFields = template.replace(/INDEX/g, index);
    document.getElementById('contacts-container').insertAdjacentHTML('beforeend', newFields);
    index++;
    applyContactMasks();
  });

  document.addEventListener('click', (e) => {
    if (e.target.classList.contains('remove-contact')) {
      const fieldWrapper = e.target.closest('.contact-fields');
      if (fieldWrapper.dataset.existing === 'true') {
        fieldWrapper.querySelector('.destroy-flag').value = '1';
        fieldWrapper.style.display = 'none';
      } else {
        fieldWrapper.remove();
      }
    }
  });
}
