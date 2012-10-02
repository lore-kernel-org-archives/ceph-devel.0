From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: PG recovery reservation state chart
Date: Tue, 02 Oct 2012 13:31:13 -0700
Message-ID: <506B4F11.5070402@inktank.com>
References: <20121002194858.GC8206@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:42649 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab2JBUbQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 16:31:16 -0400
Received: by dakn41 with SMTP id n41so916708dak.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 13:31:16 -0700 (PDT)
In-Reply-To: <20121002194858.GC8206@splice>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Ryan <mike.ryan@inktank.com>
Cc: ceph-devel@vger.kernel.org

On 10/02/2012 12:48 PM, Mike Ryan wrote:
> Tried sending this earlier but it seems the list doesn't like PNGs.
> dotty or dot -Tpng will make short work of the .dot file I've attached.
>
>
> These are the changes to the Active state of the PG state chart in order
> to support recovery reservations. This is Important Stuff, so please
> criticize mercilessly.
>
> Here's a prose version:
>
> When the PG activates, it determines whether it needs to do recovery. If
> it does, it grabs its local reservation, then grabs a remote reservation
> from each replica in order of OSD ID (to prevent deadlock). Once all
> remotes are reserved, it starts recovering.

Is the local reservation taken in OSD ID order with the remote
reservations as well? What's the difference between local and remote
reservations? Are there different limits on remote and local
reservations?

> After recovery, all remote reservations are dropped. If no backfill is
> necessary, the local reservation is dropped and we jump to Clean.
>
> If we need to backfill, we request a remote backfill reservation from
> the replica. If this reservation is rejected (due to the OSD being too
> full) we drop our local reservation and wait for a while in
> NotBackfilling. We then grab our local reservation and try again on the
> remote reservation. Once we have the remote reservation, we backfill.
> After Backfilling we drop the local and remote backfill reservation and
> jump to Clean.

If there's more than one possible replica to backfill from could we try
to reserve others if the first is busy instead of waiting?

Why would a remote backfill reservation fail if the OSD is full (disk 
space)? Backfill doesn't write to the replica, right? Or by full, do
you mean out of reservations?

