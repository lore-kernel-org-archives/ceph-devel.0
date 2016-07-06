From: Loic Dachary <loic@dachary.org>
Subject: ceph-mds jewel backports leak
Date: Wed, 6 Jul 2016 12:51:32 +0200
Message-ID: <577CE2B4.6010505@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:60007 "EHLO
	slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbcGFK6K (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Jul 2016 06:58:10 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	by slow1-d.mail.gandi.net (Postfix) with ESMTP id CBD484869D6
	for <ceph-devel@vger.kernel.org>; Wed,  6 Jul 2016 12:51:37 +0200 (CEST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi John,

While testing the CephFS jewel backports found in the jewel-backports b=
ranch, we ran into a memory leak that consistently happen:

http://pulpito.ceph.com/loic-2016-06-16_02:28:14-fs-jewel-backports---b=
asic-smithi/263842

and that is not present in the jewel branch

http://pulpito.ceph.com/loic-2016-06-28_23:43:39-fs-jewel---basic-smith=
i/282493/

Meaning one of the backports is doing something wrong. Or there is a ba=
ckport fixing the leak that is missing.

This one looks interesting to me

https://github.com/ceph/ceph/commit/37b7b09ee19ad64362c2faf63461353c03a=
36ada

There also are related to leaks but I'm not so sure.

https://github.com/ceph/ceph/commit/89f74c98ea43df46291c8bec890b3a75c7c=
e38b4
https://github.com/ceph/ceph/commit/4c52bf9ed47d52510536ebc34bd6c56adba=
1df53

If you have ideas on how to approach this and save random exploration t=
ime, it would be most welcome. If not, I'll get it eventually, no worri=
es :-)

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
