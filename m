From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Problem after ceph-osd crash
Date: Mon, 20 Feb 2012 17:59:49 +0100
Message-ID: <4F427C05.1000304@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:43202 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753035Ab2BTQ7x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Feb 2012 11:59:53 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

we are just in trouble after some mess with trying to include a new=20
OSD-node into our cluster.

We get some weird "libceph: corrupt inc osdmap epoch 880 off 102=20
(ffffc9001db8990a of ffffc9001db898a4-ffffc9001db89dae)"

on the console.
The whole system is in a state ala:

012-02-20 17:56:27.585295    pg v942504: 2046 pgs: 1348 active+clean, 4=
3=20
active+recovering+degraded+remapped+backfill, 218 active+recovering, 43=
7=20
active+recovering+remapped+backfill; 1950 GB data, 3734 GB used, 26059=20
GB / 29794 GB avail; 272914/1349073 degraded (20.230%)

and sometimes the ceph-osd on node0 is crashing. At the moment of=20
writing, the degrading continues to shrink down below 20%.

Any clues?

Thnx in @vance,

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
