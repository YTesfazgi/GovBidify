class MultiInput extends HTMLElement {
  constructor() {
    super();

    // Initialize selected options
    this.selectedOptions = new Set();

    // Bind methods
    this.addCode = this.addCode.bind(this);
    this.removeCode = this.removeCode.bind(this);
    this.updateSelectedOptions = this.updateSelectedOptions.bind(this);
  }

  connectedCallback() {
    try {
      const valueAttr = this.getAttribute('value');
      const selectedValues = valueAttr ? JSON.parse(valueAttr) : [];
      this.selectedOptions = new Set(selectedValues);
    } catch (error) {
      console.error('MultiInput: Error parsing attributes', error);
    }

    this.render();

    // After rendering, update the UI to show selected options
    this.updateSelectedOptions();

    // Update the data-selected attribute on pre-selected options
    this.querySelectorAll('.option').forEach(option => {
      const value = option.getAttribute('data-value');
      if (this.selectedOptions.has(value)) {
        option.setAttribute('data-selected', 'true');
      }
    });

    this.addButton.addEventListener('click', () => this.addCode(this.input.value.trim()));
    this.input.addEventListener('keydown', (event) => {
      if (event.key === 'Enter') {
        event.preventDefault();
        this.addCode(this.input.value.trim());
      }
    });
  }

  render() {
    const html = `
      <div class="multi-input-container mt-1 flex rounded-md shadow-sm">
        <input
          type="text"
          class="input block w-full rounded-l-md border-gray-300 focus:border-brand focus:ring-brand sm:text-sm placeholder:text-gray-500"
          placeholder="Search...">
        <button type="button" class="add-button inline-flex items-center px-3 rounded-r-md border border-l-0 border-gray-300 bg-gray-50 text-gray-500 sm:text-sm">Add</button>
      </div>
      <div class="selected-options mt-2 flex flex-wrap gap-2"></div>
    `;

    this.innerHTML = html;

    // References
    this.input = this.querySelector('.input');
    this.addButton = this.querySelector('.add-button');
    this.selectedOptionsContainer = this.querySelector('.selected-options');
    // this.hiddenInput = this.querySelector('.hidden-input');
  }

  addCode(code) {
    if (code && !this.selectedOptions.has(code)) {
      this.selectedOptions.add(code);
      this.updateSelectedOptions();
      this.updateHiddenInput();
      this.input.value = '';
    }
  }

  removeCode(code) {
    this.selectedOptions.delete(code);
    this.updateSelectedOptions();
    this.updateHiddenInput();
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
      this.querySelectorAll('.option').forEach(option => {
        option.classList.remove('hidden');
      });
    });
  }

  updateHiddenInput() {
    // Remove existing hidden inputs
    this.querySelectorAll('.hidden-input').forEach(input => input.remove());

    if (this.selectedOptions.size === 0) {
      // Create a temporary hidden input to emit the change event
      const input = document.createElement('input');
      input.type = 'hidden';
      input.name = this.getAttribute('name') + '[]';
      input.className = 'hidden-input';
      this.appendChild(input);

      // Emit change event on the input
      const event = new Event('change', { bubbles: true });
      input.dispatchEvent(event);
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
}

// Register the custom element
customElements.define('multi-input', MultiInput);