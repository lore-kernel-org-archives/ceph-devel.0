From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 0/2] libceph: lingering request fixes for 4.1
Date: Wed, 13 May 2015 17:57:30 +0300
Message-ID: <1431529052-13932-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34143 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934516AbbEMO5y (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 13 May 2015 10:57:54 -0400
Received: by wicmc15 with SMTP id mc15so80876500wic.1
        for <ceph-devel@vger.kernel.org>; Wed, 13 May 2015 07:57:52 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Alex Elder <elder@linaro.org>

Hello,

Trying to understand how watch/notify works for his v2 work, Doug tried
a simple test which uncovered a regression in lingering request requeue
code dating back to 3.18.  As it pretty much always is, a one liner is
all it took.  The reason it went unnoticed is we can't thrash it
because of watch/notify v1 limitations and the last round of manual
testing I did was around 3.16-3.17 after a bunch of fixes in that area,
so only osd-requeue (as opposed to osdmap-requeue) path was stressed.

While investigating it I found another problem, which probably goes all
the way back to the addition of watch/notify and that is what the first
patch is for.  The regression itself is fixed by a revert, with the
ground for it set up in the first patch.  Both are marked for stable
and will be backported together.

Thanks,

                Ilya


Ilya Dryomov (2):
  libceph: request a new osdmap if lingering request maps to no osd
  Revert "libceph: clear r_req_lru_item in
    __unregister_linger_request()"

 net/ceph/osd_client.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

-- 
1.9.3

