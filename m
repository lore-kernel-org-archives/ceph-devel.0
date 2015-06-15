From: =?UTF-8?B?5rGg5L+h5rO9?= <xmdxcxz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: ec pool history objects
Date: Mon, 15 Jun 2015 18:02:29 +0800
Message-ID: <CANE=7sXyJeD8Fx7fV3mP5-G=SCsY=M7j16BJnUo+kn4q3hu63g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1149173887=="
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
To: "ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1149173887==
Content-Type: multipart/alternative; boundary=047d7b5d30da3a825b05188b8e95

--047d7b5d30da3a825b05188b8e95
Content-Type: text/plain; charset=UTF-8

hi, all:

    when I use ec poll, I see there are some object history for object
xxxxxx.

[root@node3 2.1d6s2_head]# ll -R | grep xxxxxx
-rw-r--r--. 1 root root  65536 Jun 15 17:41 xxxxxx__head_610951D6__2_fe1_2
-rw-r--r--. 1 root root  65536 Jun 15 17:41 xxxxxx__head_610951D6__2_fe2_2
-rw-r--r--. 1 root root  65536 Jun 15 17:45
xxxxxx__head_610951D6__2_ffffffffffffffff_2

   I think this object is used for roll_back when not all shards have
written object to filestore. Is it right?

   If that, why not delete this history objects when all shards has written
object to filestore?

-- 
Regards,
xinze

--047d7b5d30da3a825b05188b8e95
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>hi, all:</div><div><br></div><div>=C2=A0 =C2=A0 =
when I use ec poll, I see there are some object history for object xxxxxx.<=
/div><div><br></div><div>[root@node3 2.1d6s2_head]# ll -R | grep xxxxxx</di=
v><div>-rw-r--r--. 1 root root =C2=A065536 Jun 15 17:41 xxxxxx__head_610951=
D6__2_fe1_2</div><div>-rw-r--r--. 1 root root =C2=A065536 Jun 15 17:41 xxxx=
xx__head_610951D6__2_fe2_2</div><div>-rw-r--r--. 1 root root =C2=A065536 Ju=
n 15 17:45 xxxxxx__head_610951D6__2_ffffffffffffffff_2</div></div><div><br>=
</div><div>=C2=A0 =C2=A0I think this object is used for roll_back when not =
all shards have written object to filestore. Is it right?</div><div><br></d=
iv><div>=C2=A0 =C2=A0If that, why not delete this history objects when all =
shards has written object to filestore?=C2=A0</div><div><br></div>-- <br><d=
iv class=3D"gmail_signature">Regards,<br>xinze</div>
</div>

--047d7b5d30da3a825b05188b8e95--

--===============1149173887==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1149173887==--
