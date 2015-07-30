From: =?utf-8?Q?Jan_=E2=80=9CZviratko=E2=80=9D_Schermer?=
	<zviratko-9HAugxcXKGzk1uMJSBkQmQ@public.gmane.org>
Subject: Re: dropping old distros: el6, precise 12.04,
	debian wheezy?
Date: Thu, 30 Jul 2015 16:29:51 +0200
Message-ID: <4B37EB35-008A-41DA-85DC-315314373A59@zviratko.net>
References: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3073\))
Content-Type: multipart/mixed; boundary="===============0820688511=="
Return-path: <ceph-users-bounces-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org>
In-Reply-To: <alpine.DEB.2.00.1507300645130.22099-vIokxiIdD2AQNTJnQDzGJqxOck334EZe@public.gmane.org>
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
Cc: ceph-devel <ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============0820688511==
Content-Type: multipart/alternative; boundary="Apple-Mail=_0BED9142-FAE8-48AC-8CBB-30487854B6B4"


--Apple-Mail=_0BED9142-FAE8-48AC-8CBB-30487854B6B4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

I understand your reasons, but dropping support for LTS release like =
this
is not right.

You should lege artis support every distribution the LTS release could =
have
ever been installed on - that=E2=80=99s what the LTS label is for and =
what we rely on
once we build a project on top of it

CentOS 6 in particular is still very widely used and even installed, =
enterprise
apps rely on it to this day. Someone out there is surely maintaining =
their LTS
Ceph release on this distro and not having tested packages will hurt =
badly.
We don=E2=80=99t want out project managers selecting EMC SAN over CEPH =
SDS
because of such uncertainty, and you should benchmark yourself to those
vendors, maybe...

Every developer loves dropping support and concentrating on the bleeding
edge interesting stuff but that=E2=80=99s not how it should work.

Just my 2 cents...

Jan

> On 30 Jul 2015, at 15:54, Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
>=20
> As time marches on it becomes increasingly difficult to maintain =
proper=20
> builds and packages for older distros.  For example, as we make the=20
> systemd transition, maintaining the kludgey sysvinit and udev support =
for=20
> centos6/rhel6 is a pain in the butt and eats up time and energy to=20
> maintain and test that we could be spending doing more useful work.
>=20
> "Dropping" them would mean:
>=20
> - Ongoing development on master (and future versions like infernalis =
and=20
> jewel) would not be tested on these distros.
>=20
> - We would stop building upstream release packages on ceph.com for new=20=

> releases.
>=20
> - We would probably continue building hammer and firefly packages for=20=

> future bugfix point releases.
>=20
> - The downstream distros would probably continue to package them, but =
the=20
> burden would be on them.  For example, if Ubuntu wanted to ship Jewel =
on=20
> precise 12.04, they could, but they'd probably need to futz with the=20=

> packaging and/or build environment to make it work.
>=20
> So... given that, I'd like to gauge user interest in these old =
distros. =20
> Specifically,
>=20
> CentOS6 / RHEL6
> Ubuntu precise 12.04
> Debian wheezy
>=20
> Would anyone miss them?
>=20
> In particular, dropping these three would mean we could drop sysvinit=20=

> entirely and focus on systemd (and continue maintaining the existing=20=

> upstart files for just a bit longer).  That would be a relief.  (The=20=

> sysvinit files wouldn't go away in the source tree, but we wouldn't =
worry=20
> about packaging and testing them properly.)
>=20
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com


--Apple-Mail=_0BED9142-FAE8-48AC-8CBB-30487854B6B4
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=utf-8

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;" class=3D""><div class=3D"">I =
understand your reasons, but dropping support for LTS release like =
this</div><div class=3D"">is not right.</div><div class=3D""><br =
class=3D""></div><div class=3D"">You should <i class=3D"">lege =
artis</i>&nbsp;support every distribution the LTS release could =
have</div><div class=3D"">ever been installed on - that=E2=80=99s what =
the LTS label is for and what we rely on</div><div class=3D"">once we =
build a project on top of it</div><div class=3D""><br =
class=3D""></div><div class=3D"">CentOS 6 in particular is still very =
widely used and even installed, enterprise</div><div class=3D"">apps =
rely on it to this day. Someone out there is surely maintaining their =
LTS</div><div class=3D"">Ceph release on this distro and not having =
tested packages will hurt badly.</div><div class=3D"">We don=E2=80=99t =
want out project managers selecting EMC SAN over CEPH SDS</div><div =
class=3D"">because of such uncertainty, and you should benchmark =
yourself to those</div><div class=3D"">vendors, maybe...</div><div =
class=3D""><br class=3D""></div><div class=3D"">Every developer loves =
dropping support and concentrating on the bleeding</div><div =
class=3D"">edge interesting stuff but that=E2=80=99s not how it should =
work.</div><div class=3D""><br class=3D""></div><div class=3D"">Just my =
2 cents...</div><div class=3D""><br class=3D""></div><div =
class=3D"">Jan</div><div class=3D""><br class=3D""><blockquote =
type=3D"cite" class=3D"">On 30 Jul 2015, at 15:54, Sage Weil &lt;<a =
href=3D"mailto:sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org" class=3D"">sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org</a>&gt; =
wrote:<br class=3D""><br class=3D"">As time marches on it becomes =
increasingly difficult to maintain proper&nbsp;<br class=3D"">builds and =
packages for older distros. &nbsp;For example, as we make the&nbsp;<br =
class=3D"">systemd transition, maintaining the kludgey sysvinit and udev =
support for&nbsp;<br class=3D"">centos6/rhel6 is a pain in the butt and =
eats up time and energy to&nbsp;<br class=3D"">maintain and test that we =
could be spending doing more useful work.<br class=3D""><br =
class=3D"">"Dropping" them would mean:<br class=3D""><br class=3D"">- =
Ongoing development on master (and future versions like infernalis =
and&nbsp;<br class=3D"">jewel) would not be tested on these distros.<br =
class=3D""><br class=3D"">- We would stop building upstream release =
packages on <a href=3D"http://ceph.com" class=3D"">ceph.com</a> for =
new&nbsp;<br class=3D"">releases.<br class=3D""><br class=3D"">- We =
would probably continue building hammer and firefly packages =
for&nbsp;<br class=3D"">future bugfix point releases.<br class=3D""><br =
class=3D"">- The downstream distros would probably continue to package =
them, but the&nbsp;<br class=3D"">burden would be on them. &nbsp;For =
example, if Ubuntu wanted to ship Jewel on&nbsp;<br class=3D"">precise =
12.04, they could, but they'd probably need to futz with the&nbsp;<br =
class=3D"">packaging and/or build environment to make it work.<br =
class=3D""><br class=3D"">So... given that, I'd like to gauge user =
interest in these old distros. &nbsp;<br class=3D"">Specifically,<br =
class=3D""><br class=3D"">CentOS6 / RHEL6<br class=3D"">Ubuntu precise =
12.04<br class=3D"">Debian wheezy<br class=3D""><br class=3D"">Would =
anyone miss them?<br class=3D""><br class=3D"">In particular, dropping =
these three would mean we could drop sysvinit&nbsp;<br class=3D"">entirely=
 and focus on systemd (and continue maintaining the existing&nbsp;<br =
class=3D"">upstart files for just a bit longer). &nbsp;That would be a =
relief. &nbsp;(The&nbsp;<br class=3D"">sysvinit files wouldn't go away =
in the source tree, but we wouldn't worry&nbsp;<br class=3D"">about =
packaging and testing them properly.)<br class=3D""><br =
class=3D"">Thanks!<br class=3D"">sage<br =
class=3D"">_______________________________________________<br =
class=3D"">ceph-users mailing list<br class=3D""><a =
href=3D"mailto:ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org" =
class=3D"">ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org</a><br =
class=3D"">http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com<br =
class=3D""></blockquote><br class=3D""></div></body></html>=

--Apple-Mail=_0BED9142-FAE8-48AC-8CBB-30487854B6B4--

--===============0820688511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0820688511==--
