From: Randy Orr <randy.orr-9C+QFJrrmEysTnJN9+BGXg@public.gmane.org>
Subject: Re: Can we drop ubuntu 14.04 (trusty) for kraken and
	lumninous?
Date: Fri, 11 Nov 2016 14:10:03 -0600
Message-ID: <CAPojG3Jt4PRZzK14eNr0K5rXYjv3ZmJpGV_X6N1jDzEL6o5dYw@mail.gmail.com>
References: <alpine.DEB.2.11.1611111837410.29579@piezo.us.to>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0780454275=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.11.1611111837410.29579-ie3vfNGmdjePKud3HExfWg@public.gmane.org>
List-Unsubscribe: <http://lists.ceph.com/options.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ceph.com/pipermail/ceph-users-ceph.com/>
List-Post: <mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
List-Help: <mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=help>
List-Subscribe: <http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com>,
	<mailto:ceph-users-request-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org?subject=subscribe>
Errors-To: ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
Sender: "ceph-users" <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
To: Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org, ceph-maintainers-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org

--===============0780454275==
Content-Type: multipart/alternative; boundary=001a113ecc7259ddba05410c1318

--001a113ecc7259ddba05410c1318
Content-Type: text/plain; charset=UTF-8

Hi,

I would prefer option 1 please. It wouldn't be the end of the world if
14.04 support went away, but definitely inconvenient. EOL for Ubuntu 14.04
is April 2019 - I would expect to see many people still running it for
quite some time.

Thanks,
Randy

On Fri, Nov 11, 2016 at 12:43 PM, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:

> Currently the distros we use for upstream testing are
>
>  centos 7.x
>  ubuntu 16.04 (xenial)
>  ubuntu 14.04 (trusty)
>
> We also do some basic testing for Debian 8 and Fedora (some old version).
>
> Jewel was the first release that had native systemd and full xenial
> support, so it's helpful to have both 14.04 and 16.04 supported to provide
> an upgrade path.  But I think we can safely drop 14.04 now for kraken and
> luminous.  Our options are
>
> 1) keep testing on xenial and trusty, and keep building packages for both
>
> 2) stop testing trusty, but still build packages
>
> 3) stop testing or building for trusty
>
> Preferences?
> sage
>
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

--001a113ecc7259ddba05410c1318
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I would prefer option 1 please. It =
wouldn&#39;t be the end of the world if 14.04 support went away, but defini=
tely inconvenient. EOL for Ubuntu 14.04 is April 2019 - I would expect to s=
ee many people still running it for quite some time.=C2=A0</div><div><br></=
div><div>Thanks,</div><div>Randy</div></div><div class=3D"gmail_extra"><br>=
<div class=3D"gmail_quote">On Fri, Nov 11, 2016 at 12:43 PM, Sage Weil <spa=
n dir=3D"ltr">&lt;<a href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" target=3D"_blank">swe=
il-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Curre=
ntly the distros we use for upstream testing are<br>
<br>
=C2=A0centos 7.x<br>
=C2=A0ubuntu 16.04 (xenial)<br>
=C2=A0ubuntu 14.04 (trusty)<br>
<br>
We also do some basic testing for Debian 8 and Fedora (some old version).<b=
r>
<br>
Jewel was the first release that had native systemd and full xenial<br>
support, so it&#39;s helpful to have both 14.04 and 16.04 supported to prov=
ide<br>
an upgrade path.=C2=A0 But I think we can safely drop 14.04 now for kraken =
and<br>
luminous.=C2=A0 Our options are<br>
<br>
1) keep testing on xenial and trusty, and keep building packages for both<b=
r>
<br>
2) stop testing trusty, but still build packages<br>
<br>
3) stop testing or building for trusty<br>
<br>
Preferences?<br>
sage<br>
<br>
______________________________<wbr>_________________<br>
ceph-users mailing list<br>
<a href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><=
br>
<a href=3D"http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com" rel=3D"n=
oreferrer" target=3D"_blank">http://lists.ceph.com/<wbr>listinfo.cgi/ceph-u=
sers-ceph.<wbr>com</a><br>
</blockquote></div><br></div>

--001a113ecc7259ddba05410c1318--

--===============0780454275==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0780454275==--
