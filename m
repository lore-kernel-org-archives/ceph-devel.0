From: Sage Weil <sage@newdream.net>
Subject: Re: Smarter blacklisting?
Date: Tue, 18 Apr 2017 16:41:33 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1704181638530.6579@piezo.novalocal>
References: <CALe9h7dh2=BYjSdSuPXKE457TWg06xrw6QOjmbk_tLvU5fd69w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:59146 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756707AbdDRQlg (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Apr 2017 12:41:36 -0400
In-Reply-To: <CALe9h7dh2=BYjSdSuPXKE457TWg06xrw6QOjmbk_tLvU5fd69w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, 18 Apr 2017, John Spray wrote:
> Currently, when we add an address to the blacklist, we leave it in
> there for a set period of time (24 minutes by default, which I suspect
> might have been meant to be 24 hours), and then expire it.
> 
> Clearly there are two problems with that:
>  * We leave things in the list for much longer than necessary most of
> the time, when a blacklisted client/node comes back reasonably soon
> after a restart
>  * We are never 100% guaranteed that a long-halted client won't come
> back after its blacklist entry has expired (e.g. a paused VM with
> dirty pages, wakes up a day later and writes back to OSDs).
> 
> These mostly haven't been too much trouble in practice, but we may be
> (optionally) doing a lot more blacklisting on cephfs systems soon[1],
> and cephfs clients are perhaps more likely to be VMs than RBD hosts.
> 
> One thought is to have an alternative type of backlist entry that does
> not have an expiration, but instead is automatically removed when we
> see a client authenticate with the same auth id, from the same IP
> address as the blacklist entry, but with a different nonce.
> 
> Flushing out any blacklist entries from a host that never came back
> would be an administrative operation, or we could do it automatically
> on a *super* long expiration time (like a month), and in other cases
> like if the auth identity associated with the blacklist entry was
> removed.
> 
> Any thoughts?

I like it!  I'm not sure it needs to be a different type of entry, 
though... we can just set the expiration to one month, and then have some 
other bit of code remove it early based on the heuristic.

I suspect the main logistical issue is who pays attention to the new auth 
or mount request from the client.  And where the cleanup heuristic 
lives..

sage

