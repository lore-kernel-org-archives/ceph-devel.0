From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/3] __remove_osd() vs lingering requests
Date: Wed,  5 Nov 2014 20:33:21 +0300
Message-ID: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:51891 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754602AbaKERdj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 12:33:39 -0500
Received: by mail-la0-f44.google.com with SMTP id gf13so1134496lab.17
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 09:33:37 -0800 (PST)
Received: from localhost ([109.110.66.36])
        by mx.google.com with ESMTPSA id g2sm1545263lbd.35.2014.11.05.09.33.35
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Nov 2014 09:33:36 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

These are fixes for the problem I found while trying to reproduce
recently reopened http://tracker.ceph.com/issues/5429.  I'm pretty sure
this is what was reported in http://tracker.ceph.com/issues/8568 too.
The exact BUG_ON() it points to is no longer there, but I checked with
an older kernel and the reproducer I have for this triggered it.

Thanks,

                Ilya


Ilya Dryomov (3):
  libceph: unlink from o_linger_requests when clearing r_osd
  libceph: clear r_req_lru_item in __unregister_linger_request()
  libceph: change from BUG to WARN for __remove_osd() asserts

 net/ceph/osd_client.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
1.7.10.4

