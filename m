From: Sage Weil <sweil@redhat.com>
Subject: Re: Could you resend the link to the pull request?
Date: Tue, 5 Dec 2017 16:39:17 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1712051635200.22619@piezo.novalocal>
References: <CAFQ4geQPTh00fpO0Y6BoCx1zV5eLrFEphZKoO5krV4OHhPaq5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46750 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751288AbdLEQjT (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 5 Dec 2017 11:39:19 -0500
In-Reply-To: <CAFQ4geQPTh00fpO0Y6BoCx1zV5eLrFEphZKoO5krV4OHhPaq5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Iizawa <kiizawa@ucsc.edu>, ohmyoungwon@gmail.com
Cc: ceph-devel@vger.kernel.org

On Tue, 5 Dec 2017, Ken Iizawa wrote:
> I'm sorry, but I failed to save the link to the pull request you told
> me about in today's meeting.
> Could you resend the link?

https://github.com/ceph/ceph/pull/15482

There is a bunch of stuff in there, sorry.  What we really want is a rados 
op that triggers promote_object().  We don't have that quite yet.

Myoungwon, is that something you've looked at yet?  I'm thinking of a 
rados op like TIER_PROMOTE (or something along those lines) that just 
triggers a promotion if it is a redirect/chunked manifest, and is a no-op 
otherwise.  (We could probably make it do something meaningful for a cache 
tier too, but I don't think it's worth the effort.)

sage
