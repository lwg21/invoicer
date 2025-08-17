import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="revealer"
export default class extends Controller {
  static targets = ["toReveal"]

  connect() {
    console.log("revealer is connected");
  }

  reveal() {
    this.toRevealTargets.forEach(target => target.classList.remove("disabled"));
  }
}
