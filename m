From: Loic Dachary <loic@dachary.org>
Subject: arm64 qemu odd behavior
Date: Sun, 3 Apr 2016 23:18:45 +0200
Message-ID: <570188B5.3090102@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:43059 "EHLO
	relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbcDCVSu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 3 Apr 2016 17:18:50 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Palma <martin@palma.bz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Martin,

In your quest to understand why the arm64 qemu sometimes hangs when usi=
ng as many processors as the host, maybe this will help.=20

Today while watching an installation on an arm64 qemu machine, I notice=
d it was stuck in setting up fontconfig. So I logged in the machine, CP=
U was not busy, no IOwait either, a lot of free RAM. The host was also =
mostly idle. I straced the process and saw it moving. Unfortunately ( o=
r maybe I was the cause of things starting to move on again ?) the font=
 regeneration finished while I was observing and things seem to be goin=
g at a normal speed now.=20

Note that there is almost a 2 hours gap between Setting up fontconfig a=
nd Regenerating fonts cache.

Maybe the pattern we're sometime seeing (i.e. all blocked, not even pos=
sible to ssh) is another case of the same issue ?

I'm starting to think we should bring this discussion to some arm64 mai=
ling list or IRC channel but I don't know any.

2016-04-03 19:17:34,858.858 DEBUG:teuthology.misc:Setting up libgdk-pix=
buf2.0-0:arm64 (2.30.7-0ubuntu1.2) ...
2016-04-03 19:17:35,057.057 DEBUG:teuthology.misc:Setting up libthai-da=
ta (0.1.20-3) ...
2016-04-03 19:17:35,183.183 DEBUG:teuthology.misc:Setting up libdatrie1=
:arm64 (0.2.8-1) ...
2016-04-03 19:17:35,350.350 DEBUG:teuthology.misc:Setting up libthai0:a=
rm64 (0.1.20-3) ...
2016-04-03 19:17:35,546.546 DEBUG:teuthology.misc:Setting up fontconfig=
 (2.11.0-0ubuntu4.1) ...
2016-04-03 21:09:52,094.094 DEBUG:teuthology.misc:Regenerating fonts ca=
che... done.
2016-04-03 21:09:52,136.136 DEBUG:teuthology.misc:Setting up libpango-1=
=2E0-0:arm64 (1.36.3-1ubuntu1.1) ...
2016-04-03 21:09:52,303.303 DEBUG:teuthology.misc:Setting up libgraphit=
e2-3:arm64 (1.3.6-1ubuntu0.14.04.1) ...
2016-04-03 21:09:52,465.465 DEBUG:teuthology.misc:Setting up libharfbuz=
z0b:arm64 (0.9.27-1ubuntu1) ...
2016-04-03 21:09:52,641.641 DEBUG:teuthology.misc:Setting up libpangoft=
2-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
2016-04-03 21:09:52,806.806 DEBUG:teuthology.misc:Setting up libpangoca=
iro-1.0-0:arm64 (1.36.3-1ubuntu1.1) ...
2016-04-03 21:09:52,971.971 DEBUG:teuthology.misc:Setting up libxcompos=
ite1:arm64 (1:0.4.4-1) ...

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
