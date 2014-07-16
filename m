From: Andrija Panic <andrija.panic-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: v0.80.4 Firefly released
Date: Wed, 16 Jul 2014 09:55:02 +0200
Message-ID: <CAMvtBPPr0MO5U_e=PEb6xqDUjQVhZLdh2oSD1tA0voVp_cu=Jw@mail.gmail.com>
References: <alpine.DEB.2.00.1407151634250.21336@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0445362230=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1407151634250.21336-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0445362230==
Content-Type: multipart/alternative; boundary=047d7b673b4870fb0f04fe4ad737

--047d7b673b4870fb0f04fe4ad737
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Sage,

can anyone validate, if there is still "bug" inside RPMs that does
automatic CEPH service restart after updating packages ?

We are instructed to first update/restart MONs, and after that OSD - but
that is impossible if we have MON+OSDs on same host...since the ceph is
automaticaly restarted with YUM/RPM, but NOT automaticaly restarted on
Ubuntu/Debian (as reported by some other list memeber...)

Thanks


On 16 July 2014 01:45, Sage Weil <sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org> wrote:

> This Firefly point release fixes an potential data corruption problem
> when ceph-osd daemons run on top of XFS and service Firefly librbd
> clients.  A recently added allocation hint that RBD utilizes triggers
> an XFS bug on some kernels (Linux 3.2, and likely others) that leads
> to data corruption and deep-scrub errors (and inconsistent PGs).  This
> release avoids the situation by disabling the allocation hint until we
> can validate which kernels are affected and/or are known to be safe to
> use the hint on.
>
> We recommend that all v0.80.x Firefly users urgently upgrade,
> especially if they are using RBD.
>
> Notable Changes
> ---------------
>
> * osd: disable XFS extsize hint by default (#8830, Samuel Just)
> * rgw: fix extra data pool default name (Yehuda Sadeh)
>
> For more detailed information, see:
>
>   http://ceph.com/docs/master/_downloads/v0.80.4.txt
>
> Getting Ceph
> ------------
>
> * Git at git://github.com/ceph/ceph.git
> * Tarball at http://ceph.com/download/ceph-0.80.4.tar.gz
> * For packages, see http://ceph.com/docs/master/install/get-packages
> * For ceph-deploy, see
> http://ceph.com/docs/master/install/install-ceph-deploy
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>



--=20

Andrija Pani=C4=87
--------------------------------------
  http://admintweets.com
--------------------------------------

--047d7b673b4870fb0f04fe4ad737
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Sage,<div><br></div><div>can anyone validate, if there =
is still &quot;bug&quot; inside RPMs that does automatic CEPH service resta=
rt after updating packages ?</div><div><br></div><div>We are instructed to =
first update/restart MONs, and after that OSD - but that is impossible if w=
e have MON+OSDs on same host...since the ceph is automaticaly restarted wit=
h YUM/RPM, but NOT automaticaly restarted on Ubuntu/Debian (as reported by =
some other list memeber...)</div>
<div><br></div><div>Thanks<br></div></div><div class=3D"gmail_extra"><br><b=
r><div class=3D"gmail_quote">On 16 July 2014 01:45, Sage Weil <span dir=3D"=
ltr">&lt;<a href=3D"mailto:sage-4GqslpFJ+cxBDgjK7y7TUQ@public.gmane.org" target=3D"_blank">sage@inktank=
.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">This Firefly point release fixes an potentia=
l data corruption problem<br>
when ceph-osd daemons run on top of XFS and service Firefly librbd<br>
clients. =C2=A0A recently added allocation hint that RBD utilizes triggers<=
br>
an XFS bug on some kernels (Linux 3.2, and likely others) that leads<br>
to data corruption and deep-scrub errors (and inconsistent PGs). =C2=A0This=
<br>
release avoids the situation by disabling the allocation hint until we<br>
can validate which kernels are affected and/or are known to be safe to<br>
use the hint on.<br>
<br>
We recommend that all v0.80.x Firefly users urgently upgrade,<br>
especially if they are using RBD.<br>
<br>
Notable Changes<br>
---------------<br>
<br>
* osd: disable XFS extsize hint by default (#8830, Samuel Just)<br>
* rgw: fix extra data pool default name (Yehuda Sadeh)<br>
<br>
For more detailed information, see:<br>
<br>
=C2=A0 <a href=3D"http://ceph.com/docs/master/_downloads/v0.80.4.txt" targe=
t=3D"_blank">http://ceph.com/docs/master/_downloads/v0.80.4.txt</a><br>
<br>
Getting Ceph<br>
------------<br>
<br>
* Git at git://<a href=3D"http://github.com/ceph/ceph.git" target=3D"_blank=
">github.com/ceph/ceph.git</a><br>
* Tarball at <a href=3D"http://ceph.com/download/ceph-0.80.4.tar.gz" target=
=3D"_blank">http://ceph.com/download/ceph-0.80.4.tar.gz</a><br>
* For packages, see <a href=3D"http://ceph.com/docs/master/install/get-pack=
ages" target=3D"_blank">http://ceph.com/docs/master/install/get-packages</a=
><br>
* For ceph-deploy, see <a href=3D"http://ceph.com/docs/master/install/insta=
ll-ceph-deploy" target=3D"_blank">http://ceph.com/docs/master/install/insta=
ll-ceph-deploy</a><br>
<br>
_______________________________________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" target=
=3D"_blank">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com</a><br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr"><br><div>Andrija Pani=C4=87</div><div>--------------------------------=
------</div><div>=C2=A0 <a href=3D"http://admintweets.com" target=3D"_blank=
">http://admintweets.com</a></div>
<div>--------------------------------------</div></div>
</div>

--047d7b673b4870fb0f04fe4ad737--

--===============0445362230==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0445362230==--
