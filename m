From: "ronny.hegewald@online.de" <ronny.hegewald@online.de>
Subject: Aw: Re: [PATCH] mark rbd requiring stable pages
Date: Tue, 3 Nov 2015 23:03:14 +0100
Message-ID: <trinity-287e174e-89c2-410e-9487-9d45cf62b164-1446588194857@3capp-1and1-bs02>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.130]:52801 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932536AbbKCWDb convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Nov 2015 17:03:31 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Mike Christie <michaelc@cs.wisc.edu>, Ceph Development <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>


I have done some testing through the weekend on the same testmachine
i used the week before, but wasn't successfull to reproduce any corrupt=
ion
this time.
=C2=A0
I was rethinking my tests and why the results where different this time=
 and
what your might also be different in your own test-environment.=C2=A0 T=
his
difference might be the recovering state of my ceph installation and it=
s effect
on the available memory and maybe other stats of the machine.
=C2=A0
Back then when the corruptions occured on my systems i would have sever=
al
problems because of the closed connections caused by the bad crcs, with=
 OSDs
either being restarted by myself or getting marked out and in of the cl=
uster,
because the other OSDs didn't get the necessary ping from the OSD for t=
oo long.
=C2=A0
The result of this was a noticeable increase of RAM-use. After some pee=
rings
and recoverys the machines would use ca. 500-800 MB swap, when it would
have used none before.
=C2=A0
This might also explain why my own attempts to reproduce the corruption=
s on
purpose were never successfull. This tests usually happened pretty much=
 shortly
after a fresh start of the cluster.
=C2=A0
Same situation on my test machine.=C2=A0 Before i run into a corruption=
 on this machine 2=C2=A0
weeks ago, it had already executed some recoverys and backfills on the =
OSDs that
are hosted on this machine. This resulted in ca. 900 MB swap being used=
=2E
=C2=A0
This weekend the machine had the same amount of OSDs started, but there=
 was not
much of recovering necessary, so there was no swap used and enogh Ram
available for ca. 2 GB of vfs-caches.
=C2=A0
Whatever it might be, the recovering/peering process might be the impor=
tant part
that brings the machine in the necessary state for the corruptions to o=
ccur.=C2=A0 This
memory increase should be easy to reproduce by sending a "ceph osd down=
 x" to some
of the OSDs=C2=A0 This has always the described result in my installati=
on.
=C2=A0
I will check if this actually works on my side also. But that will take=
 some time.
=C2=A0
=C2=A0
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
