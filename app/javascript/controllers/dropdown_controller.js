import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["menu"];

  toggle(event) {
    event.preventDefault();
    // event.stopPropagation();

    // Fermer tous les autres menus ouverts
    document
      .querySelectorAll('[data-dropdown-target="menu"]')
      .forEach((menu) => {
        if (menu !== this.menuTarget) {
          menu.style.display = "none";
        }
      });

    // Basculer le menu actuel
    this.menuTarget.style.display =
      this.menuTarget.style.display === "none" ? "block" : "none";

    // Fermer le menu si on clique ailleurs
    if (this.menuTarget.style.display === "block") {
      const outsideClickListener = (event) => {
        if (!this.element.contains(event.target)) {
          this.menuTarget.style.display = "none";
          document.removeEventListener("click", outsideClickListener);
        }
      };
      document.addEventListener("click", outsideClickListener);
    }
  }
}
