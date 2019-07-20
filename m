From: Ajitha Robert <ajitharobert01-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Failed to get omap key when mirroring of image is
 enabled
Date: Sun, 21 Jul 2019 00:13:37 +0530
Message-ID: <CAEbG6hGeN7T_iRpnT=s8L2DSwTsTV2dm8L1MaKeavxRej222OA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6986338832387843173=="
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
To: ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org, ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============6986338832387843173==
Content-Type: multipart/alternative; boundary="0000000000003fd3ec058e213993"

--0000000000003fd3ec058e213993
Content-Type: text/plain; charset="UTF-8"

I  have two queries,

1) I have a rbd mirroring setup with two primary and secondary clusters as
peers and I have enabled image mode.., In this i creates rbd image enabled
with journaling.

But whenever i enable mirroring on the image,  I m getting error in osd.log

Primary osd log: failed to get omap key, error retrieving image id for
global id

Secondary osd log: error retrieving image id for global id

2)
I have deployed ceph using ceph-ansible. Is it possible to give the SAN
multipath device in osd devices??. I m using stable3.0 and luminous

I have given
devices

/dev/mapper/
I m getting symlink issue
How to rectify it.
Environment:

OS (e.g. from /etc/os-release): debian stretch
Ansible version (e.g. ansible-playbook --version):2.4.0
ceph-ansible version (e.g. git head or tag or stable branch):3.0
Ceph version (e.g. ceph -v): luminous(12.2)

--0000000000003fd3ec058e213993
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div align=3D"left" dir=3D"auto"><font face=3D"sans-serif=
"><span style=3D"font-size:12.8px">I=C2=A0</span></font> have two queries,<=
p dir=3D"ltr">1) I have a rbd mirroring setup with two primary and secondar=
y clusters as peers and I have enabled image mode.., In this i creates rbd =
image enabled with journaling.</p><p dir=3D"ltr">But whenever i enable mirr=
oring on the image,=C2=A0 I m getting error in osd.log</p>
<p dir=3D"ltr">Primary osd log: failed to get omap key, error retrieving im=
age id for global id</p>
<p dir=3D"ltr">Secondary osd log: error retrieving image id for global id<b=
r></p>
<p dir=3D"ltr">2) <br>
I have deployed ceph using ceph-ansible. Is it possible to give the SAN mul=
tipath device in osd devices??. I m using stable3.0 and luminous</p>
<p dir=3D"ltr">I have given<br>
devices</p>
<p dir=3D"ltr">/dev/mapper/<br>
I m getting symlink issue<br>
How to rectify it.<br>
Environment:</p>
<p dir=3D"ltr">OS (e.g. from /etc/os-release): debian stretch<br>
Ansible version (e.g. ansible-playbook --version):2.4.0<br>
ceph-ansible version (e.g. git head or tag or stable branch):3.0<br>
Ceph version (e.g. ceph -v): luminous(12.2)</p></div></div>

--0000000000003fd3ec058e213993--

--===============6986338832387843173==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============6986338832387843173==--
