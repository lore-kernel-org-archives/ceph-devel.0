From: Vickey Singh <vickey.singh22693-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Math behind : : OSD count vs OSD process vs OSD ports
Date: Mon, 16 Nov 2015 17:55:47 +0200
Message-ID: <CALL4jwNCYhOX5Frn94+17iubYBzp4e3HoByRwhbWxBbqyd6HMw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1499565040=="
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
To: "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============1499565040==
Content-Type: multipart/alternative; boundary=001a1130d26a5045db0524aa716f

--001a1130d26a5045db0524aa716f
Content-Type: text/plain; charset=UTF-8

Hello Community

Need your help in understanding this.

I have the below node, which is hosting 60 physical disks, running 1 OSD
per disk so total 60 Ceph OSD daemons

*[root@node01 ~]# service ceph status | grep -i osd | grep -i running | wc
-l*
*60*
*[root@node01 ~]#*

However if i check OSD processes it shows that there are 120 OSD process
are running.

*[root@node01 ~]# ps -ef | grep -i osd | grep -v grep | wc -l*
*120*
*[root@node01 ~]#*

*Question 1 : why its 120 processes ? , i it should be 60 (because of 60
OSD on the system)*
My guess : is this because of multithreading ?

Now if i check the number of ports used by OSD its comming out to be 240

*[root@node01 ~]# netstat -plunt | grep -i osd | wc -l*
*240*
*[root@node01 ~]#*

*Question 2 : Now why its 240 ports ? It should be 60 ( because of 60 OSD
on the system)*

If i grep a specific OSD port , its shows 2 ports are occupied by OSD
process 260519

*[root@node01 ~]# netstat -plunt | grep -i osd | grep -i 6819*
*tcp        0      0 10.101.50.1:6819 <http://10.101.50.1:6819>
 0.0.0.0:*               LISTEN      260519/ceph-osd*
*tcp        0      0 10.102.50.1:6819 <http://10.102.50.1:6819>
 0.0.0.0:*               LISTEN      260519/ceph-osd*
*[root@node01 ~]#*

*Question 3 : Now based on the scenario 2 it should be 4 ( so 60 OSD x 4
ports = 240 ports in total)*

I have two public and cluster network configured in ceph.conf , is all
these because of two different networks ?

*I would really appreciate if some knowledgeable person share his
understanding with me.*

Thank you in advance.

--001a1130d26a5045db0524aa716f
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello Community</div><div><br></div><div>Need your he=
lp in understanding this.</div><div><br></div><div>I have the below node, w=
hich is hosting 60 physical disks, running 1 OSD per disk so total 60 Ceph =
OSD daemons</div><div><br></div><div><b><font color=3D"#0000ff">[root@node0=
1 ~]# service ceph status | grep -i osd | grep -i running | wc -l</font></b=
></div><div><b><font color=3D"#0000ff">60</font></b></div><div><b><font col=
or=3D"#0000ff">[root@node01 ~]#</font></b></div><div><br></div><div>However=
 if i check OSD processes it shows that there are 120 OSD process are runni=
ng.</div><div><br></div><div><font color=3D"#0000ff"><b>[root@node01 ~]# ps=
 -ef | grep -i osd | grep -v grep | wc -l</b></font></div><div><font color=
=3D"#0000ff"><b>120</b></font></div><div><font color=3D"#0000ff"><b>[root@n=
ode01 ~]#</b></font></div><div><br></div><div><font color=3D"#ff0000"><b>Qu=
estion 1 : why its 120 processes ? , i it should be 60 (because of 60 OSD o=
n the system)</b></font></div><div>My guess : is this because of multithrea=
ding ?</div><div><br></div><div>Now if i check the number of ports used by =
OSD its comming out to be 240</div><div><br></div><div><font color=3D"#0000=
ff"><b>[root@node01 ~]# netstat -plunt | grep -i osd | wc -l</b></font></di=
v><div><font color=3D"#0000ff"><b>240</b></font></div><div><font color=3D"#=
0000ff"><b>[root@node01 ~]#</b></font></div><div><br></div><div><font color=
=3D"#ff0000"><b>Question 2 : Now why its 240 ports ? It should be 60 ( beca=
use of 60 OSD on the system)</b></font></div><div><br></div><div>If i grep =
a specific OSD port , its shows 2 ports are occupied by OSD process 260519<=
/div><div><br></div><div><font color=3D"#0000ff"><b>[root@node01 ~]# netsta=
t -plunt | grep -i osd | grep -i 6819</b></font></div><div><font color=3D"#=
0000ff"><b>tcp =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A00 <a href=
=3D"http://10.101.50.1:6819">10.101.50.1:6819</a> =C2=A0 =C2=A0 =C2=A0 =C2=
=A00.0.0.0:* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LISTEN =C2=A0=
 =C2=A0 =C2=A0260519/ceph-osd</b></font></div><div><font color=3D"#0000ff">=
<b>tcp =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0 =C2=A0 =C2=A00 <a href=3D"http:/=
/10.102.50.1:6819">10.102.50.1:6819</a> =C2=A0 =C2=A0 =C2=A0 =C2=A00.0.0.0:=
* =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 LISTEN =C2=A0 =C2=A0 =C2=
=A0260519/ceph-osd</b></font></div><div><font color=3D"#0000ff"><b>[root@no=
de01 ~]#</b></font></div><div><br></div><div><font color=3D"#ff0000"><b>Que=
stion 3 : Now based on the scenario 2 it should be 4 ( so 60 OSD x 4 ports =
=3D 240 ports in total)</b></font></div><div><br></div><div>I have two publ=
ic and cluster network configured in ceph.conf , is all these because of tw=
o different networks ?</div><div><br></div><div><b>I would really appreciat=
e if some knowledgeable person share his understanding with me.</b></div><d=
iv><br></div><div>Thank you in advance.</div><div><br></div><div><br></div>=
</div>

--001a1130d26a5045db0524aa716f--

--===============1499565040==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1499565040==--
