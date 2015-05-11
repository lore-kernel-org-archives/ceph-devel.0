From: Owen Synge <osynge@suse.com>
Subject: Re: autodetecting init system.
Date: Mon, 11 May 2015 19:28:03 +0200
Message-ID: <5550E6A3.8000404@suse.com>
References: <5550D903.8000802@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:57995 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752384AbbEKR3U (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 11 May 2015 13:29:20 -0400
In-Reply-To: <5550D903.8000802@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org



On 05/11/2015 06:29 PM, Owen Synge wrote:
> Dear all,
>=20
> Many init systems are used in linux now. Some ceph code needs to know
> the init system. (I must admit I have not looked into Solaris, MacOS =
and
> BSD and probably should have)
>=20
> It would be nice to have one function that detects the init system
>=20
> Since the init system can be specified in ceph and ceph-deploy
> explicitly it seems to be its reasonable to fail clearly to detect in=
it
> system.
>=20
> I see 4 ways I can see to detect init system.
>=20
> (A) Check pid 1.
> (B) Use a database of OS to init mapping / compile time.
> (C) look for init manipulation tools and infure the init system from =
tools.
>=20
> Comments:
> ~~~~~~~~
>=20
> (A1) systmd can be detected easily with.
>=20
>  grep -qs systemd /proc/1/comm


A further comment is how will this work in chroot / containers?

>=20
> (A2) With init scripts such as its hard to know what the init system.
>=20
> (B1) For operating systems like RHEL, SLE, CENTOS, Fedora and scienti=
fic
> linux this works well.
>=20
> (B2) FOr operating systems like newer debian and ubuntu releases more
> than one init system can be installed and used on the OS, so making a
> database / doing it at compile time are not practical on all OS's
>=20
> (C1) This is fairly reliable.
>=20
> (C2) sysV tools have compatibility scripts / programs on other platfo=
rms
> so if you use a points system for each init system helper script you =
can
> infure systemd over sysV if sytemctrl exists for example.
>=20
> So to summarise this:
> ~~~~~~~~~~~~~~~~~~~~
>=20
> (1) No one system is perfect in all cases.
> (2) Combined these systesm can provide reliable init system detection=
=2E
>=20
> My proposed approach.
> ~~~~~~~~~~~~~~~~~~~~
>=20
> (I) Use all three approaches where each approach can provide and answ=
er,
> or fail to provide an answer.
>=20
> (II) Should any approaches disagree -> fail to detect init system.
>=20
> (III) Should all approaches agree -> then return init system.
>=20
> (III) Should no approaches provide an init system -> fail to return i=
nit
> system.
>=20
> Comments
> ~~~~~~~~
>=20
> This multi layered and comparing way of doing init systems may seem
> complete overkill, or maybe its useful.
>=20
> What do you guys think?
>=20
> Best regards
>=20
> Owen
>=20
>=20
>=20
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
