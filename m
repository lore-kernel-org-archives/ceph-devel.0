From: Martin B Nielsen <martin@unity3d.com>
Subject: Increase number of pg in running system
Date: Tue, 5 Feb 2013 14:06:50 +0100
Message-ID: <CAD3n6hFb=m_PL27sWZ5BSBAYP3xmTGZS_DrL-4ozF2+JbndMCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f42.google.com ([209.85.219.42]:53023 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754748Ab3BENGv convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Feb 2013 08:06:51 -0500
Received: by mail-oa0-f42.google.com with SMTP id i18so116591oag.15
        for <ceph-devel@vger.kernel.org>; Tue, 05 Feb 2013 05:06:50 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi,

Looking at:
http://ceph.com/docs/master/rados/operations/pools/

It has this description roughly in the middle:

---------------
Important
Increasing the number of placement groups in a pool after you create
the pool is still an experimental feature in Bobtail (v 0.56). We
recommend defining a reasonable number of placement groups and
maintaining that number until Ceph=92s placement group splitting and
merging functionality matures.
---------------

However, I cannot find any references how to do this?

I'm asking since we have a test system with 10TB data with only the
default 8 PG's created.

So currently the system is throwing 400GB pg's around whenever we test
removing disks.

The system sometimes wants to put 2x pg's on an OSD which cannot hold
it and it winds up with cluster full. If there is ~750GB free on a OSD
it might decide to put 2x 400GB pgs on it (even though there are other
OSD with even more disk free than that - these disks are exact same
type, size and weights).

System is running bobcat 0.56.2

The system holds 2 big rbd images and it is not an option to create a
new pool with higher pg count and copy them (not enough total space
available).

Thanks in advance,

Cheers,
Martin
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
