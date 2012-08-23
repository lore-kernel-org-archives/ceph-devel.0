From: Tren Blackburn <tren@eotnetworks.com>
Subject: How to increase the number of pgs at pool creation time?
Date: Thu, 23 Aug 2012 13:39:14 -0700
Message-ID: <CANLRBoxdu7iPvBU45T5Nk0zDYT1QSX9-oyo4g1nEav-+ybGA4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:49712 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933727Ab2HWUjP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Aug 2012 16:39:15 -0400
Received: by vbbff1 with SMTP id ff1so1296429vbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 23 Aug 2012 13:39:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hi List;

I am attempting to get a test ceph cluster up and running. I am using
ceph-0.50 across all nodes. I am attempting to get the number of pgs
to be around 100 per osd as per the documentation at:

http://ceph.com/docs/master/dev/placement-group/

I have attempted to increase the pgs via several methods:

1) Increase at mkcephfs time by passing --osd-pg-bits 7. This does not
work as this option does not exist on 0.50
    re: http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg06923.html

2) Increase the number of pgs via ceph.conf (osd pg bits = 7) and
create the cluster. This does not work either as the cluster comes up
with 6 pgs bits per osd still.
    re: http://ceph.com/docs/master/config-cluster/osd-config-ref/

So I'm a bit lost! I cannot find a way to increase pgs at pool
creation time. Option 1 does not work at all. Option 2 seems to be
ignored. I have 68 OSD's. At 7 bits per OSD I should have 8704 (68 *
2^7) pgs, but I still end up with the default of 4352 (68 * 2^6).

I'm hoping I'm missing something simple, but if anyone is able to
point me in the correct direction, that would be appreciated!

Regards,

Tren
