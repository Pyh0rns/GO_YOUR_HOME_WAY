import { Controller } from "@hotwired/stimulus"


// Connects to data-controller="sidebar"
export default class extends Controller {
  static targets = ["tab"]
  // connect() {
  //   console.log("coucou")
  // }

  active() {
    // console.log("coucou")
    this.tabTargets.forEach(tab => {
      tab.classList.toggle("tab-active");
    });
  }
}
