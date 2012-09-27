From: Sage Weil <sage@inktank.com>
Subject: Re: RPMs
Date: Thu, 27 Sep 2012 14:08:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1209271405360.13352@cobra.newdream.net>
References: <alpine.DEB.2.00.1209271344000.13352@cobra.newdream.net> <5064BE11.50909@widodh.nl> <CALk=J71ygxP80RcBJKsSEZBOmQcpWsXpcXFMi6t=GBUVfYqPwQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="557981400-1147126608-1348780080=:13352"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:43620 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2I0VIA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 27 Sep 2012 17:08:00 -0400
In-Reply-To: <CALk=J71ygxP80RcBJKsSEZBOmQcpWsXpcXFMi6t=GBUVfYqPwQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marino Pascual <mpascual@heartflow.com>
Cc: Wido den Hollander <wido@widodh.nl>, ceph-devel@vger.kernel.org, gary.lowell@inktank.com

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--557981400-1147126608-1348780080=:13352
Content-Type: TEXT/PLAIN; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On Thu, 27 Sep 2012, Marino Pascual wrote:
> Add the EPEL repo and you can find it there.
> su -c 'rpm -Uvhhttp://download.fedoraproject.org/pub/epel/6/i386/epel-r=
elease-6-7.noarch.r
> pm'

Gary, we should probably build these with --with-nss --without-cryptopp=20
passed to configure, since libnss3 is in the base distribution and=20
libcrypo++ is not.  That's what we're doing now for debian and ubuntu.

sage

>=20
> On Thu, Sep 27, 2012 at 1:58 PM, Wido den Hollander <wido@widodh.nl> wr=
ote:
>       On 09/27/2012 10:47 PM, Sage Weil wrote:
>             For v0.52 we built some RPMs for the first time.
>             =A0The release machinery
>             here is brand new (thanks, Gary!), so if you run
>             into problems (or don't!)
>             with the repos as they are currently set up, let us
>             know.
>=20
>=20
> The link in the docs is dead: ceph.com/docs/master/install/rpm/
>=20
> su -c ?rpm -Uvh
> http://ceph.com/rpms/el6/x86_64/ceph-release-1-0.noarch.rpm?
>=20
> The correct RPM URL is:
> http://ceph.com/rpms/el6/x86_64/ceph-release-1-0.el6.noarch.rpm
>=20
> Same goes for the FC17.
>=20
> After fixing that I tried to install Ceph on CentOS 6.3 with:
>=20
> $ yum install ceph
>=20
> That resulted in:
>=20
> --> Running transaction check
> ---> Package ceph.x86_64 0:0.52-6.el6 will be installed
> --> Processing Dependency: libcryptopp.so.6()(64bit) for package:
> ceph-0.52-6.el6.x86_64
> ---> Package libcephfs1.x86_64 0:0.52-6.el6 will be installed
> --> Processing Dependency: libcryptopp.so.6()(64bit) for package:
> libcephfs1-0.52-6.el6.x86_64
> ---> Package librados2.x86_64 0:0.52-6.el6 will be installed
> --> Processing Dependency: libcryptopp.so.6()(64bit) for package:
> librados2-0.52-6.el6.x86_64
> ---> Package librbd1.x86_64 0:0.52-6.el6 will be installed
> --> Processing Dependency: libcryptopp.so.6()(64bit) for package:
> librbd1-0.52-6.el6.x86_64
> --> Finished Dependency Resolution
> Error: Package: libcephfs1-0.52-6.el6.x86_64 (ceph)
> =A0 =A0 =A0 =A0 =A0 =A0Requires: libcryptopp.so.6()(64bit)
> Error: Package: ceph-0.52-6.el6.x86_64 (ceph)
> =A0 =A0 =A0 =A0 =A0 =A0Requires: libcryptopp.so.6()(64bit)
> Error: Package: librados2-0.52-6.el6.x86_64 (ceph)
> =A0 =A0 =A0 =A0 =A0 =A0Requires: libcryptopp.so.6()(64bit)
> Error: Package: librbd1-0.52-6.el6.x86_64 (ceph)
> =A0 =A0 =A0 =A0 =A0 =A0Requires: libcryptopp.so.6()(64bit)
> =A0You could try using --skip-broken to work around the problem
> =A0You could try running: rpm -Va --nofiles --nodigest
>=20
> This should be part of the cryptopp package I think? But this package
> isn't available on my CentOS machine.
>=20
> Any suggestions?
>=20
> Wido
>=20
>       We started with CentOS6/RHEL6 and Fedora 17 for x86_64.
>       =A0Please let us
>       know what other distributions/architectures you are
>       interested in.
>=20
>       Thanks!
>       sage
>=20
>       --
>       To unsubscribe from this list: send the line "unsubscribe
>       ceph-devel" in
>       the body of a message to majordomo@vger.kernel.org
>       More majordomo info at
>       =A0http://vger.kernel.org/majordomo-info.html
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>=20
>=20
>=20
>=20
--557981400-1147126608-1348780080=:13352--
