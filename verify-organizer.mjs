import fs from 'node:fs';
import assert from 'node:assert/strict';
const path = process.argv[2] ?? 'build/stl/77-inch-industrial-shelves-300mm-deep-organizer.stl';
const b = fs.readFileSync(path);
const n = b.readUInt32LE(80);
assert.equal(b.length,84+50*n,'binary STL length');
const vertices=[], triangles=[], lookup=new Map(), edges=new Map();
const lo=[Infinity,Infinity,Infinity], hi=[-Infinity,-Infinity,-Infinity];
for(let i=0;i<n;i++) {
 const t=[];
 for(let j=0;j<3;j++) {
  const p=[0,1,2].map(k=>b.readFloatLE(84+i*50+12+j*12+k*4));
  p.forEach((x,k)=>{lo[k]=Math.min(lo[k],x);hi[k]=Math.max(hi[k],x)});
  const key=p.map(x=>Math.round(x*10000)).join(',');
  if(!lookup.has(key)){lookup.set(key,vertices.length);vertices.push(p)}
  t.push(lookup.get(key));
 }
 assert.equal(new Set(t).size,3,'nondegenerate triangle');triangles.push(t);
 for(let j=0;j<3;j++) {
  const a=t[j],c=t[(j+1)%3],key=a<c?a+','+c:c+','+a;
  const entry=edges.get(key)??{count:0,balance:0,faces:[]};
  entry.count++;entry.balance+=a<c?1:-1;entry.faces.push(i);edges.set(key,entry);
 }
}
const parent=triangles.map((_,i)=>i);
function find(i){while(parent[i]!==i){parent[i]=parent[parent[i]];i=parent[i]}return i}
for(const e of edges.values()) {
 assert.equal(e.count,2,'watertight: two faces per edge');
 assert.equal(e.balance,0,'consistent winding');
 parent[find(e.faces[0])]=find(e.faces[1]);
}
assert.equal(new Set(parent.map((_,i)=>find(i))).size,1,'single connected solid');
const sub=(a,b)=>a.map((x,i)=>x-b[i]);
const dot=(a,b)=>a.reduce((s,x,i)=>s+x*b[i],0);
const cross=(a,b)=>[a[1]*b[2]-a[2]*b[1],a[2]*b[0]-a[0]*b[2],a[0]*b[1]-a[1]*b[0]];
const c=Math.SQRT1_2, d=[0,c,-c], y0=(200-(127+107.95)*c)/2,z0=10+107.95*c;
function firstHit(origin,dir) {
 let nearest=Infinity;
 for(const t of triangles) {
  const [a,b,c]=t.map(i=>vertices[i]),e1=sub(b,a),e2=sub(c,a),h=cross(dir,e2),det=dot(e1,h);
  if(Math.abs(det)<1e-10)continue;
  const inv=1/det,s=sub(origin,a),u=dot(s,h)*inv;if(u < -1e-6 || u>1.000001)continue;
  const q=cross(s,e1),v=dot(dir,q)*inv;if(v < -1e-6 || u+v>1.000001)continue;
  const dist=dot(e2,q)*inv;if(dist>1e-5)nearest=Math.min(nearest,dist);
 }
 return nearest;
}
let rays=0;
function depthAt(u,v,depth) {
 const point=[u,y0+v*c-d[1],z0+v*c-d[2]];
 const hit=firstHit(point,d)-1;
 assert.ok(Math.abs(hit-depth)<0.025,'pocket/face depth '+[u,v,hit,depth]);rays++;
}
// Probe center and inner rim of every opening, then adjacent solid material.
for(let col=0;col<4;col++)for(let row=0;row<5;row++){
 const u=26.175+25.4*col,v=12.7+25.4*row;
 for(const [du,dv] of [[0,0],[6.2,0],[-6.2,0],[0,6.2],[0,-6.2]])depthAt(u+du,v+dv,101.6);
 depthAt(u+6.5,v,0);depthAt(u,v+6.5,0);
}
for(let col=0;col<3;col++)for(let row=0;row<2;row++){
 const u=115.075+57.15*col+25.4,v=9.525+57.15*row+25.4;
 for(const [du,dv] of [[0,0],[25.3,25.3],[-25.3,25.3],[25.3,-25.3],[-25.3,-25.3]])depthAt(u+du,v+dv,101.6);
 depthAt(u+25.5,v,0);depthAt(u,v+25.5,0);
}
for(let k=0;k<3;k++){assert.ok(Math.abs(lo[k]-[0,0,-50][k])<0.01);assert.ok(Math.abs(hi[k]-[300,200,10+(127+107.95)*c][k])<0.01)}
// Mounting gap is clear, rear wall starts at y=130 and front wall at y=92.
assert.ok(Math.abs(firstHit([75,120,-5],[0,1,0])-10)<0.01);
assert.ok(Math.abs(firstHit([75,120,-5],[0,-1,0])-6)<0.01);
console.log(JSON.stringify({pass:true,triangles:n,components:1,watertight:true,bounds:[lo,hi],penHoles:20,squarePockets:6,pocketDepth:101.6,measurementRays:rays,railGap:16},null,2));
