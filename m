From: Bazli Karim <bazli.karim-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Ceph mds laggy and failed to assert session in
 function mds/journal.cc line 1303
Date: Fri, 25 Apr 2014 15:08:50 +0800
Message-ID: <CA+9xv=OkN=_wqVtTXuT=e3UWd755S8hbjCtjum1hSVzJ2ZedGA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1355051600=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
To: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1355051600==
Content-Type: multipart/alternative; boundary=f46d0442685a3d698504f7d8a3a0

--f46d0442685a3d698504f7d8a3a0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Dear Ceph-devel, ceph-users,



I am currently facing issue with my ceph mds server. Ceph-mds daemon does
not want to bring up back.

I tried running that manually with ceph-mds =E2=80=93i mon01 =E2=80=93d but=
 it got aborted
and the log shows that it stucks at failed assert(session) line 1303 in
mds/journal.cc.



Can someone shed some light in this issue?

I am running ceph version 0.72.2 (a913ded2ff138aefb8cb84d347d72164099cfd60)



Let me know if I need to send more logs.



Regards,

Bazli

--f46d0442685a3d698504f7d8a3a0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">

<p class=3D"MsoNormal">Dear Ceph-devel, ceph-users,</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">I am currently facing issue with my ceph mds server.=
 Ceph-mds
daemon does not want to bring up back.</p>

<p class=3D"MsoNormal">I tried running that manually with ceph-mds =E2=80=
=93i mon01 =E2=80=93d but it got aborted and the log shows that it stucks a=
t failed assert(session) line 1303 in mds/journal.cc.</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">Can someone shed some light in this issue?</p><p cla=
ss=3D"MsoNormal">I am running ceph version 0.72.2
(a913ded2ff138aefb8cb84d347d72164099cfd60)</p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">Let me know if I need to send more logs.<br></p>

<p class=3D"MsoNormal">=C2=A0</p>

<p class=3D"MsoNormal">Regards,</p>

<p class=3D"MsoNormal">Bazli</p>

</div>

--f46d0442685a3d698504f7d8a3a0--

--===============1355051600==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1355051600==--
