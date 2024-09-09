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

let Hooks = {}

Hooks.DrawerHook = {
	updated() {
		this.handleEvent("open-drawer", () => {
			this.el.classList.remove('translate-x-full');
			this.el.classList.add('translate-x-0');
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

// sort dropdown menu
document.addEventListener('DOMContentLoaded', () => {
	const sortMenuButton = document.getElementById('sort-menu-button');
	const sortMenu = document.getElementById('sort-menu');

	function toggleSortMenu() {
		const isExpanded = sortMenuButton.getAttribute('aria-expanded') === 'true';
		sortMenuButton.setAttribute('aria-expanded', !isExpanded);

		if (!isExpanded) {
			sortMenu.classList.remove("opacity-0", "scale-95");
			sortMenu.classList.add("opacity-100", "scale-100");
		} else {
			sortMenu.classList.remove("opacity-100", "scale-100");
			sortMenu.classList.add("opacity-0", "scale-95");
		}
	}

	// toggle sort menu when button is clicked
	sortMenuButton.addEventListener('click', (event) => {
		event.stopPropagation();
		toggleSortMenu();
	});

	// close sort menu if clicking outside of it
	document.addEventListener('click', (event) => {
		if (!sortMenuButton.contains(event.target) && !sortMenu.contains(event.target)) {
			sortMenuButton.setAttribute('aria-expanded', 'false');
			sortMenu.classList.remove("opacity-100", "scale-100");
			sortMenu.classList.add("opacity-0", "scale-95");
		}
	});
});
