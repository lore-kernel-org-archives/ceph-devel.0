From: Alexandre DERUMIER <aderumier@odiso.com>
Subject: Re: [ceph-users] dropping old distros: el6, precise 12.04, debian
 wheezy?
Date: Fri, 31 Jul 2015 09:21:48 +0200 (CEST)
Message-ID: <2085249323.24865068.1438327308865.JavaMail.zimbra@oxygem.tv>
References: <alpine.DEB.2.00.1507300645130.22099@cobra.newdream.net> <20150730155812.GE15736@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mailpro.odiso.net ([89.248.209.98]:57174 "EHLO
	mailpro.odiso.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750827AbbGaHVv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 31 Jul 2015 03:21:51 -0400
In-Reply-To: <20150730155812.GE15736@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Brian Kroth <bpkroth@gmail.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, ceph-users <ceph-users@ceph.com>

>>As I still haven't heard or seen about any upstream distros for Debia=
n=20
>>Jessie (see also [1]),

Gitbuilder is already done for jessie

http://gitbuilder.ceph.com/ceph-deb-jessie-x86_64-basic/

@Sage : Don't known if something is blocking to release package officia=
lly ?



----- Mail original -----
De: "Brian Kroth" <bpkroth@gmail.com>
=C3=80: "Sage Weil" <sweil@redhat.com>
Cc: "ceph-devel" <ceph-devel@vger.kernel.org>, "ceph-users" <ceph-users=
@ceph.com>
Envoy=C3=A9: Jeudi 30 Juillet 2015 17:58:12
Objet: Re: [ceph-users] dropping old distros: el6, precise 12.04, debia=
n wheezy?

Sage Weil <sweil@redhat.com> 2015-07-30 06:54:=20
>As time marches on it becomes increasingly difficult to maintain prope=
r=20
>builds and packages for older distros. For example, as we make the=20
>systemd transition, maintaining the kludgey sysvinit and udev support =
for=20
>centos6/rhel6 is a pain in the butt and eats up time and energy to=20
>maintain and test that we could be spending doing more useful work.=20
>=20
>"Dropping" them would mean:=20
>=20
> - Ongoing development on master (and future versions like infernalis =
and=20
>jewel) would not be tested on these distros.=20
>=20
> - We would stop building upstream release packages on ceph.com for ne=
w=20
>releases.=20
>=20
> - We would probably continue building hammer and firefly packages for=
=20
>future bugfix point releases.=20
>=20
> - The downstream distros would probably continue to package them, but=
 the=20
>burden would be on them. For example, if Ubuntu wanted to ship Jewel o=
n=20
>precise 12.04, they could, but they'd probably need to futz with the=20
>packaging and/or build environment to make it work.=20
>=20
>So... given that, I'd like to gauge user interest in these old distros=
=2E=20
>Specifically,=20
>=20
> CentOS6 / RHEL6=20
> Ubuntu precise 12.04=20
> Debian wheezy=20
>=20
>Would anyone miss them?=20
>=20
>In particular, dropping these three would mean we could drop sysvinit=20
>entirely and focus on systemd (and continue maintaining the existing=20
>upstart files for just a bit longer). That would be a relief. (The=20
>sysvinit files wouldn't go away in the source tree, but we wouldn't wo=
rry=20
>about packaging and testing them properly.)=20
>=20
>Thanks!=20
>sage=20

As I still haven't heard or seen about any upstream distros for Debian=20
Jessie (see also [1]), I am still running Debian Wheezy and as that is=20
supposed to be supported for another ~4 years by Debian, it would be=20
very nice if there were at least stability and security fixes backporte=
d=20
for the upstream ceph package repositories for that platform.=20

Additionally, I'll note that I'm personally likely to continue to use=20
sysvinit so long as I still can, even when I am able to make the switch=
=20
to Jessie.=20

Thanks,=20
Brian=20

[1] <http://www.spinics.net/lists/ceph-users/msg19959.html>=20

_______________________________________________=20
ceph-users mailing list=20
ceph-users@lists.ceph.com=20
http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com=20
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
