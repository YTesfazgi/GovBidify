// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import topbar from "../vendor/topbar"

import "./components/multi-select-combobox"
import { initializeSortMenu } from './components/sortMenu.js';

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
});

// mobile nav menu
document.addEventListener('DOMContentLoaded', () => {
	const menuSidebar = document.getElementById("mobile-nav-sidebar");
	const menuContainer = document.getElementById("mobile-nav-menu-container");
	const backdrop = document.getElementById("mobile-nav-menu-backdrop");
	const openButton = document.getElementById("mobile-nav-menu-open-button");
	const closeButton = document.getElementById("mobile-nav-menu-close-button");

	function openMenu() {
		menuContainer.classList.remove("hidden");

		// this timeout is necessary for the browser to register the initial css values
		setTimeout(() => {
			menuContainer.classList.remove("opacity-0");
			menuContainer.classList.add("opacity-100");

			menuSidebar.classList.remove("-translate-x-full");
			menuSidebar.classList.add("translate-x-0");

			backdrop.classList.remove("opacity-0");
			backdrop.classList.add("opacity-100");

			closeButton.classList.remove("opacity-0");
			closeButton.classList.add("opacity-100");
		}, 0);
	}

	function closeMenu() {
		menuSidebar.classList.remove("translate-x-0");
		menuSidebar.classList.add("-translate-x-full");

		backdrop.classList.remove("opacity-100");
		backdrop.classList.add("opacity-0");

		closeButton.classList.remove("opacity-100");
		closeButton.classList.add("opacity-0");

		setTimeout(() => {
			menuContainer.classList.add("hidden");
		}, 300); // matches duration of CSS transition
	}

	backdrop.addEventListener("click", closeMenu);
	closeButton.addEventListener("click", closeMenu);
	openButton.addEventListener("click", openMenu);
});

// Add this to your existing DOMContentLoaded event listener
document.addEventListener('DOMContentLoaded', () => {
  // Setup code input fields
  setupCodeInput('naics-code', 'add-naics-code', 'naics-selected-options');
  setupCodeInput('psc-code', 'add-psc-code', 'psc-selected-options');
  setupCodeInput('city', 'add-city', 'city-selected-options');
  setupCodeInput('zip-code', 'add-zip-code', 'zip-code-selected-options');
});

// Add this function to your JavaScript file
function setupCodeInput(inputId, buttonId, selectedOptionsId) {
  const input = document.getElementById(inputId);
  const addButton = document.getElementById(buttonId);
  const selectedOptionsContainer = document.getElementById(selectedOptionsId);
  const selectedOptions = new Set();

  function addCode(code) {
    if (code && !selectedOptions.has(code)) {
      selectedOptions.add(code);
      updateSelectedOptions();
      input.value = ''; // Clear the input after adding
    }
  }

  function removeCode(code) {
    selectedOptions.delete(code);
    updateSelectedOptions();
  }

  function updateSelectedOptions() {
    selectedOptionsContainer.innerHTML = '';
    selectedOptions.forEach(code => {
      const optionElement = document.createElement('span');
      optionElement.className = 'inline-flex items-center px-2 py-1 rounded-md text-sm font-medium bg-green-100 text-green-800';
      optionElement.innerHTML = `
        ${code}
        <button type="button" class="ml-1 inline-flex items-center p-0.5 text-green-400 hover:bg-green-200 hover:text-green-500 rounded-sm">
          <svg class="h-3 w-3" fill="currentColor" viewBox="0 0 20 20">
            <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
          </svg>
        </button>
      `;
      optionElement.querySelector('button').addEventListener('click', () => removeCode(code));
      selectedOptionsContainer.appendChild(optionElement);
    });
  }

  addButton.addEventListener('click', () => addCode(input.value.trim()));

  input.addEventListener('keydown', (event) => {
    if (event.key === 'Enter') {
      event.preventDefault();
      addCode(input.value.trim());
    }
  });
}