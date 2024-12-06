export function initializeMultiInput(inputId, buttonId, selectedOptionsId) {
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