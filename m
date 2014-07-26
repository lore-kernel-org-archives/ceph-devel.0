From: Yehuda Sadeh <yehuda@redhat.com>
Subject: issue #8937
Date: Fri, 25 Jul 2014 20:41:51 -0700
Message-ID: <CABBk=J82jFBKESgh_sRHMxzobUnMG1rxJPLvtRpGDJrSMVZvFA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:60793 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751621AbaGZDlw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 Jul 2014 23:41:52 -0400
Received: by mail-pa0-f41.google.com with SMTP id rd3so7131125pab.14
        for <ceph-devel@vger.kernel.org>; Fri, 25 Jul 2014 20:41:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

I pushed a fix (which is not heavily tested) to wip-8937. The problem
seem to have been triggered by the fix to #8928. One thing that I
noticed was that previously max_chunk_size at that point was actually
used as the minimum write size (how appropriate). It's used elsewhere
as the max size for data drained off the front end.
Basically the fix for #8928 now makes max_chunk_size to limit the
rados writes to no more than that. Since up until now we weren't doing
it, then I'm not too sure that this change won't have significant
performance implications.
The options that we have at this point is:
 - keep it as it is now, max_chunk_size limits rados writes
 - revert it to the old behavior, but add some code to handle the pool
alignment when needed

In any case, I don't think this is ready to go into firefly.

Yehuda
