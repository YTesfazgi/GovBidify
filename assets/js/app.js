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

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}})

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
	const menuButton = document.getElementById('user-menu-button');
	const dropdownMenu = document.getElementById('dropdown-menu');

	const drawer = document.getElementById('drawer');
	const closeDrawerButton = document.getElementById('close-drawer-button');

	// open user menu
	menuButton.addEventListener('click', () => {
		const isExpanded = menuButton.getAttribute('aria-expanded') === 'true';
		menuButton.setAttribute('aria-expanded', !isExpanded);
		dropdownMenu.classList.toggle('hidden');
	});

	// close user menu if clicking outside of it
	document.addEventListener('click', (event) => {
		if (!menuButton.contains(event.target) && !dropdownMenu.contains(event.target)) {
		menuButton.setAttribute('aria-expanded', 'false');
		dropdownMenu.classList.add('hidden');
		}
	});

	// close drawer by clicking x
	closeDrawerButton.addEventListener('click', () => {
		drawer.classList.remove('translate-x-0');
		drawer.classList.add('translate-x-full');
	});
});
