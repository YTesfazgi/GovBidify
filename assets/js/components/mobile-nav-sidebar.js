export function initializeMobileNavSidebar() {
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
}