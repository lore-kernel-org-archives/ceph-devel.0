From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: PG recovery reservation state chart
Date: Tue, 2 Oct 2012 13:40:00 -0700
Message-ID: <20121002204000.GE8206@splice>
References: <20121002194858.GC8206@splice>
 <506B4F11.5070402@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:61644 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755287Ab2JBUkE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 16:40:04 -0400
Received: by padhz1 with SMTP id hz1so5597471pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 13:40:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <506B4F11.5070402@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 02, 2012 at 01:31:13PM -0700, Josh Durgin wrote:
> Is the local reservation taken in OSD ID order with the remote
> reservations as well? What's the difference between local and remote
> reservations? Are there different limits on remote and local
> reservations?

They come from separate pools. Each pool has a finite number of
reservations, but if one pool has no more slots the other may still
grant reservations.

> If there's more than one possible replica to backfill from could we try
> to reserve others if the first is busy instead of waiting?

I think you may have your backfill terminology backward. We don't
backfill from a replica, we backfill to a replica.

There will never be more than one replica that needs to be backfilled
to.

> Why would a remote backfill reservation fail if the OSD is full
> (disk space)? Backfill doesn't write to the replica, right? Or by
> full, do
> you mean out of reservations?

If the disk on the OSD is near full we reject backfills. This change I
implemented a few weeks ago and was merged last week.

Backfill does write to the replica.
