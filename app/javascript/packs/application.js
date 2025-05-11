import Rails from '@rails/ujs';
import Inputmask from 'inputmask';
Rails.start();

import 'stylesheets/application';
import 'bootstrap/dist/css/bootstrap.min.css';
import './flash';

import { applyAllMasks } from '../modules/masks';
import { handleCPFValidation } from '../modules/cpfValidation';
import { setupSalaryListener } from '../modules/salary';
import { setupAddRemoveContacts } from '../modules/contacts';

document.addEventListener('DOMContentLoaded', () => {
  applyAllMasks();
  handleCPFValidation();
  setupSalaryListener();
  setupAddRemoveContacts();
});
