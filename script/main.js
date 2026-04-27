let current = 1;
const total = 17;

// 加载页面内容
async function loadPage(n) {
  try {
    const response = await fetch(`page/${n}.html`);
    const content = await response.text();
    const container = document.getElementById('slide-container');

    // 重置所有特殊类
    container.className = 'slide active';

    // 添加页面特殊类
    if (n === 1) container.classList.add('slide-cover');
    if (n === 17) container.classList.add('slide-end');
    
    container.innerHTML = content;
    document.getElementById('progressBar').style.width = (n / total * 100) + '%';
    document.getElementById('navCounter').textContent = (n < 10 ? '0' + n : n) + ' / ' + total;
  } catch (error) {
    console.error('Failed to load page:', error);
  }
}

function nextSlide() {
  if (current < total) {
    current++;
    loadPage(current);
  }
}

function prevSlide() {
  if (current > 1) {
    current--;
    loadPage(current);
  }
}

// 按钮事件
document.getElementById('prevBtn').addEventListener('click', prevSlide);
document.getElementById('nextBtn').addEventListener('click', nextSlide);

// 键盘事件
document.addEventListener('keydown', function(e) {
  if (e.key === 'ArrowRight' || e.key === 'ArrowDown' || e.key === ' ') {
    e.preventDefault();
    nextSlide();
  }
  if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') {
    e.preventDefault();
    prevSlide();
  }
});

// 初始化加载第一页
loadPage(1);
