From: agung Laksono <agung.smarts-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: How do I restart node that I've killed in development
	mode
Date: Wed, 12 Oct 2016 13:54:22 +0700
Message-ID: <CAJ+86MPR6Ux6RW_JyX4vmAWjMygCbV6SHf1YuSJnzrmUFBeYCQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1519622655=="
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
To: Ceph Users <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>, ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Brad Hubbard <bhubbard-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1519622655==
Content-Type: multipart/alternative; boundary=001a114462fa913e2d053ea57679

--001a114462fa913e2d053ea57679
Content-Type: text/plain; charset=UTF-8

Hi Ceph Users,

I deploy development cluster using vstart with 3 MONs and 3 OSDs.
On my experiment, Kill one of the monitor nodes by its pid. like this:

  $ kill -SIGSEGV 27557

After a new monitor leader is chosen, I would like to re-run the monitor
that I've killed in the previous step. How do I do this?


Thanks

-- 
Cheers,

Agung Laksono

--001a114462fa913e2d053ea57679
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Ceph Users,<div><br></div><div>I deploy development clu=
ster using vstart=C2=A0with 3 MONs and 3 OSDs.=C2=A0</div><div>On my experi=
ment, Kill one of the monitor nodes by its=C2=A0pid. like this:</div><div><=
br></div><div>=C2=A0 $ kill -SIGSEGV 27557</div><div><br></div><div>After a=
 new monitor=C2=A0leader is chosen, I would like to re-run the monitor</div=
><div>that I&#39;ve killed in the previous step. How do I do this?</div><di=
v><br></div><div><br></div><div>Thanks =C2=A0=C2=A0</div><div><div><br></di=
v>-- <br><div class=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"l=
tr"><div>Cheers,</div><div><br></div>Agung Laksono<br><br></div></div></div=
></div>
</div></div>

--001a114462fa913e2d053ea57679--

--===============1519622655==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1519622655==--
