From: Brian Kroth <bpkroth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: dropping old distros: el6, precise 12.04,
 debian wheezy?
Date: Thu, 30 Jul 2015 10:58:12 -0500
Message-ID: <20150730155812.GE15736@gmail.com>
References: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0383945168=="
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
Cc: ceph-devel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ceph-users-Qp0mS5GaXlQ@public.gmane.org
List-Id: ceph-devel.vger.kernel.org


--===============0383945168==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uCPdOCrL+PnN2Vxy"
Content-Disposition: inline


--uCPdOCrL+PnN2Vxy
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sage Weil <sweil-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> 2015-07-30 06:54:
>As time marches on it becomes increasingly difficult to maintain proper
>builds and packages for older distros.  For example, as we make the
>systemd transition, maintaining the kludgey sysvinit and udev support for
>centos6/rhel6 is a pain in the butt and eats up time and energy to
>maintain and test that we could be spending doing more useful work.
>
>"Dropping" them would mean:
>
> - Ongoing development on master (and future versions like infernalis and
>jewel) would not be tested on these distros.
>
> - We would stop building upstream release packages on ceph.com for new
>releases.
>
> - We would probably continue building hammer and firefly packages for
>future bugfix point releases.
>
> - The downstream distros would probably continue to package them, but the
>burden would be on them.  For example, if Ubuntu wanted to ship Jewel on
>precise 12.04, they could, but they'd probably need to futz with the
>packaging and/or build environment to make it work.
>
>So... given that, I'd like to gauge user interest in these old distros.
>Specifically,
>
> CentOS6 / RHEL6
> Ubuntu precise 12.04
> Debian wheezy
>
>Would anyone miss them?
>
>In particular, dropping these three would mean we could drop sysvinit
>entirely and focus on systemd (and continue maintaining the existing
>upstart files for just a bit longer).  That would be a relief.  (The
>sysvinit files wouldn't go away in the source tree, but we wouldn't worry
>about packaging and testing them properly.)
>
>Thanks!
>sage

As I still haven't heard or seen about any upstream distros for Debian=20
Jessie (see also [1]), I am still running Debian Wheezy and as that is=20
supposed to be supported for another ~4 years by Debian, it would be=20
very nice if there were at least stability and security fixes backported=20
for the upstream ceph package repositories for that platform.

Additionally, I'll note that I'm personally likely to continue to use=20
sysvinit so long as I still can, even when I am able to make the switch=20
to Jessie.

Thanks,
Brian

[1] <http://www.spinics.net/lists/ceph-users/msg19959.html>

--uCPdOCrL+PnN2Vxy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlW6SZEACgkQdtkBin+QuSChrwCgjxjgnUAnZDdnYRP0fnfYEs8q
KmYAn3tXn1b9b4V0Lku9Um6mIy5wm8xY
=yw4t
-----END PGP SIGNATURE-----

--uCPdOCrL+PnN2Vxy--

--===============0383945168==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
ceph-users mailing list
ceph-users-idqoXFIVOFJgJs9I8MT0rw@public.gmane.org
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--===============0383945168==--
