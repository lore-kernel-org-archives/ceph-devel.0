From: =?utf-8?Q?Jan_=E2=80=9CZviratko=E2=80=9D_Schermer?=
	<zviratko@zviratko.net>
Subject: Re: [ceph-users] dropping old distros: el6, precise 12.04, debian wheezy?
Date: Thu, 30 Jul 2015 16:30:32 +0200
Message-ID: <515A1511-3ED8-481F-8E71-C5CC8332F225@zviratko.net>
References: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>
Mime-Version: 1.0 (Mac OS X Mail 9.0 \(3073\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35615 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbbG3Oae convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jul 2015 10:30:34 -0400
Received: by wibxm9 with SMTP id xm9so247484374wib.0
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jul 2015 07:30:33 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, ceph-users@ceph.com

I understand your reasons, but dropping support for LTS release like th=
is
is not right.

You should lege artis support every distribution the LTS release could =
have
ever been installed on - that=E2=80=99s what the LTS label is for and w=
hat we rely on
once we build a project on top of it

CentOS 6 in particular is still very widely used and even installed, en=
terprise
apps rely on it to this day. Someone out there is surely maintaining th=
eir LTS
Ceph release on this distro and not having tested packages will hurt ba=
dly.
We don=E2=80=99t want out project managers selecting EMC SAN over CEPH =
SDS
because of such uncertainty, and you should benchmark yourself to those
vendors, maybe...

Every developer loves dropping support and concentrating on the bleedin=
g
edge interesting stuff but that=E2=80=99s not how it should work.

Just my 2 cents...

Jan

> On 30 Jul 2015, at 15:54, Sage Weil <sweil@redhat.com> wrote:
>=20
> As time marches on it becomes increasingly difficult to maintain prop=
er=20
> builds and packages for older distros.  For example, as we make the=20
> systemd transition, maintaining the kludgey sysvinit and udev support=
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
> - We would stop building upstream release packages on ceph.com for ne=
w=20
> releases.
>=20
> - We would probably continue building hammer and firefly packages for=
=20
> future bugfix point releases.
>=20
> - The downstream distros would probably continue to package them, but=
 the=20
> burden would be on them.  For example, if Ubuntu wanted to ship Jewel=
 on=20
> precise 12.04, they could, but they'd probably need to futz with the=20
> packaging and/or build environment to make it work.
>=20
> So... given that, I'd like to gauge user interest in these old distro=
s. =20
> Specifically,
>=20
> CentOS6 / RHEL6
> Ubuntu precise 12.04
> Debian wheezy
>=20
> Would anyone miss them?
>=20
> In particular, dropping these three would mean we could drop sysvinit=
=20
> entirely and focus on systemd (and continue maintaining the existing=20
> upstart files for just a bit longer).  That would be a relief.  (The=20
> sysvinit files wouldn't go away in the source tree, but we wouldn't w=
orry=20
> about packaging and testing them properly.)
>=20
> Thanks!
> sage
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
