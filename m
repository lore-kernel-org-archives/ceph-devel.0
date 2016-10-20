From: Sage Weil <sweil@redhat.com>
Subject: Re: jewel: bad rados_buffer_free from librados python bindings
Date: Thu, 20 Oct 2016 13:52:49 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610201352030.21052@piezo.us.to>
References: <580881D6.2070603@dachary.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:51892 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933043AbcJTNww (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 20 Oct 2016 09:52:52 -0400
In-Reply-To: <580881D6.2070603@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Thu, 20 Oct 2016, Loic Dachary wrote:
> H Sage,
> 
> It looks like http://tracker.ceph.com/issues/15454 surfaced in jewel (failed twice in a row at http://tracker.ceph.com/issues/17487#note-19). It did not occur before, therefore I suspect it's a side effect of some of the commits in the jewel backports integration branch ( http://tracker.ceph.com/issues/17487#note-16 ), but I don't see which commit in that branch could have caused that kind of misbehavior.
> 
> Since you marked http://tracker.ceph.com/issues/15454 as Resolved with no commits attached, I suppose it means it went away for some reason. Could you please confirm ? 

Hmm, unfortunately I don't remember working on this one.  My guess is it 
came up during a bug scrub discussion and that's when it got closed.  
Hopefully Kefu or Josh remember?

sage
