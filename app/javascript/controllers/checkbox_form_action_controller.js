import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="checkbox-form-action"
export default class extends Controller {
  static targets = ["field"]

  connect() {
    console.log('coucou')
  }

  toggle() {
    this.fieldTarget.classList.toggle("d-none")
  }
}
