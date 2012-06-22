From: John Axel Eriksson <john@insane.se>
Subject: Recommendations for OSDs, RGW and MON
Date: Fri, 22 Jun 2012 11:28:45 +0200
Message-ID: <CAMmJxtLUwnCnbkYMoh0VHxWoL+HJQ98su=4x6GTza2zoS9VR9g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ob0-f174.google.com ([209.85.214.174]:43929 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761695Ab2FVJ2q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 05:28:46 -0400
Received: by obbuo13 with SMTP id uo13so1696349obb.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 02:28:46 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Currently we're running a test cluster with 1 mon, 1 radosgw and 2
osds. RGW runs on the same host as the mon while
the osds recides on two different servers. We have thought of maybe
running more than 1 osd on each storage server, where
the osds use different disks of course - is this something reasonable
or would performance/stability suffer?

Is there any recommendation against running rgw/mon on the same
server? Would a better setup be to put osd/mon/rgw on each
server and loadbalancing rgw? Of course we might add more osd:s at
some point and I guess we don't want to run mons/rgw on
those.

Also, on Ubuntu 12.04, does anybody have experience with ceph on btrfs
performance or is the recommendation still to run on xfs?

All this is for running only the object storage part of ceph (only
accessed through RGWs S3-interface).

Thanks,
John
