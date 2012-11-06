From: Oliver Francke <Oliver.Francke@filoo.de>
Subject: Ubuntu 12.04.1 + xfs + syncfs is still not our friend
Date: Tue, 06 Nov 2012 17:14:13 +0100
Message-ID: <50993755.8060800@filoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-6.de-punkt.de ([93.190.64.36]:40751 "EHLO
	mail-6.de-punkt.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751851Ab2KFQOR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Nov 2012 11:14:17 -0500
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi *,

anybody out there who's in Ubuntu 12.04.1/ in connection with libc + xf=
s=20
+ syncfs?

We bit the bullet and reinstalled two new nodes from debian to precise=20
in favour of possible performance increase?!

*sigh*, still getting:

2012-11-06 17:05:51.863921 7f5cc52e3780  0 filestore(/data/osd6-3) moun=
t=20
syncfs(2) syscall not support by glibc
2012-11-06 17:05:51.863925 7f5cc52e3780  0 filestore(/data/osd6-3) moun=
t=20
no syncfs(2), must use sync(2).

as a show-stopper.

That's with 3.2.* and 3.6.6 kernel. Should be new enough. And=20
ceph-0.48.2 ( eu.ceph.com mirror was installing 0.48.1.. though *ops* ;=
) )

But both should be capable of this system-call?!

We've been so very near... but now clueless, please sched some light in=
 8-)

( I hope this is not a very obvious human RTFM error ;) )

And so I'm writing, should one enable directio + aio, as we're having=20
the journals on a SSD-partition?

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
