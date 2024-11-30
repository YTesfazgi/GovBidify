export function initializeSortMenu() {
    const sortMenuButton = document.getElementById('sort-menu-button');
    const sortMenu = document.getElementById('sort-menu');

    function toggleSortMenu() {
        const isExpanded = sortMenuButton.getAttribute('aria-expanded') === 'true';
        sortMenuButton.setAttribute('aria-expanded', !isExpanded);

        if (!isExpanded) {
            sortMenu.classList.remove("hidden");
            // Force a reflow
            void sortMenu.offsetHeight;
            // Then add the visible classes
            sortMenu.classList.remove("opacity-0", "scale-95");
            sortMenu.classList.add("opacity-100", "scale-100");
        } else {
            sortMenu.classList.remove("opacity-100", "scale-100");
            sortMenu.classList.add("opacity-0", "scale-95");
            setTimeout(() => {
                sortMenu.classList.add("hidden");
            }, 150);
        }
    }

    function handleClickOutside(event) {
        if (!sortMenuButton.contains(event.target) && !sortMenu.contains(event.target)) {
            sortMenuButton.setAttribute('aria-expanded', 'false');
            sortMenu.classList.remove("opacity-100", "scale-100");
            sortMenu.classList.add("opacity-0", "scale-95");
            setTimeout(() => {
                sortMenu.classList.add("hidden");
            }, 150);
        }
    }

    // Event listeners
    sortMenuButton.addEventListener('click', (event) => {
        event.stopPropagation();
        toggleSortMenu();
    });

    document.addEventListener('click', handleClickOutside);
}
