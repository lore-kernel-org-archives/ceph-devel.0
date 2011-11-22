From: Christian Brunner <chb@muc.de>
Subject: Recommended btrfs mount options
Date: Tue, 22 Nov 2011 21:46:29 +0100
Message-ID: <CAO47_-_V4d=3abABvqrV+muJ3cF-J-=-RQ748Vr+U=_ZdffZfw@mail.gmail.com>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vx0-f174.google.com ([209.85.220.174]:65045 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754696Ab1KVUq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2011 15:46:29 -0500
Received: by vcbfk1 with SMTP id fk1so688467vcb.19
        for <ceph-devel@vger.kernel.org>; Tue, 22 Nov 2011 12:46:29 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Reading the latest pull request by Chris Mason, I was wondering about
the recommended mount options for an OSD-Filesystem.

In the past I came across the following btrfs options, that were used
in conjunction with ceph:

- nodatacow: To avoid fragmentation. I think this one makes sense when
you are using rbd, but it turns of btrfs-csums. Is it safe to use?
(ceph has his own csums, right?)

- autodefrag: To reduce fragmentation. I think this one makes sense in any case.

- compression: I'm using lzo compression right now, as my CPUs in the
OSD nodes where idle most of the time and it is improving throughput
quite a bit.

- notreelog: Never heard of it before I read the pull request. Should I use it?

- flushoncommit: Is it obsolete now?

- nocluster (requires an additional btrfs patch from Alexandre): I was
reading that he was able to reduce the excessive metadata overhead,
but it is slower. Does anyone know more about it?

I'm running with "noatime,compression=lzo" at the moment, but I'm
planning to add autodefrag as soon as my load problems are fixed. I
would really like to know, what you are using and why?

Thanks,
Christian
