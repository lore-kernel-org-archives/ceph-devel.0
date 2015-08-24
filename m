From: Vickey Singh <vickey.singh22693-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Opensource plugin for pulling out cluster recovery and
	client IO metric
Date: Mon, 24 Aug 2015 23:56:34 +0300
Message-ID: <CALL4jwNUZCeKkxSiEZ5Q5rRTckNjk2nqL237AbaGG=6MTKq89w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0693336485=="
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

--===============0693336485==
Content-Type: multipart/alternative; boundary=047d7bd755c452cea8051e14da1c

--047d7bd755c452cea8051e14da1c
Content-Type: text/plain; charset=UTF-8

Hello Ceph Geeks

I am planning to develop a python plugin that pulls out cluster *recovery
IO* and *client IO* operation metrics , that can be further used with
collectd.

*For example , i need to take out these values*

*recovery io 814 MB/s, 101 objects/s*
*client io 85475 kB/s rd, 1430 kB/s wr, 32 op/s*


Could you please help me in understanding how *ceph -s*  and *ceph -w*
 outputs *prints cluster recovery IO and client IO information*.
Where this information is coming from. *Is it coming from perf dump* ? If
yes then which section of perf dump output is should focus on. If not then
how can i get this values.

I tried *ceph --admin-daemon /var/run/ceph/ceph-osd.48.asok perf dump* ,
but it generates hell lot of information and i am confused which section of
output should i use.


Please help

Thanks in advance

--047d7bd755c452cea8051e14da1c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div style=3D"font-size:13px">Hello Ceph Geeks<br></div><d=
iv style=3D"font-size:13px"><br></div><div style=3D"font-size:13px">I am pl=
anning to develop a python plugin that pulls out cluster=C2=A0<b>recovery I=
O</b>=C2=A0and=C2=A0<b>client IO</b>=C2=A0operation metrics , that can be f=
urther used with collectd.</div><div style=3D"font-size:13px"><br></div><di=
v style=3D"font-size:13px"><b>For example , i need to take out these values=
</b></div><div style=3D"font-size:13px"><br></div><div style=3D"font-size:1=
3px"><b>recovery io 814 MB/s, 101 objects/s</b></div><div style=3D"font-siz=
e:13px"><b>client io 85475 kB/s rd, 1430 kB/s wr, 32 op/s</b></div><div sty=
le=3D"font-size:13px"><br></div><div style=3D"font-size:13px"><br></div><di=
v style=3D"font-size:13px">Could you please help me in understanding how=C2=
=A0<b>ceph -s</b>=C2=A0=C2=A0and=C2=A0<b>ceph -w</b>=C2=A0outputs=C2=A0<b>p=
rints cluster recovery IO and client IO information</b>.=C2=A0</div><div st=
yle=3D"font-size:13px">Where this information is coming from.=C2=A0<b>Is it=
 coming from perf dump</b>=C2=A0? If yes then which section of perf dump ou=
tput is should focus on. If not then how can i get this values.</div><div s=
tyle=3D"font-size:13px"><br></div><div style=3D"font-size:13px">I tried=C2=
=A0<b>ceph --admin-daemon /var/run/ceph/ceph-osd.48.asok perf dump</b>=C2=
=A0, but it generates hell lot of information and i am confused which secti=
on of output should i use.</div><div style=3D"font-size:13px"><br></div><di=
v style=3D"font-size:13px"><br></div><div style=3D"font-size:13px">Please h=
elp=C2=A0</div><div style=3D"font-size:13px"><br></div><div style=3D"font-s=
ize:13px">Thanks in advance</div></div>

--047d7bd755c452cea8051e14da1c--

--===============0693336485==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0693336485==--
