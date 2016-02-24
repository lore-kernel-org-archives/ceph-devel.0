From: Loic Dachary <loic@dachary.org>
Subject: osd dm-crypt key management, seconde partie
Date: Wed, 24 Feb 2016 19:13:46 +0700
Message-ID: <56CD9E7A.2050901@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:47988 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbcBXMNz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Feb 2016 07:13:55 -0500
Received: from mfilter47-d.gandi.net (mfilter47-d.gandi.net [217.70.178.178])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id E58D817209C
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 13:13:52 +0100 (CET)
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
	by mfilter47-d.gandi.net (mfilter47-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id e-Ojtt0TICXh for <ceph-devel@vger.kernel.org>;
	Wed, 24 Feb 2016 13:13:51 +0100 (CET)
Received: from [10.9.0.6] (197.ip-167-114-246.eu [167.114.246.197])
	(Authenticated sender: loic@dachary.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 888DD1720BA
	for <ceph-devel@vger.kernel.org>; Wed, 24 Feb 2016 13:13:49 +0100 (CET)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

A first implementation[1] of the key management scheme[2] was completed=
 today (it passes tests, integration and make check). While work is don=
e to add tests to verify legacy key storage support, it would be great =
to get reviews and feedback. There is little time before the jewel merg=
e window closes: now would be a perfect time to catch blockers :-)

Cheers

[1] https://github.com/ceph/ceph/pull/7552/files=20
[2] http://pad.ceph.com/p/osd-key-management

P.S. The previous mail thread on that topic was : "osd dm-crypt key man=
agement, part... deux?", hence the "seconde partie" instead, which carr=
ies the idea that there won't be a third part (yes, French has that kin=
d of words : https://fr.wiktionary.org/wiki/second, 2.).

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
