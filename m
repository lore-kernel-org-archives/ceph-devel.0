From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: OSD-crash on 0.48.1argonout, error "void ReplicatedPG::recover_got(hobject_t,
 eversion_t)" not seen on list
Date: Wed, 19 Sep 2012 10:53:38 +0200
Message-ID: <50598812.7030102@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-5.de-punkt.de ([93.190.64.35]:44853 "EHLO
	mail-5.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752786Ab2ISIxm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Sep 2012 04:53:42 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi all,

after adding a new node into our ceph-cluster yesterday, we had a crash=
=20
of one OSD.

I have found this kind of message in the bugtracker as being solved (=20
http://tracker.newdream.net/issues/2075),
I will update this one for my convenience and attach the according log =
(=20
due to productive site, there is no more
verbose debug available, sorry).

Other than that, everything went almost smoothly, except the annoying=20
"slow requests",
which are hopefully not only fixed in 0.51, ... when do we expect next=20
stable, btw?

The replication was fast, due to a SSD-cached LSI-controller, 4 OSDs pe=
r=20
node, one per HDD,
1Gbit was completely saturated, time for next step towards 10Gbit ;)

Regards,

Oliver.

--=20

Oliver Francke

filoo GmbH
Moltkestra=DFe 25a
33330 G=FCtersloh
HRB4355 AG G=FCtersloh

Gesch=E4ftsf=FChrer: S.Grewing | J.Rehp=F6hler | C.Kunz

=46olgen Sie uns auf Twitter: http://twitter.com/filoogmbh

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
