From: Loic Dachary <loic@dachary.org>
Subject: parted behavior change between 3.1 and 3.2
Date: Mon, 23 May 2016 09:41:32 +0200
Message-ID: <5742B42C.7050000@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:33080 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbcEWHli (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 May 2016 03:41:38 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Phillip Susi <psusi@ubuntu.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi Philip,

In the context of the Ceph ( http://ceph.com/ ) project, I'm trying to =
figure out why parted 3.2 fixes a problem that shows in 3.1 [1]. In a n=
utshell, calling partprobe sometime fails with "device busy" with 3.1 a=
nd when using 3.2 that never happens (all things are the same, only par=
ted changes). I took a look at the commits in http://git.savannah.gnu.o=
rg/cgit/parted.git/log/ but I didn't see a commit that would explain su=
ch a behavior change.

Any pointer or idea you may have would be greatly appreciated :-)

Cheers

[1] partprobe intermittent issues during ceph-disk prepare http://track=
er.ceph.com/issues/15176
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
