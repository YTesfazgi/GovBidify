// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.

// The simplest option is to put them in assets/vendor and
// import them using relative paths:

//   import "../vendor/some-package.js"

// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:

//   import "some-package"


// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

import "./components/multi-select-combobox"
import { initializeSortMenu } from './components/sort-menu.js';
import { initializeMobileNavSidebar } from './components/mobile-nav-sidebar.js';
import { initializeMultiInput } from './components/multi-input.js';

let Hooks = {}

Hooks.DrawerHook = {
	mounted() {
		// Ensure drawer starts closed
		this.el.classList.add('translate-x-full');
		this.el.classList.remove('translate-x-0');
	},
	updated() {
		this.handleEvent("open-drawer", () => {
			// Small delay to ensure proper transition
			requestAnimationFrame(() => {
				this.el.classList.remove('translate-x-full');
				this.el.classList.add('translate-x-0');
			});
		});

		this.handleEvent("close-drawer", () => {
			this.el.classList.add('translate-x-full');
			this.el.classList.remove('translate-x-0');
		});
	}
};

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {
	params: {_csrf_token: csrfToken},
	hooks: Hooks
})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", _info => topbar.show(300))
window.addEventListener("phx:page-loading-stop", _info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

document.addEventListener('DOMContentLoaded', () => {
  initializeSortMenu();
  initializeMobileNavSidebar();

  initializeMultiInput('naics-code', 'add-naics-code', 'naics-selected-options');
  initializeMultiInput('psc-code', 'add-psc-code', 'psc-selected-options');
  initializeMultiInput('city', 'add-city', 'city-selected-options');
  initializeMultiInput('zip-code', 'add-zip-code', 'zip-code-selected-options');
});