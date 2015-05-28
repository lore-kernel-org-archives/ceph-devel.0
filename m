From: Ugis <ugis22@gmail.com>
Subject: ceph recovery policy
Date: Thu, 28 May 2015 12:43:00 +0300
Message-ID: <CAE63xUPYX=d-Xq4Qq1nnw_JvYBda3DtQYKrn_BkeN8baOxmoZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:37930 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150AbbE1JnA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 28 May 2015 05:43:00 -0400
Received: by igbjd9 with SMTP id jd9so19605875igb.1
        for <ceph-devel@vger.kernel.org>; Thu, 28 May 2015 02:43:00 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi!

I have been watching changes in "ceph -s" output for a while and
noticed that in this line:
 3324/7888981 objects degraded (0.042%); 1995972/7888981 objects
misplaced (25.301%)
rather misplaced object count drops constantly, but degraded object
count drops just occasionally.

Quick googling did not reveal any mention of recovery/rebalancing
policy(except client vs recovery io).
Is there any?
I mean - it would be reasonable to recover degraded objects in first
place and only then to rebalance misplaced objects as that would
reduce risk of losing data.

That could be default recovey policy, but if other policy needed -
that could be specifyable via some recovery variable, like it is now
in recovery section here:
http://dachary.org/loic/ceph-doc/rados/configuration/osd-config-ref/

P.S. no active client I/O currently present.

Best regards,
Ugis
