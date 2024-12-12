import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["navbar", "bottomNav", "sidebar", "fab"];

  connect() {
    console.log("naviation controller connected");

    this.checkScreenSize();
    window.addEventListener("resize", this.checkScreenSize.bind(this));
  }

  checkScreenSize() {
    const isMobile = window.innerWidth < 768;

    console.log(isMobile); // Breakpoint mobile

    this.navbarTarget.classList.toggle("d-none", isMobile);
    this.bottomNavTarget.classList.toggle("d-none", !isMobile);
    this.sidebarTarget.classList.toggle("d-none", isMobile);
    this.fabTarget.classList.toggle("d-none", isMobile);
  }
}
