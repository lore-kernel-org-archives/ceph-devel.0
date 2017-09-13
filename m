From: Jeff Layton <jlayton@redhat.com>
Subject: should CephContext be a singleton?
Date: Wed, 13 Sep 2017 10:58:35 -0400
Message-ID: <1505314715.4822.24.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f181.google.com ([209.85.161.181]:46894 "EHLO
        mail-yw0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750993AbdIMO6j (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 13 Sep 2017 10:58:39 -0400
Received: by mail-yw0-f181.google.com with SMTP id v72so1115907ywa.3
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 07:58:39 -0700 (PDT)
Received: from tleilax.poochiereds.net (cpe-71-70-156-158.nc.res.rr.com. [71.70.156.158])
        by smtp.gmail.com with ESMTPSA id l196sm4700117ywb.42.2017.09.13.07.58.36
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Sep 2017 07:58:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I recently hit the problem described in this bug when rolling some new
tests for cephfs:

    http://tracker.ceph.com/issues/20988

While I hit it in a testcase, I suspect something like ganesha or samba
could also hit this, as they can create several CephContexts in the
course of their duties and their teardown is not necessarily coordinated
in any way.

The problem is basically that the CephContext is a random pile of stuff,
some of which has an effect on global objects (the lockdep stuff, in
particular, but there may be more).

There are a few ways to fix it...we could just ensure that the lockdep
stuff is handled cleanly, but I wonder...is there any real-world
use-case for having multiple CephContexts in a single process image?

It contains stuff like admin sockets, and certain threads are tied to
it, etc. This seems like the sort of thing that should just have a
single instance per process. Should we start moving things in that
direction, or should I look at fixing this another way?

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
