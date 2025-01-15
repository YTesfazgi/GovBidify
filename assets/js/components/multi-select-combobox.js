class MultiSelectCombobox extends HTMLElement {
  constructor() {
    super();

    // Initialize selected options
    this.selectedOptions = new Set();

    // Bind methods
    this.toggleDropdown = this.toggleDropdown.bind(this);
    this.closeDropdown = this.closeDropdown.bind(this);
    this.handleOptionClick = this.handleOptionClick.bind(this);
    this.handleInput = this.handleInput.bind(this);
    this.handleOutsideClick = this.handleOutsideClick.bind(this);
    this.handleKeydown = this.handleKeydown.bind(this);
  }

  connectedCallback() {
    let options = [];
    let selectedValues = [];

    try {
      const optionsAttr = this.getAttribute('options');
      const valueAttr = this.getAttribute('value');

      // Parse options and handle both array and object formats
      if (optionsAttr) {
        const parsedOptions = JSON.parse(optionsAttr);
        options = Array.isArray(parsedOptions)
          ? parsedOptions.map(opt => ({ value: opt, label: opt }))
          : Object.entries(parsedOptions).map(([value, label]) => ({ value, label }));
      }

      selectedValues = valueAttr ? JSON.parse(valueAttr) : [];
      this.selectedOptions = new Set(selectedValues);
    } catch (error) {
      console.error('MultiSelectCombobox: Error parsing attributes', error);
    }

    this.render(options);

    // After rendering, update the UI to show selected options
    this.updateSelectedOptions();

    // Update the data-selected attribute on pre-selected options
    this.querySelectorAll('.option').forEach(option => {
      const value = option.getAttribute('data-value');
      if (this.selectedOptions.has(value)) {
        option.setAttribute('data-selected', 'true');
      }
    });
  }

  disconnectedCallback() {
    // Remove global listener
    document.removeEventListener('click', this.handleOutsideClick);

    // Remove input listeners
    if (this.filterInput) {
      this.filterInput.removeEventListener('click', this.toggleDropdown);
      this.filterInput.removeEventListener('keydown', this.handleKeydown);
      this.filterInput.removeEventListener('input', this.handleInput);
    }

    // Remove option listeners
    this.querySelectorAll('.option').forEach(option => {
      option.removeEventListener('click', this.handleOptionClick);
    });

    // Remove selected option remove button listeners
    this.querySelectorAll('.selected-options button').forEach(button => {
      button.removeEventListener('click', this.handleRemoveOption);
    });

    // Remove option keydown listeners
    this.querySelectorAll('.option').forEach(option => {
      option.removeEventListener('keydown', this.handleKeydown);
    });
  }

  render(options) {
    const html = `
      <div class="relative w-full font-sans">
        <div class="selected-options flex flex-wrap gap-2 py-2 rounded-t min-h-[40px] items-center hidden">
        </div>
        <input type="text"
               class="filter-input w-full p-2 border-x border-b border-gray-300 rounded-lg outline-none"
               placeholder="Search..."
               aria-label="Search options" />
        <div class="dropdown hidden absolute w-full bg-white border border-gray-300 rounded-b z-[1000] shadow-lg max-h-[200px] overflow-y-auto"
             role="listbox">
          <div class="w-full">
            ${options.map(option => `
              <div class="option p-2 cursor-pointer w-full box-border text-sm hover:bg-gray-100 data-[selected=true]:bg-green-100"
                   data-value="${option.value}"
                   data-label="${option.label}"
                   role="option"
                   tabindex="0">
                ${option.label}
              </div>
            `).join('')}
          </div>
        </div>
      </div>
    `;

    this.innerHTML = html;

    // References
    this.selectedOptionsContainer = this.querySelector('.selected-options');
    this.dropdown = this.querySelector('.dropdown');
    this.filterInput = this.querySelector('.filter-input');
    this.hiddenInput = this.querySelector('.hidden-input');

    // Event listeners
    this.filterInput.addEventListener('click', this.toggleDropdown);
    this.filterInput.addEventListener('keydown', this.handleKeydown);
    this.filterInput.addEventListener('input', this.handleInput);

    // Store all commonly accessed elements as properties
    this.optionElements = this.querySelectorAll('.option');

    // Update event listeners to use stored elements
    this.optionElements.forEach(option => {
      option.addEventListener('click', this.handleOptionClick);
      option.addEventListener('keydown', this.handleKeydown);
      // Make sure options can receive focus
      option.setAttribute('tabindex', '0');
    });

    this.filterInput.addEventListener('input', this.handleInput);
    document.addEventListener('click', this.handleOutsideClick);
  }

  toggleDropdown(event) {
    event.stopPropagation();
    const isHidden = this.dropdown.classList.contains('hidden');

    if (isHidden) {
      this.dropdown.classList.remove('hidden');
      this.dropdown.setAttribute('aria-expanded', 'true');
      this.filterInput.focus();
    } else {
      this.closeDropdown();
    }
  }

  closeDropdown() {
    this.dropdown.classList.add('hidden');
    this.dropdown.setAttribute('aria-expanded', 'false');
    this.filterInput.value = '';
    this.filterOptions('');
  }

  handleOptionClick(event) {
    const option = event.currentTarget;
    const value = option.getAttribute('data-value');
    const label = option.getAttribute('data-label');

    if (this.selectedOptions.has(value)) {
      this.selectedOptions.delete(value);
      option.setAttribute('data-selected', 'false');
    } else {
      this.selectedOptions.add(value);
      option.setAttribute('data-selected', 'true');
    }

    // Store both value and label
    option.dataset.selectedLabel = label;

    this.updateSelectedOptions();
    this.updateHiddenInput();

    // Prevent the click from removing focus
    event.preventDefault();
    // Restore focus to the filter input
    this.filterInput.focus();
  }

  handleInput(event) {
    // Prevent the input's native change event from bubbling
    event.stopPropagation();
    const query = event.target.value.toLowerCase();
    this.filterOptions(query);
  }

  handleOutsideClick(event) {
    if (!this.contains(event.target)) {
      this.closeDropdown();
    }
  }

  filterOptions(query) {
    // Use stored elements instead of querying
    this.optionElements.forEach(option => {
      // Cache the lowercase text in data attribute during render
      const text = option.dataset.searchText ||
        (option.dataset.searchText = option.textContent.toLowerCase());
      option.classList.toggle('hidden', !text.includes(query));
    });
  }

  updateSelectedOptions() {
    this.selectedOptionsContainer.innerHTML = '';

    if (this.selectedOptions.size === 0) {
      this.selectedOptionsContainer.classList.add('hidden');
    } else {
      this.selectedOptionsContainer.classList.remove('hidden');
    }

    this.selectedOptions.forEach(value => {
      const option = this.querySelector(`.option[data-value="${value}"]`);
      const label = option ? option.getAttribute('data-label') : value;

      const span = document.createElement('span');
      span.className = 'bg-gray-200 rounded px-2 py-1 flex items-center text-sm';
      span.textContent = label;

      const button = document.createElement('button');
      button.type = 'button';
      button.setAttribute('aria-label', `Remove ${label}`);
      button.className = 'ml-2 bg-transparent border-none cursor-pointer text-base leading-none hover:text-gray-700';
      button.innerHTML = '&times;';
      button.addEventListener('click', (e) => {
          e.stopPropagation();
          this.selectedOptions.delete(value);
          this.updateSelectedOptions();
          this.updateHiddenInput();
          const correspondingOption = this.querySelector(`.option[data-value="${value}"]`);
          if (correspondingOption) {
              correspondingOption.setAttribute('data-selected', 'false');
          }
      });

      span.appendChild(button);
      this.selectedOptionsContainer.appendChild(span);
      this.filterInput.value = '';
      this.querySelectorAll('.option').forEach(option => {
        option.classList.remove('hidden');
      });
    });
  }

  updateHiddenInput() {
    // Remove existing hidden inputs
    this.querySelectorAll('.hidden-input').forEach(input => input.remove());

    if (this.selectedOptions.size === 0) {
      const event = new Event('change', { bubbles: true });
      this.dispatchEvent(event);
      return;
    }

    // Create a new hidden input for each selected option
    Array.from(this.selectedOptions).forEach(value => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = this.getAttribute('name') + '[]';
      input.value = value;
      input.className = 'hidden-input';
      this.appendChild(input);

      // Emit change event for each input
      const event = new Event('change', { bubbles: true });
      input.dispatchEvent(event);
    });
  }

  handleKeydown(event) {
    const options = Array.from(this.querySelectorAll('.option:not(.hidden)'));
    const currentIndex = options.findIndex(option => option === document.activeElement);

    switch (event.key) {
      case 'Enter':
        event.preventDefault();
        if (document.activeElement === this.filterInput) {
          // Toggle dropdown when Enter is pressed on input
          this.toggleDropdown(event);
        } else if (document.activeElement.classList.contains('option')) {
          // Select option when Enter is pressed on an option
          this.handleOptionClick({
            currentTarget: document.activeElement,
            preventDefault: () => {}
          });
        }
        break;

      case 'ArrowDown':
        event.preventDefault();
        if (this.dropdown.classList.contains('hidden')) {
          this.toggleDropdown(event);
        } else {
          const nextIndex = currentIndex < 0 ? 0 : (currentIndex + 1) % options.length;
          options[nextIndex].focus();
        }
        break;

      case 'ArrowUp':
        event.preventDefault();
        if (!this.dropdown.classList.contains('hidden')) {
          const nextIndex = currentIndex < 0 ? options.length - 1 :
            (currentIndex - 1 + options.length) % options.length;
          options[nextIndex].focus();
        }
        break;

      case 'Escape':
        event.preventDefault();
        this.closeDropdown();
        break;
    }
  }
}

// Define the custom element
customElements.define('multi-select-combobox', MultiSelectCombobox);
