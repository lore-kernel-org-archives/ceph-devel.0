From: Florian Haas <florian@hastexo.com>
Subject: OSD nodes with >=8 spinners, SSD-backed journals, and their
 performance impact
Date: Mon, 14 Jan 2013 13:17:07 +0100
Message-ID: <CAPUexz-D2KTf5q_Tmmm1SE3of7urrgn1T=ac_jhjxHHCe42pMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f172.google.com ([209.85.210.172]:47174 "EHLO
	mail-ia0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756170Ab3ANMRK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Jan 2013 07:17:10 -0500
Received: by mail-ia0-f172.google.com with SMTP id u8so3461569iag.17
        for <ceph-devel@vger.kernel.org>; Mon, 14 Jan 2013 04:17:09 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi everyone,

we ran into an interesting performance issue on Friday that we were
able to troubleshoot with some help from Greg and Sam (thanks guys),
and in the process realized that there's little guidance around for
how to optimize performance in OSD nodes with lots of spinning disks
(and hence, hosting a relatively large number of OSDs). In that type
of hardware configuration, the usual mantra of "put your OSD journals
on an SSD" doesn't always hold up. So we wrote up some
recommendations, and I'd ask everyone interested to critique this or
provide feedback:

http://www.hastexo.com/resources/hints-and-kinks/solid-state-drives-and-ceph-osd-journals

It's probably easiest to comment directly on that page, but if you
prefer instead to just respond in this thread, that's perfectly fine
too.

For some background of the discussion, please refer to the LogBot log
from #ceph:
http://irclogs.ceph.widodh.nl/index.php?date=2013-01-12

Hope this is useful.

Cheers,
Florian

-- 
Helpful information? Let us know!
http://www.hastexo.com/shoutbox
