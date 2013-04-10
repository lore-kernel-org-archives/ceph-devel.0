From: dawn li <defence986-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: pool-info error in version 0.60
Date: Wed, 10 Apr 2013 09:51:24 +0800
Message-ID: <CAMVugGyeNXSW_C3H7PvP5bB4X+i2vXVgHob6BQmkQ2s-7SR10Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0484665057=="
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
To: ceph-users <ceph-users-Qp0mS5GaXlQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0484665057==
Content-Type: multipart/alternative; boundary=047d7b414c2e4a683c04d9f7e80e

--047d7b414c2e4a683c04d9f7e80e
Content-Type: text/plain; charset=ISO-8859-1

Hello everyone,
    I have used the latest version 0.60 ceph in the ceph-server and the
latest linux kernel 3.8.6 in the ceph-client.
Howerver, the problem  still exists in my ceph client. As follows.
    I have mounted the ceph path to my ceph client with the command "mount
-t ceph * *".
The allocation size is normal when viewed through the command "df -h",
however,
 the allocation size become very large and the capacity size become too
small
when viewed through the command "pool-info" in the tool "virsh".
    Is it the bug of the ceph? Any help would be grateful. Thanks for your
help.

--047d7b414c2e4a683c04d9f7e80e
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><span style=3D"font-family:arial,sans-serif;font-size=
:14px">Hello everyone,</span></div><span style=3D"font-family:arial,sans-se=
rif;font-size:14px">=A0 =A0 I have used the latest version 0.60 ceph in the=
 ceph-server and the latest linux kernel 3.8.6 in the ceph-client.=A0</span=
><div>
<span style=3D"font-family:arial,sans-serif;font-size:14px">Howerver, the</=
span><span style=3D"font-family:arial,sans-serif;font-size:14px">=A0problem=
 =A0still exists in my ceph client. As follows.</span><div><div style=3D"fo=
nt-family:arial,sans-serif;font-size:14px">
=A0 =A0 I have mounted the ceph path to my ceph client with the command &qu=
ot;mount -t ceph * *&quot;.=A0</div><div style=3D"font-family:arial,sans-se=
rif;font-size:14px">The allocation size is normal when viewed through the c=
ommand &quot;df -h&quot;, however,</div>
<div style=3D"font-family:arial,sans-serif;font-size:14px">=A0the allocatio=
n size become very large and the capacity size become too small=A0</div><di=
v style=3D"font-family:arial,sans-serif;font-size:14px">when viewed through=
 the command &quot;pool-info&quot; in the tool &quot;virsh&quot;.</div>
<div style=3D"font-family:arial,sans-serif;font-size:14px">=A0 =A0 Is it th=
e bug of the ceph? Any help would be grateful. Thanks for your help.</div><=
/div></div></div>

--047d7b414c2e4a683c04d9f7e80e--

--===============0484665057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0484665057==--
