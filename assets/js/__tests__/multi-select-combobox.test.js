describe('MultiSelectCombobox', () => {
  let component;

  beforeEach(() => {
    // Clear the DOM between tests
    document.body.innerHTML = '';

    // Create the component
    component = document.createElement('multi-select-combobox');
    component.setAttribute('name', 'test-select');
    document.body.appendChild(component);
  });

  describe('initialization', () => {
    it('should initialize with empty options when no attributes are set', () => {
      expect(component.querySelector('.option')).toBeNull();
      expect(component.selectedOptions.size).toBe(0);
    });

    it('should parse array options correctly', () => {
      const options = ['one', 'two', 'three'];
      component.setAttribute('options', JSON.stringify(options));

      // Trigger connectedCallback manually
      component.connectedCallback();

      const optionElements = component.querySelectorAll('.option');
      expect(optionElements.length).toBe(3);
      expect(optionElements[0].getAttribute('data-value')).toBe('one');
      expect(optionElements[0].textContent.trim()).toBe('one');
    });

    it('should parse object options correctly', () => {
      const options = { '1': 'One', '2': 'Two' };
      component.setAttribute('options', JSON.stringify(options));
      component.connectedCallback();

      const optionElements = component.querySelectorAll('.option');
      expect(optionElements.length).toBe(2);
      expect(optionElements[0].getAttribute('data-value')).toBe('1');
      expect(optionElements[0].textContent.trim()).toBe('One');
    });

    it('should initialize with pre-selected values', () => {
      const options = ['one', 'two', 'three'];
      const selectedValues = ['one', 'three'];

      component.setAttribute('options', JSON.stringify(options));
      component.setAttribute('value', JSON.stringify(selectedValues));
      component.connectedCallback();

      expect(component.selectedOptions.size).toBe(2);
      expect(component.selectedOptions.has('one')).toBeTruthy();
      expect(component.selectedOptions.has('three')).toBeTruthy();
    });
  });

  describe('user interactions', () => {
    beforeEach(() => {
      const options = ['one', 'two', 'three'];
      component.setAttribute('options', JSON.stringify(options));
      component.connectedCallback();
    });

    it('should toggle dropdown on input click', () => {
      const input = component.querySelector('.filter-input');
      const dropdown = component.querySelector('.dropdown');

      input.click();
      expect(dropdown.classList.contains('hidden')).toBeFalsy();

      input.click();
      expect(dropdown.classList.contains('hidden')).toBeTruthy();
    });

    it('should filter options based on input', () => {
      const input = component.querySelector('.filter-input');

      // Simulate typing
      input.value = 'tw';
      input.dispatchEvent(new Event('input'));

      const options = component.querySelectorAll('.option');
      expect(options[0].classList.contains('hidden')).toBeTruthy(); // 'one'
      expect(options[1].classList.contains('hidden')).toBeFalsy();  // 'two'
      expect(options[2].classList.contains('hidden')).toBeTruthy(); // 'three'
    });

    it('should select and deselect options on click', () => {
      const firstOption = component.querySelector('.option');

      // Select option
      firstOption.click();
      expect(component.selectedOptions.has('one')).toBeTruthy();
      expect(firstOption.getAttribute('data-selected')).toBe('true');

      // Deselect option
      firstOption.click();
      expect(component.selectedOptions.has('one')).toBeFalsy();
      expect(firstOption.getAttribute('data-selected')).toBe('false');
    });

    it('should update hidden inputs when selection changes', () => {
      const firstOption = component.querySelector('.option');

      firstOption.click();

      const hiddenInputs = component.querySelectorAll('.hidden-input');
      expect(hiddenInputs.length).toBe(1);
      expect(hiddenInputs[0].value).toBe('one');
      expect(hiddenInputs[0].name).toBe('test-select[]');
    });
  });

  describe('accessibility', () => {
    it('should handle keyboard navigation', () => {
      const component = document.createElement('multi-select-combobox');
      document.body.appendChild(component);

      const options = ['one', 'two', 'three'];
      component.setAttribute('options', JSON.stringify(options));
      component.connectedCallback();

      const filterInput = component.querySelector('.filter-input');
      const dropdown = component.querySelector('.dropdown');

      // Create a proper keyboard event
      const enterEvent = new KeyboardEvent('keydown', {
        key: 'Enter',
        bubbles: true,
        cancelable: true,
        preventDefault: () => {}
      });

      filterInput.focus();

      // Simulate Enter key press
      filterInput.dispatchEvent(enterEvent);

      // Check if dropdown is visible
      expect(dropdown.classList.contains('hidden')).toBeFalsy();

      // Simulate Enter key press again to close
      filterInput.dispatchEvent(enterEvent);

      // Check if dropdown is hidden
      expect(dropdown.classList.contains('hidden')).toBeTruthy();

      // Clean up
      document.body.removeChild(component);
    });

    it('should have proper ARIA attributes', () => {
      const dropdown = component.querySelector('.dropdown');
      const options = component.querySelectorAll('.option');

      expect(dropdown.getAttribute('role')).toBe('listbox');
      options.forEach(option => {
        expect(option.getAttribute('role')).toBe('option');
      });
    });
  });

  describe('cleanup', () => {
    beforeEach(() => {
      const options = ['one', 'two', 'three'];
      component.setAttribute('options', JSON.stringify(options));
      component.connectedCallback();
    });

    it('should remove all event listeners when disconnected', () => {
      // Set up spies
      const removeEventListenerSpy = jest.spyOn(document, 'removeEventListener');
      const inputRemoveEventListenerSpy = jest.spyOn(component.filterInput, 'removeEventListener');

      // Add some selected options to test cleanup
      const firstOption = component.querySelector('.option');
      firstOption.click();

      // Trigger disconnectedCallback
      component.remove();

      // Check document listener cleanup
      expect(removeEventListenerSpy).toHaveBeenCalledWith('click', expect.any(Function));

      // Check input listener cleanup
      expect(inputRemoveEventListenerSpy).toHaveBeenCalledWith('click', expect.any(Function));
      expect(inputRemoveEventListenerSpy).toHaveBeenCalledWith('keydown', expect.any(Function));
      expect(inputRemoveEventListenerSpy).toHaveBeenCalledWith('input', expect.any(Function));

      // Check option listener cleanup
      const optionElements = component.querySelectorAll('.option');
      expect(optionElements[0].onclick).toBeNull();

      // Check remove button listener cleanup
      const removeButtons = component.querySelectorAll('.selected-options button');
      expect(removeButtons[0].onclick).toBeNull();

      // Clean up spies
      removeEventListenerSpy.mockRestore();
      inputRemoveEventListenerSpy.mockRestore();
    });
  });
});
