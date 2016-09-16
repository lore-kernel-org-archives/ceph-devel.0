From: Sage Weil <sweil@redhat.com>
Subject: Re: filestore_fiemap is bad, memstore is buggy.
Date: Fri, 16 Sep 2016 13:24:19 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1609161323470.1037@piezo.us.to>
References: <alpine.DEB.2.11.1609152142570.19761@piezo.us.to> <CACJqLyZPOJ8R-4=hZxPMZMzZj2WEGDdqrMNbuxHUsLjwVN6wMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47716 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934338AbcIPNYX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 16 Sep 2016 09:24:23 -0400
In-Reply-To: <CACJqLyZPOJ8R-4=hZxPMZMzZj2WEGDdqrMNbuxHUsLjwVN6wMA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomai@xsky.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, 16 Sep 2016, Haomai Wang wrote:
> On Fri, Sep 16, 2016 at 5:48 AM, Sage Weil <sweil@redhat.com> wrote:
> > I was adding tests for clone_range in preparation for improving the
> > bluestore implementation and got stuck on memstore and filestore bugs!
> >
> > The most alarming is that filestore very quickly fails the tests if
> > filestore_fiemap is enabled.  It's off by default (phew!) but the
> > ceph_test_objectstore test was explicitly enabling it to get better
> > coverage.  For now I've just removed that so we stick with the default (no
> > fiemap == good).  I wonder if we should consider removing fiemap from the
> > code entirely, though, since it is clearly buggy, even on a modern kernel
> > (I'm running 4.4 and XFS).
> 
> I tried with the new test case, I found even disable fiemap, I will
> ran into failure. So I suspect the splice codes, I disable it, test
> passed.
> 
> But fiemap and seek_data/seek_hole is still failing even disable
> splice, I would like to dive into more to verify our codes if correct
> since _do_seek_hole_data is copied from fiemap....

Yeah, good idea.  Thanks for looking into it!

sage
