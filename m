From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 0/3] libceph: #8979 fix (wip-auth-8979)
Date: Wed, 10 Sep 2014 11:54:28 +0400
Message-ID: <1410335671-4581-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:44932 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbaIJHyf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 03:54:35 -0400
Received: by mail-lb0-f180.google.com with SMTP id b12so3398559lbj.39
        for <ceph-devel@vger.kernel.org>; Wed, 10 Sep 2014 00:54:34 -0700 (PDT)
Received: from localhost ([109.110.67.183])
        by mx.google.com with ESMTPSA id my10sm5364041lbb.9.2014.09.10.00.54.32
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 00:54:33 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Hello,

This is a fix for #8979 ("GPF kernel panics - auth?"), based on Sage's
wip-8979 branch.

Thanks,

                Ilya


Ilya Dryomov (2):
  libceph: add process_one_ticket() helper
  libceph: do not hard code max auth ticket len

Sage Weil (1):
  libceph: gracefully handle large reply messages from the mon

 net/ceph/auth_x.c     |  256 ++++++++++++++++++++++++++-----------------------
 net/ceph/mon_client.c |    8 ++
 2 files changed, 143 insertions(+), 121 deletions(-)

-- 
1.7.10.4

