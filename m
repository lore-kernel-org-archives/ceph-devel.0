From: nokia ceph <nokiacephusers-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Recompiling source code - to find exact RPM
Date: Tue, 21 Mar 2017 19:56:13 +0530
Message-ID: <CALWuvY9kyuZgSHeLFwBw86J=tDzX-xc2FPvAQ8Qq__o3s_oodw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1296649818=="
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
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1296649818==
Content-Type: multipart/alternative; boundary=f4030437951c101edc054b3e6d8c

--f4030437951c101edc054b3e6d8c
Content-Type: text/plain; charset=UTF-8

Hello,

I made some changes in the below file on ceph kraken v11.2.0 source code as
per this article

https://github.com/ceph/ceph-ci/commit/wip-prune-past-intervals-kraken

..src/osd/PG.cc
..src/osd/PG.h

Is there any way to find which rpm got affected by these two files. I
believe it should be ceph-osd-11.2.0-0.el7.x86_64.rpm . Can you confirm
please ?

I failed to find it from the ceph.spec file.

Could anyone please guide me the right procedure to check this.

The main intention is that if we find the exact rpm affected by these
files, we can simply overwrite it with the old rpm.

Awaiting for comments.

Thanks

--f4030437951c101edc054b3e6d8c
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,<div><br></div><div>I made some changes in the below=
 file on ceph kraken v11.2.0 source code as per this article=C2=A0</div><di=
v><br></div><div><a href=3D"https://github.com/ceph/ceph-ci/commit/wip-prun=
e-past-intervals-kraken">https://github.com/ceph/ceph-ci/commit/wip-prune-p=
ast-intervals-kraken</a><br></div><div><br></div><div>..src/osd/PG.cc<br></=
div><div>..src/osd/PG.h<br></div><div><br></div><div>Is there any way to fi=
nd which rpm got affected by these two files. I believe it should be ceph-o=
sd-11.2.0-0.el7.x86_64.rpm . Can you confirm please ?</div><div><br></div><=
div>I failed to find it from the ceph.spec file.=C2=A0</div><div><br></div>=
<div>Could anyone please guide me the right procedure to check this.</div><=
div><br></div><div>The main intention is that if we find the exact rpm affe=
cted by these files, we can simply overwrite it with the old rpm. =C2=A0</d=
iv><div><br></div><div>Awaiting for comments.</div><div><br></div><div>Than=
ks</div><div><br></div></div>

--f4030437951c101edc054b3e6d8c--

--===============1296649818==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1296649818==--
