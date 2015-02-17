From: Irek Fasikhov <malmyzh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Ceph Dumpling/Firefly/Hammer SSD/Memstore
 performance comparison
Date: Tue, 17 Feb 2015 22:07:46 +0400
Message-ID: <CAF-rypz52Tork-AHCUoTh8xpOQ+ojYW1F20HqvQL65jGCwoR2Q@mail.gmail.com>
References: <54E37C3D.5030702@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1420084966=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <54E37C3D.5030702-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" <ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Id: ceph-devel.vger.kernel.org

--===============1420084966==
Content-Type: multipart/alternative; boundary=089e01419d80b14557050f4c95cf

--089e01419d80b14557050f4c95cf
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Mark, very very good!

2015-02-17 20:37 GMT+03:00 Mark Nelson <mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>:

> Hi All,
>
> I wrote up a short document describing some tests I ran recently to look
> at how SSD backed OSD performance has changed across our LTS releases. Th=
is
> is just looking at RADOS performance and not RBD or RGW.  It also doesn't
> offer any real explanations regarding the results.  It's just a first hig=
h
> level step toward understanding some of the behaviors folks on the mailin=
g
> list have reported over the last couple of releases.  I hope you find it
> useful.
>
> Mark
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>
>


--=20
=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=
=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=
=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=B2=D0=B8=D1=87
=D0=9C=D0=BE=D0=B1.: +79229045757

--089e01419d80b14557050f4c95cf
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Mark, very very good!</div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">2015-02-17 20:37 GMT+03:00 Mark Nelson <span dir=
=3D"ltr">&lt;<a href=3D"mailto:mnelson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">mnelso=
n@redhat.com</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi All,<br>
<br>
I wrote up a short document describing some tests I ran recently to look at=
 how SSD backed OSD performance has changed across our LTS releases. This i=
s just looking at RADOS performance and not RBD or RGW.=C2=A0 It also doesn=
&#39;t offer any real explanations regarding the results.=C2=A0 It&#39;s ju=
st a first high level step toward understanding some of the behaviors folks=
 on the mailing list have reported over the last couple of releases.=C2=A0 =
I hope you find it useful.<span class=3D"HOEnZb"><font color=3D"#888888"><b=
r>
<br>
Mark<br>
</font></span><br>_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
<br></blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div cla=
ss=3D"gmail_signature"><div dir=3D"ltr">=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=
=B5=D0=BD=D0=B8=D0=B5=D0=BC, =D0=A4=D0=B0=D1=81=D0=B8=D1=85=D0=BE=D0=B2 =D0=
=98=D1=80=D0=B5=D0=BA =D0=9D=D1=83=D1=80=D0=B3=D0=B0=D1=8F=D0=B7=D0=BE=D0=
=B2=D0=B8=D1=87<div>=D0=9C=D0=BE=D0=B1.: +79229045757</div></div></div>
</div>

--089e01419d80b14557050f4c95cf--

--===============1420084966==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============1420084966==--
