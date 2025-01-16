describe('MultiInput', () => {
  let component;

  beforeEach(() => {
    // Clear the DOM between tests
    document.body.innerHTML = '';

    // Create the component
    component = document.createElement('multi-input');
    component.setAttribute('name', 'test-input');
    document.body.appendChild(component);
  });

  describe('initialization', () => {
    it('should initialize with empty options when no value is set', () => {
      expect(component.selectedOptions.size).toBe(0);
      expect(component.querySelector('.selected-options').children.length).toBe(0);
    });

    it('should initialize with pre-selected values', () => {
      const selectedValues = ['code1', 'code2'];
      component.setAttribute('value', JSON.stringify(selectedValues));
      component.connectedCallback();

      expect(component.selectedOptions.size).toBe(2);
      expect(component.selectedOptions.has('code1')).toBeTruthy();
      expect(component.selectedOptions.has('code2')).toBeTruthy();
    });

    it('should handle invalid JSON in value attribute', () => {
      const consoleSpy = jest.spyOn(console, 'error').mockImplementation();
      component.setAttribute('value', 'invalid-json');
      component.connectedCallback();

      expect(consoleSpy).toHaveBeenCalled();
      expect(component.selectedOptions.size).toBe(0);

      consoleSpy.mockRestore();
    });
  });

  describe('user interactions', () => {
    beforeEach(() => {
      component.connectedCallback();
    });

    it('should add code when clicking add button', () => {
      const input = component.querySelector('.input');
      const addButton = component.querySelector('.add-button');

      input.value = 'test-code';
      addButton.click();

      expect(component.selectedOptions.has('test-code')).toBeTruthy();
      expect(component.querySelector('.selected-options').children.length).toBe(1);
    });

    it('should add code when pressing Enter', () => {
      const input = component.querySelector('.input');

      input.value = 'test-code';
      input.dispatchEvent(new KeyboardEvent('keydown', { key: 'Enter' }));

      expect(component.selectedOptions.has('test-code')).toBeTruthy();
      expect(input.value).toBe('');
    });

    it('should not add empty or duplicate codes', () => {
      const input = component.querySelector('.input');
      const addButton = component.querySelector('.add-button');

      // Try adding empty code
      input.value = '';
      addButton.click();
      expect(component.selectedOptions.size).toBe(0);

      // Try adding duplicate code
      input.value = 'test-code';
      addButton.click();
      input.value = 'test-code';
      addButton.click();
      expect(component.selectedOptions.size).toBe(1);
    });

    it('should remove code when clicking remove button', () => {
      // First add a code
      component.addCode('test-code');
      expect(component.selectedOptions.size).toBe(1);

      // Click remove button
      const removeButton = component.querySelector('.selected-options button');
      removeButton.click();

      expect(component.selectedOptions.size).toBe(0);
      expect(component.querySelector('.selected-options').children.length).toBe(0);
    });
  });

  describe('hidden inputs', () => {
    it('should create hidden inputs for selected options', () => {
      component.addCode('test-code');

      const hiddenInputs = component.querySelectorAll('.hidden-input');
      expect(hiddenInputs.length).toBe(1);
      expect(hiddenInputs[0].value).toBe('test-code');
      expect(hiddenInputs[0].name).toBe('test-input[]');
    });

    it('should emit change event when selection changes', () => {
      const changeSpy = jest.fn();
      component.addEventListener('change', changeSpy);

      component.addCode('test-code');
      expect(changeSpy).toHaveBeenCalled();

      component.removeCode('test-code');
      expect(changeSpy).toHaveBeenCalledTimes(2);
    });

    it('should create empty hidden input when all codes are removed', () => {
      component.addCode('test-code');
      component.removeCode('test-code');

      const hiddenInputs = component.querySelectorAll('.hidden-input');
      expect(hiddenInputs.length).toBe(1);
      expect(hiddenInputs[0].value).toBe('');
      expect(hiddenInputs[0].name).toBe('test-input[]');
    });
  });

  describe('UI updates', () => {
    it('should show/hide selected options container based on selection', () => {
      const container = component.querySelector('.selected-options');
      expect(container.classList.contains('hidden')).toBeTruthy();

      component.addCode('test-code');
      expect(container.classList.contains('hidden')).toBeFalsy();

      component.removeCode('test-code');
      expect(container.classList.contains('hidden')).toBeTruthy();
    });

    it('should clear input after adding code', () => {
      const input = component.querySelector('.input');
      input.value = 'test-code';

      component.addCode('test-code');
      expect(input.value).toBe('');
    });
  });
});