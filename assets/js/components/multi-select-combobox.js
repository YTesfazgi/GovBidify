class MultiSelectCombobox extends HTMLElement {
  constructor() {
    super();
    console.info('MultiSelectCombobox: Constructed');

    // Initialize selected options
    this.selectedOptions = new Set();

    // Bind methods
    this.toggleDropdown = this.toggleDropdown.bind(this);
    this.closeDropdown = this.closeDropdown.bind(this);
    this.handleOptionClick = this.handleOptionClick.bind(this);
    this.handleInput = this.handleInput.bind(this);
    this.handleOutsideClick = this.handleOutsideClick.bind(this);
  }

  connectedCallback() {
    console.info('MultiSelectCombobox: Connected to the DOM');
    let options = [];
    try {
      const optionsAttr = this.getAttribute('options');
      options = optionsAttr ? JSON.parse(optionsAttr) : [];
      if (!Array.isArray(options)) {
        throw new Error('Options should be an array, got ' + optionsAttr);
      }
    } catch (error) {
      console.error('MultiSelectCombobox: Error parsing options', error);
    }

    const name = this.getAttribute('name') || 'combobox';
    this.render(options, name);
  }

  render(options, name) {
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
                   data-value="${option}"
                   role="option">
                ${option}
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
    this.filterInput.addEventListener('keydown', (e) => {
      if (e.key === 'Enter' || e.key === ' ') {
        e.preventDefault();
        this.toggleDropdown(e);
      }
    });

    this.querySelectorAll('.option').forEach(option => {
      option.addEventListener('click', this.handleOptionClick);
    });

    this.filterInput.addEventListener('input', this.handleInput);
    document.addEventListener('click', this.handleOutsideClick);
  }

  toggleDropdown(event) {
    event.stopPropagation();
    const isOpen = this.dropdown.classList.toggle('hidden');
    this.dropdown.setAttribute('aria-expanded', !isOpen);
    if (!isOpen) {
        this.filterInput.focus();
        console.log('MultiSelectCombobox: Dropdown opened');
    } else {
        this.closeDropdown();
    }
  }

  closeDropdown() {
    this.dropdown.classList.add('hidden');
    this.filterInput.value = '';
    this.filterOptions('');
    this.selectedOptionsContainer.setAttribute('aria-expanded', 'false');
    console.log('MultiSelectCombobox: Dropdown closed');
  }

  handleOptionClick(event) {
    const option = event.currentTarget;
    const value = option.getAttribute('data-value');

    if (this.selectedOptions.has(value)) {
      this.selectedOptions.delete(value);
      option.setAttribute('data-selected', 'false');
    } else {
      this.selectedOptions.add(value);
      option.setAttribute('data-selected', 'true');
    }

    this.updateSelectedOptions();
    this.updateHiddenInput();
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
    this.querySelectorAll('.option').forEach(option => {
      const text = option.textContent.toLowerCase();
      if (text.includes(query)) {
        option.classList.remove('hidden');
      } else {
        option.classList.add('hidden');
      }
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
        const span = document.createElement('span');
        span.className = 'bg-gray-200 rounded px-2 py-1 flex items-center text-sm';
        span.textContent = value;

        const button = document.createElement('button');
        button.type = 'button';
        button.setAttribute('aria-label', `Remove ${value}`);
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

    // Create a new hidden input for each selected option
    Array.from(this.selectedOptions).forEach(value => {
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = this.getAttribute('name') + '[]';
      input.value = value;
      input.className = 'hidden-input';
      this.appendChild(input);
    });

    // Emit change event on the last created input
    const lastInput = this.querySelector('.hidden-input:last-child');
    if (lastInput) {
      const event = new Event('change', { bubbles: true });
      lastInput.dispatchEvent(event);
    }

    console.log('MultiSelectCombobox: Hidden inputs updated');
  }
}

// Define the custom element
customElements.define('multi-select-combobox', MultiSelectCombobox);
