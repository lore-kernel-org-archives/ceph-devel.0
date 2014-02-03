From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/4] Misc patches for 3.14-rc2
Date: Mon,  3 Feb 2014 15:47:04 +0200
Message-ID: <1391435228-27874-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:41330 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbaBCNrM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 3 Feb 2014 08:47:12 -0500
Received: by mail-wg0-f49.google.com with SMTP id a1so12104299wgh.16
        for <ceph-devel@vger.kernel.org>; Mon, 03 Feb 2014 05:47:11 -0800 (PST)
Received: from localhost ([109.110.66.110])
        by mx.google.com with ESMTPSA id ev4sm26018742wib.1.2014.02.03.05.47.09
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 03 Feb 2014 05:47:10 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

- 1/4 is a simple error path fix
- 2/4 replaces VLA with a heap buffer
- 3/4 and 4/4 eliminate a possible race condition in redirect reply
  handling

I think these can go into rc2 after some testing.

Thanks,

                Ilya


Ilya Dryomov (4):
  libceph: fix error handling in ceph_osdc_init()
  libceph: a per-osdc crush scratch buffer
  libceph: factor out logic from ceph_osdc_start_request()
  libceph: take map_sem for read in handle_reply()

 include/linux/ceph/osdmap.h |    3 ++
 net/ceph/osd_client.c       |   84 +++++++++++++++++++++++++++----------------
 net/ceph/osdmap.c           |   25 ++++++++-----
 3 files changed, 73 insertions(+), 39 deletions(-)

-- 
1.7.10.4

