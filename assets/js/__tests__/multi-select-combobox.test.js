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
      const input = component.querySelector('.filter-input');

      // Test Enter key
      const enterEvent = new KeyboardEvent('keydown', { key: 'Enter' });
      input.dispatchEvent(enterEvent);

      const dropdown = component.querySelector('.dropdown');
      expect(dropdown.classList.contains('hidden')).toBeFalsy();
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
});
