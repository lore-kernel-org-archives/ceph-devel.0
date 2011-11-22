From: Sage Weil <sage@newdream.net>
Subject: Re: Recommended btrfs mount options
Date: Tue, 22 Nov 2011 14:18:42 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1111221415280.11288@cobra.newdream.net>
References: <CAO47_-_V4d=3abABvqrV+muJ3cF-J-=-RQ748Vr+U=_ZdffZfw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36292 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753219Ab1KVWSn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Nov 2011 17:18:43 -0500
In-Reply-To: <CAO47_-_V4d=3abABvqrV+muJ3cF-J-=-RQ748Vr+U=_ZdffZfw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 22 Nov 2011, Christian Brunner wrote:
> Reading the latest pull request by Chris Mason, I was wondering about
> the recommended mount options for an OSD-Filesystem.
> 
> In the past I came across the following btrfs options, that were used
> in conjunction with ceph:
> 
> - nodatacow: To avoid fragmentation. I think this one makes sense when
> you are using rbd, but it turns of btrfs-csums. Is it safe to use?
> (ceph has his own csums, right?)

I'm not sure this will help, since we snapshot for each commit, so it 
will COW in that case regardless.  We only csum across the wire, so we'll 
rely on btrfs checksums..

> - autodefrag: To reduce fragmentation. I think this one makes sense in 
> any case.

Yeah

> - compression: I'm using lzo compression right now, as my CPUs in the
> OSD nodes where idle most of the time and it is improving throughput
> quite a bit.

The caveat here is that there is a corner case with inline extents and the 
clone ioctl that isn't implemented.  That should get dealt with at some 
point.  (To clone a portion of an inline extent you need to decompress 
to a buffer and recompress part of it into a new extent.)

> - notreelog: Never heard of it before I read the pull request. Should I 
> use it?

It basically makes fsync do a full commit, but ceph-osd doesn't fsync, so 
it isn't helpful.  Obsolete.
 
> - flushoncommit: Is it obsolete now?

Obsolete.  The snapshot creation does a flush.

> - nocluster (requires an additional btrfs patch from Alexandre): I was
> reading that he was able to reduce the excessive metadata overhead,
> but it is slower. Does anyone know more about it?

We haven't tried this.

> I'm running with "noatime,compression=lzo" at the moment, but I'm
> planning to add autodefrag as soon as my load problems are fixed. I
> would really like to know, what you are using and why?

For now we're just using noatime.  I would love to turn on lzo compression 
after the clone issue is dealt with, even tho it would be really hard to 
trigger the issue.

sage
