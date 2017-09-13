From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: should CephContext be a singleton?
Date: Wed, 13 Sep 2017 11:09:15 -0400
Message-ID: <20170913150915.GA31125@ultraspiritum.eng.arb.redhat.com>
References: <1505314715.4822.24.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40350 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751870AbdIMPJQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 13 Sep 2017 11:09:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7E1C55D5EA
        for <ceph-devel@vger.kernel.org>; Wed, 13 Sep 2017 15:09:16 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1505314715.4822.24.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>

On 13/09/2017, Jeff Layton wrote:
> It contains stuff like admin sockets, and certain threads are tied to
> it, etc. This seems like the sort of thing that should just have a
> single instance per process. Should we start moving things in that
> direction, or should I look at fixing this another way?

There was a general consensus of removing use of the g_ceph_context
variable. A PR of mine removed it from the object store, OSD and
messenger, though other things needed doing so I haven't got around to
removing the rest.

If you have the cycles for it, feel free to start removing it from
elsewhere and threading CephContext* in.

There isn't really a consensus on splitting out CephContext so it's
less of a God Object but it might be worth reconsidering that at some
point.

Also the lockdep stuff may be less of an issue as we move away from
Mutex to std::mutex. (Though I do have a debugging mutex class that
lets people into our lockdep code if we find that is an issue. I
/suspect/ something like helgrind might be better for finding lock
ordering errors.)

-- 
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9
