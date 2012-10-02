From: Gregory Farnum <greg@inktank.com>
Subject: Re: PG recovery reservation state chart
Date: Tue, 2 Oct 2012 13:02:06 -0700
Message-ID: <CAPYLRzgU+DxNFepUY3s1PvAG-zeBxsrDrgcGUxbwTswpy6zFgA@mail.gmail.com>
References: <20121002194858.GC8206@splice>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:64108 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752181Ab2JBUCG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 16:02:06 -0400
Received: by ieak13 with SMTP id k13so15609277iea.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 13:02:06 -0700 (PDT)
In-Reply-To: <20121002194858.GC8206@splice>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mike Ryan <mike.ryan@inktank.com>
Cc: ceph-devel@vger.kernel.org

On Tue, Oct 2, 2012 at 12:48 PM, Mike Ryan <mike.ryan@inktank.com> wrote:
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

Remote and local reservations come out of a different pool?


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


I think I know what you're talking about here, but can you provide a
bit more background on the reservations and stuff?
-Greg
