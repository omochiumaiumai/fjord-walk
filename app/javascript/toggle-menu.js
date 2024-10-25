// app/javascript/menu.js

document.addEventListener('turbolinks:load', () => {
  const button = document.getElementById('button');
  const bars = document.getElementById('bars');
  const xmark = document.getElementById('xmark');
  const menu = document.getElementById('menu');

  if (menu) {
    menu.classList.add('hidden');
  }
  if (bars) {
    bars.classList.remove('hidden');
  }
  if (xmark) {
    xmark.classList.add('hidden');
  }

  if (button) {
    button.addEventListener('click', event => {
      if (!bars.classList.contains('hidden')) {
        bars.classList.add('hidden');
        menu.classList.remove('hidden');
      } else {
        bars.classList.remove('hidden');
        xmark.classList.add('hidden');
        menu.classList.add('hidden');
      }
    });
  }
});
