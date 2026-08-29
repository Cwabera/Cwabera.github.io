
document.addEventListener('DOMContentLoaded',()=>{
 const grid=document.querySelector('#repo-grid'),status=document.querySelector('#repo-status');
 if(!grid)return;
 let repos=[],filter='all';
 const esc=s=>String(s??'').replace(/[&<>"']/g,m=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#039;'}[m]));
 function render(){
  const list=repos.filter(r=>filter==='all'||(filter==='other'?!['JavaScript','Python','HTML','CSS'].includes(r.language):r.language===filter));
  grid.innerHTML=list.map((r,i)=>`<article class="project reveal show"><div class="project-body">
  <span class="project-index">${String(i+1).padStart(2,'0')} / ${esc(r.language||'OTHER')}</span>
  <h3>${esc(r.name)}</h3><p>${esc(r.description||'Public engineering repository.')}</p>
  <div class="tags"><span>★ ${r.stargazers_count||0}</span><span>⑂ ${r.forks_count||0}</span><span>${new Date(r.updated_at).toLocaleDateString()}</span></div>
  <a class="link" href="${r.html_url}" target="_blank" rel="noreferrer">OPEN REPOSITORY ↗</a>
  </div></article>`).join('')||'<div class="repo-status">No repositories match this filter.</div>';
 }
 document.querySelectorAll('.filter').forEach(b=>b.addEventListener('click',()=>{
  document.querySelectorAll('.filter').forEach(x=>x.classList.remove('active'));b.classList.add('active');filter=b.dataset.filter;render();
 }));
 fetch('https://api.github.com/users/Cwabera/repos?per_page=100&sort=updated')
 .then(r=>{if(!r.ok)throw Error();return r.json()})
 .then(j=>{repos=j;status.textContent=`${repos.length} public repositories · live GitHub index`;render()})
 .catch(()=>{status.textContent='Live repository feed unavailable';grid.innerHTML='<div class="repo-status">Visit <a class="link" href="https://github.com/Cwabera?tab=repositories" target="_blank" rel="noreferrer">GitHub ↗</a> to inspect the source.</div>'});
});
