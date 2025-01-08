class MultiInput extends HTMLElement {
  constructor() {
    super();

    // Initialize selected options
    this.selectedOptions = new Set();
  }

  connectedCallback() {
    this.innerHTML = `
      <div class="multi-input-container mt-1 flex rounded-md shadow-sm">
        <input
          type="text"
          class="input block w-full rounded-l-md border-gray-300 focus:border-brand focus:ring-brand sm:text-sm placeholder:text-gray-500"
          placeholder="Search...">
        <button type="button" class="add-button inline-flex items-center px-3 rounded-r-md border border-l-0 border-gray-300 bg-gray-50 text-gray-500 sm:text-sm">Add</button>
      </div>
      <div class="selected-options mt-2 flex flex-wrap gap-2"></div>
    `;

    this.input = this.querySelector('.input');
    this.addButton = this.querySelector('.add-button');
    this.selectedOptionsContainer = this.querySelector('.selected-options');

    this.addButton.addEventListener('click', () => this.addCode(this.input.value.trim()));
    this.input.addEventListener('keydown', (event) => {
      if (event.key === 'Enter') {
        event.preventDefault();
        this.addCode(this.input.value.trim());
      }
    });
  }

  addCode(code) {
    if (code && !this.selectedOptions.has(code)) {
      this.selectedOptions.add(code);
      this.updateSelectedOptions();
      this.input.value = '';
    }
  }

  removeCode(code) {
    this.selectedOptions.delete(code);
    this.updateSelectedOptions();
  }

  updateSelectedOptions() {
    this.selectedOptionsContainer.innerHTML = '';
    this.selectedOptions.forEach(code => {
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
      optionElement.querySelector('button').addEventListener('click', () => this.removeCode(code));
      this.selectedOptionsContainer.appendChild(optionElement);
    });
  }
}

// Register the custom element
customElements.define('multi-input', MultiInput);