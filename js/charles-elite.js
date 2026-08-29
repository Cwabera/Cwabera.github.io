
document.addEventListener('DOMContentLoaded',()=>{
 const page=location.pathname.split('/').pop()||'index.html';
 document.querySelectorAll('.nav a').forEach(a=>{
   if(a.getAttribute('href')===page)a.classList.add('active');
 });
 const observer=new IntersectionObserver(entries=>entries.forEach(e=>{
   if(e.isIntersecting){e.target.classList.add('show');observer.unobserve(e.target)}
 }),{threshold:.1});
 document.querySelectorAll('.reveal').forEach(x=>observer.observe(x));

 const portrait=document.querySelector('[data-portrait]');
 if(portrait){
   const candidates=[
    'assets/charles-portrait.png','assets/charles-portrait.jpg','assets/charles-portrait.jpeg',
    'assets/charles-wabera.png','assets/charles-wabera.jpg','assets/charles.png','assets/portrait.png'
   ];
   (async()=>{
     for(const src of candidates){
       try{const r=await fetch(src,{method:'HEAD'});if(r.ok){portrait.src=src;return}}catch(_){}
     }
   })();
 }
});
