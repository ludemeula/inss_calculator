// app/javascript/controllers/calculate_inss_controller.js

import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["salary", "inss"]

  connect() {
    this.salaryTarget.addEventListener('input', this.calculate.bind(this))
  }

  calculate() {
    const salary = parseFloat(this.salaryTarget.value)
    if (!salary) return

    fetch(`/calculate_inss?salary=${salary}`)
      .then(response => response.json())
      .then(data => {
        this.inssTarget.value = data.discount
      })
  }
}
