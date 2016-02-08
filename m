From: Loic Dachary <loic@dachary.org>
Subject: hammer v0.94.7 & jewel
Date: Mon, 8 Feb 2016 14:13:50 +0700
Message-ID: <56B8402E.60402@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:57788 "EHLO
	relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752136AbcBHHOI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 8 Feb 2016 02:14:08 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Abhishek L <abhishek.lekshmanan@gmail.com>, Abhishek Varshney <abhishek.varshney@flipkart.com>, Nathan Cutler <ncutler@suse.cz>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Dear backporters,

Hammer v0.94.6 will be published soon and now would be a good time to s=
tart v0.94.7. I'm willing to participate in this release, either as bac=
kup or driver. If you'd like to help as well, feel free to update http:=
//tracker.ceph.com/projects/ceph-releases/wiki/HOWTO#Whos-who with the =
role that you prefer. The past few weeks have been good (much better th=
an when the make check bot was down and the test infrastructure in cons=
truction, that's for sure ;-). Even at normal priority the tests take l=
ess than a week to complete and often less than 48h, which is really co=
nfortable. And since we now all have access to the lab, there is nothin=
g stopping progress!

In a few weeks jewel will be published and we'll have one more stable r=
elease to care for. Maybe we could send a call for participation to get=
 more help ? One or two mentee when the work starts on v0.94.7 would be=
 ideal. It turns out that Robin had no time for learning the process on=
 v0.94.6 (although he did numerous patches to improve teuthology and th=
erefore helped with backports in other ways). And since Firefly is EOL,=
 Swami did not get a chance either. This is not to say we're in a bad p=
osition, but I think it's an additional incentive to recruit now.

What do you think ?

Cheers
--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
