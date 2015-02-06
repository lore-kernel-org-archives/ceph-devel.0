From: Haomai Wang <haomaiwang@gmail.com>
Subject: About in_seq, out_seq in Messenger
Date: Fri, 6 Feb 2015 16:26:18 +0800
Message-ID: <CACJqLyY_UoHO-JxNHcQcZFLpJT8awXb+aAtCG-dj26SdTZ-RgQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f49.google.com ([74.125.82.49]:46382 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751164AbbBFI0U (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Feb 2015 03:26:20 -0500
Received: by mail-wg0-f49.google.com with SMTP id k14so12037956wgh.8
        for <ceph-devel@vger.kernel.org>; Fri, 06 Feb 2015 00:26:18 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Gregory Farnum <greg@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi all,

Recently we enable a async messenger test job in test
lab(http://pulpito.ceph.com/sage-2015-02-03_01:15:10-rados-master-distro-basic-multi/#).
We hit many failed assert mostly are:
              assert(0 == "old msgs despite reconnect_seq feature");

And assert connection all are cluster messenger which mean it's OSD
internal connection. The policy associated this connection is
Messenger::Policy::lossless_peer.

So when I dive into this problem, I find something confusing about
this. Suppose these steps:
1. "lossless_peer" policy is used by both two side connections.
2. markdown one side(anyway), peer connection will try to reconnect
3. then we restart failed side, a new connection is built but
initiator will think it's a old connection so sending in_seq(10)
4. new started connection has no message in queue and it will receive
peer connection's in_seq(10) and call discard_requeued_up_to(10). But
because no message in queue, it won't modify anything
5. now any side issue a message, it will trigger "assert(0 == "old
msgs despite reconnect_seq feature");"

I can replay these steps in unittest and actually it's hit in test lab
for async messenger which follows simple messenger's design.

Besides, if we enable reset_check here, "was_session_reset" will be
called and it will random out_seq, so it will certainly hit "assert(0
== "skipped incoming seq")".

Anything wrong above?

-- 
Best Regards,

Wheat
