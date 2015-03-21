From: shylesh kumar <shylesh.mohan-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: How does crush selects different osds using hash(pg)
	in diferent iterations
Date: Sat, 21 Mar 2015 23:16:46 +0530
Message-ID: <CAMxOGo2V+Fn+g3z5qc7oYK40wU_XJuScAdfetQrkjp6izeNULw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0895455722=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0895455722==
Content-Type: multipart/alternative; boundary=f46d043c7cec4634de0511d00440

--f46d043c7cec4634de0511d00440
Content-Type: text/plain; charset=UTF-8

Hi ,

I was going through this simplified crush algorithm given in ceph website.

def crush(pg):
   all_osds = ['osd.0', 'osd.1', 'osd.2', ...]
   result = []
   # size is the number of copies; primary+replicas
   while len(result) < size:
   --> *r = hash(pg)*
       chosen = all_osds[ r % len(all_osds) ]
       if chosen in result:
           # OSD can be picked only once
           continue
       result.append(chosen)
   return result

10:24 PM (51 minutes ago)
In the line where *r = hash(pg)* , will it gives the same hash value in
every iteration ?
if that is the case we always endup choosing the same osd from the list
or will the pg number be used as seed for the hashing so that r value
changes in the next iteration.

Am I missing something really basic ??
Can somebody please provide me some pointers ?



-- 
Thanks,
Shylesh Kumar M

--f46d043c7cec4634de0511d00440
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi ,<br><br></div>I was going through this simplified=
 crush algorithm given in ceph website.<br><br><div><pre><span>def</span> <=
span>crush</span><span>(</span><span>pg</span><span>):</span>
   <span>all_osds</span> <span>=3D</span> <span>[</span><span>&#39;osd.0&#3=
9;</span><span>,</span> <span>&#39;osd.1&#39;</span><span>,</span> <span>&#=
39;osd.2&#39;</span><span>,</span> <span>...</span><span>]</span>
   <span>result</span> <span>=3D</span> <span>[]</span>
   <span># size is the number of copies; primary+replicas</span>
   <span>while</span> <span>len</span><span>(</span><span>result</span><spa=
n>)</span> <span>&lt;</span> <span>size</span><span>:</span>
   --&gt; <b><span>r</span> <span>=3D</span> <span>hash</span><span>(</span=
><span>pg</span><span>)</span></b>
       <span>chosen</span> <span>=3D</span> <span>all_osds</span><span>[</s=
pan> <span>r</span> <span>%</span> <span>len</span><span>(</span><span>all_=
osds</span><span>)</span> <span>]</span>
       <span>if</span> <span>chosen</span> <span>in</span> <span>result</sp=
an><span>:</span>
           <span># OSD can be picked only once</span>
           <span>continue</span>
       <span>result</span><span>.</span><span>append</span><span>(</span><s=
pan>chosen</span><span>)</span>
   <span>return</span> <span>result</span><span class=3D""><font color=3D"#=
888888">
</font></span></pre></div><div class=3D""><div id=3D":1mk" class=3D"" tabin=
dex=3D"0">10:24 PM (51 minutes ago)</div><div id=3D":1mk" class=3D"" tabind=
ex=3D"0">In the line where <b>r =3D hash(pg)</b> , will it gives the same h=
ash value in every iteration ?<br></div><div id=3D":1mk" class=3D"" tabinde=
x=3D"0">if that is the case we always endup choosing the same osd from the =
list <br></div><div id=3D":1mk" class=3D"" tabindex=3D"0">or will the pg nu=
mber be used as seed for the hashing so that r value changes in the next it=
eration.<br><br></div><div id=3D":1mk" class=3D"" tabindex=3D"0">Am I missi=
ng something really basic ??<br></div><div id=3D":1mk" class=3D"" tabindex=
=3D"0">Can somebody please provide me some pointers ?<br><br></div><div id=
=3D":1mk" class=3D"" tabindex=3D"0"><br></div><div id=3D":1mk" class=3D"" t=
abindex=3D"0"><br></div></div><div><div>-- <br><div class=3D"gmail_signatur=
e">Thanks,<br>Shylesh Kumar M<br>=C2=A0</div>
</div></div></div>

--f46d043c7cec4634de0511d00440--

--===============0895455722==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0895455722==--
