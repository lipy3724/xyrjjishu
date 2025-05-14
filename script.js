// 当文档加载完成后执行
document.addEventListener('DOMContentLoaded', function() {
    // 平滑滚动到锚点
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            
            const targetId = this.getAttribute('href');
            const targetElement = document.querySelector(targetId);
            
            if (targetElement) {
                window.scrollTo({
                    top: targetElement.offsetTop - 80, // 减去头部高度
                    behavior: 'smooth'
                });
                
                // 更新活动链接
                document.querySelectorAll('nav a').forEach(link => {
                    link.classList.remove('active');
                });
                this.classList.add('active');
            }
        });
    });
    
    // 根据滚动位置更新导航栏活动链接
    window.addEventListener('scroll', function() {
        const scrollPosition = window.scrollY + 100; // 添加偏移量以提前激活菜单
        
        document.querySelectorAll('section[id]').forEach(section => {
            const sectionTop = section.offsetTop;
            const sectionHeight = section.offsetHeight;
            const sectionId = section.getAttribute('id');
            
            if (scrollPosition >= sectionTop && scrollPosition < sectionTop + sectionHeight) {
                document.querySelectorAll('nav a').forEach(link => {
                    link.classList.remove('active');
                    if (link.getAttribute('href') === '#' + sectionId) {
                        link.classList.add('active');
                    }
                });
            }
        });
    });
    
    // FAQ 展开/折叠功能
    const faqItems = document.querySelectorAll('.faq-item');
    faqItems.forEach(item => {
        const title = item.querySelector('h3');
        if (title) {
            title.addEventListener('click', () => {
                // 获取所有FAQ项目内容
                const allContents = document.querySelectorAll('.faq-item p');
                // 当前FAQ项的内容
                const content = item.querySelector('p');
                
                // 切换当前FAQ项内容的显示状态
                if (content.style.maxHeight) {
                    content.style.maxHeight = null;
                    title.classList.remove('active');
                } else {
                    // 关闭所有其他FAQ项
                    allContents.forEach(c => {
                        c.style.maxHeight = null;
                        if (c.parentNode.querySelector('h3')) {
                            c.parentNode.querySelector('h3').classList.remove('active');
                        }
                    });
                    
                    // 打开当前FAQ项
                    content.style.maxHeight = content.scrollHeight + "px";
                    title.classList.add('active');
                }
            });
        }
    });
}); 