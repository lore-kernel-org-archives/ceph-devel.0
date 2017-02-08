From: Henrik Korkuc <lists@kirneh.eu>
Subject: Re: noout equivalent for temporary OSD rm?
Date: Wed, 8 Feb 2017 14:52:16 +0200
Message-ID: <f72dd6be-2cb5-b0f2-b2f7-34eb8601f837@kirneh.eu>
References: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from alpha.syseng.pro ([37.48.90.241]:42568 "EHLO alpha.syseng.pro"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932724AbdBHRjF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 8 Feb 2017 12:39:05 -0500
In-Reply-To: <CALe9h7d6ftL__1S-mJd6y3GAfDJST1zN+scgqm4gC6T3_qbOiw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 17-02-08 14:26, John Spray wrote:
> So I've just finished upgrading my home cluster OSDs to bluestore by
> killing them one by one and then letting backfill happen to "new" OSDs
> on the same drives.  Hooray!
>
> One slightly awkward thing I ran into was that even though I had noout
> set throughout, during the period between removing the old OSD and
> adding the "new" one, some PGs would of course get remapped (and start
> generating backfill IO to third party OSDs).  This does make sense
> when you think about it (noout doesn't make the cluster magically
> remember OSDs that have been removed), but is still an undesirable
> behaviour.
>
> A) Do we currently have a mechanism to tell the cluster "even though I
> removed this OSD, don't go moving PGs around just yet"?  Should we add
> one?
I successfully used "nobackfill" for that purpose. Cluster does peering, 
but no actual data movement

> B) Was there a way for me to avoid this by e.g. skipping the "osd rm
> X" and "osd crush rm osd.X" that I'm currently doing before adding the
> new OSD that will take the old OSD's ID?
>
> John
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html


