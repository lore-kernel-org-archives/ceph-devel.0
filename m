From: Loic Dachary <loic@dachary.org>
Subject: Re: arm64 qemu odd behavior
Date: Sun, 3 Apr 2016 23:30:32 +0200
Message-ID: <57018B78.10500@dachary.org>
References: <570188B5.3090102@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:43826 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751298AbcDCVah (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Apr 2016 17:30:37 -0400
In-Reply-To: <570188B5.3090102@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Palma <martin@palma.bz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

While compiling with 6 proc

$ cat /proc/cpuinfo
Processor	: AArch64 Processor rev 1 (aarch64)
processor	: 0
processor	: 1
processor	: 2
processor	: 3
processor	: 4
processor	: 5
=46eatures	: fp asimd evtstrm
CPU implementer	: 0x50
CPU architecture: AArch64
CPU variant	: 0x0
CPU part	: 0x000
CPU revision	: 1

Hardware	: linux,dummy-virt

I noticed via htop that only 5 of them are in use during make -j6. Proc=
essor 4 is not used. I'm not sure how / if that can be repeated.

On 03/04/2016 23:18, Loic Dachary wrote:
> Hi Martin,
>=20
> In your quest to understand why the arm64 qemu sometimes hangs when u=
sing as many processors as the host, maybe this will help.=20
>=20
> Today while watching an installation on an arm64 qemu machine, I noti=
ced it was stuck in setting up fontconfig. So I logged in the machine, =
CPU was not busy, no IOwait either, a lot of free RAM. The host was als=
o mostly idle. I straced the process and saw it moving. Unfortunately (=
 or maybe I was the cause of things starting to move on again ?) the fo=
nt regeneration finished while I was observing and things seem to be go=
ing at a normal speed now.=20
>=20
> Note that there is almost a 2 hours gap between Setting up fontconfig=
 and Regenerating fonts cache.
>=20
> Maybe the pattern we're sometime seeing (i.e. all blocked, not even p=
ossible to ssh) is another case of the same issue ?
>=20
> I'm starting to think we should bring this discussion to some arm64 m=
ailing list or IRC channel but I don't know any.
>=20
> 2016-04-03 19:17:34,858.858 DEBUG:teuthology.misc:Setting up libgdk-p=
ixbuf2.0-0:arm64 (2.30.7-0ubuntu1.2) ...
> 2016-04-03 19:17:35,057.057 DEBUG:teuthology.misc:Setting up libthai-=
data (0.1.20-3) ...
> 2016-04-03 19:17:35,183.183 DEBUG:teuthology.misc:Setting up libdatri=
e1:arm64 (0.2.8-1) ...
> 2016-04-03 19:17:35,350.350 DEBUG:teuthology.misc:Setting up libthai0=
:arm64 (0.1.20-3) ...
> 2016-04-03 19:17:35,546.546 DEBUG:teuthology.misc:Setting up fontconf=
ig (2.11.0-0ubuntu4.1) ...
> 2016-04-03 21:09:52,094.094 DEBUG:teuthology.misc:Regenerating fonts =
cache... done.
> 2016-04-03 21:09:52,136.136 DEBUG:teuthology.misc:Setting up libpango=
-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
> 2016-04-03 21:09:52,303.303 DEBUG:teuthology.misc:Setting up libgraph=
ite2-3:arm64 (1.3.6-1ubuntu0.14.04.1) ...
> 2016-04-03 21:09:52,465.465 DEBUG:teuthology.misc:Setting up libharfb=
uzz0b:arm64 (0.9.27-1ubuntu1) ...
> 2016-04-03 21:09:52,641.641 DEBUG:teuthology.misc:Setting up libpango=
ft2-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
> 2016-04-03 21:09:52,806.806 DEBUG:teuthology.misc:Setting up libpango=
cairo-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
> 2016-04-03 21:09:52,971.971 DEBUG:teuthology.misc:Setting up libxcomp=
osite1:arm64 (1:0.4.4-1) ...
>=20
> Cheers
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
