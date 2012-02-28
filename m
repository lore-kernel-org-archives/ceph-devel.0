From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Recommended number of pools, one Q. ever wanted to ask
Date: Tue, 28 Feb 2012 10:35:37 +0100
Message-ID: <4F4C9FE9.7000808@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-3.de-punkt.de ([93.190.64.33]:48991 "EHLO
	mail-3.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134Ab2B1Jfk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 04:35:40 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi *,

well, there was once a comment on our layout in means of "too many pool=
s".
Our setup is to have a pool per customer, to simplify the view on used=20
storage
capacity.
So, if we have - in a couple of months, we hope - more then some hundre=
d
customers, this setup was not recommended, cause the whole system is no=
t
designed for handling that. ( Sage)

What does "not recommended" mean? Is it, that per OSD the used memory=20
will be
too high?
Is this a general performance issue?

Well, if we read "pool", this gave us the basic idea/concept to put all=
=20
per-customers
data into it.

Please sched some light in 8-)

Kind regards,

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
