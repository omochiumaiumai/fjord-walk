document.addEventListener('turbo:load', () => {
  const button = document.getElementById('button');
  const bars = document.getElementById('bars');
  const xmark = document.getElementById('xmark');
  const menu = document.getElementById('menu');

  if (menu) {
    menu.classList.add('translate-x-full');
  }
  if (bars) {
    bars.classList.remove('hidden');
  }
  if (xmark) {
    xmark.classList.add('hidden');
  }

  if (button) {
    button.addEventListener('click', () => {
      if (menu.classList.contains('translate-x-full')) {
        menu.classList.remove('translate-x-full');
        menu.classList.add('translate-x-0');
        bars.classList.add('hidden');
        xmark.classList.remove('hidden');
      } else {
        menu.classList.remove('translate-x-0');
        menu.classList.add('translate-x-full');
        bars.classList.remove('hidden');
        xmark.classList.add('hidden');
      }
    });
  }
});
