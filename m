From: Sage Weil <sweil@redhat.com>
Subject: should we remove autotools from master?
Date: Tue, 23 Aug 2016 13:58:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608231356290.25681@piezo.us.to>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:50552 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753295AbcHWN6W (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 23 Aug 2016 09:58:22 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Brad Hubbard <bhubbard@redhat.com>, Avner Ben Hanoch <avnerb@mellanox.com>, Gregory Farnum <gfarnum@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

Should we remove the autotools stuff from master?

Yes:
- It won't be maintained
- It sucks
- It confuses people and they use it by mistake
- We'll find any build scripts etc that haven't been converted sooner 
rather than later

No:
- Other architectures might rely on it
- It's possible some build scripts haven't been convert yet

I'm thinking yes?
sage


On Tue, 23 Aug 2016, Nathan Cutler wrote:

> > That's a different make-deb(s).sh
> 
> Allow me to qualify that statement. This thread seems to be about
> 
> https://github.com/ceph/ceph/blob/master/make-debs.sh
> 
> while the "make-deb.sh" I am working on is
> 
> https://github.com/ceph/ceph-qa-suite/blob/master/tasks/buildpackages/make-deb.sh
> 
> which is used with the teuthology-openstack backend. However, I see the two
> scripts are similar.
> 
> In general, although the autotools stuff is still there in master, it is not
> maintained and should not be expected to work (or continue to work). All build
> infrastructure targeting master should be converted to cmake.
> 
> Nathan
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
