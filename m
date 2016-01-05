From: Samuel Just <sjust@redhat.com>
Subject: Re: Long peering - throttle at FileStore::queue_transactions
Date: Mon, 4 Jan 2016 17:17:25 -0800
Message-ID: <CAN=+7FVS7CUvBf+7cb+89R_gWhi=SRcZBGa3N9ZcKH3MXimNdw@mail.gmail.com>
References: <CAKtk8hdb1dTJ013Qed1D9Wu_wWNvTM9H0hjqg2PGVr9xBnt51g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f179.google.com ([209.85.213.179]:34168 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753688AbcAEBRZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Jan 2016 20:17:25 -0500
Received: by mail-ig0-f179.google.com with SMTP id ik10so3607784igb.1
        for <ceph-devel@vger.kernel.org>; Mon, 04 Jan 2016 17:17:25 -0800 (PST)
In-Reply-To: <CAKtk8hdb1dTJ013Qed1D9Wu_wWNvTM9H0hjqg2PGVr9xBnt51g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guang Yang <guangyy@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>

We need every OSDMap persisted before persisting later ones because we
rely on there being no holes for a bunch of reasons.

The deletion transactions are more interesting.  It's not part of the
boot process, these are deletions resulting from merging in a log from
a peer which logically removed an object.  It's more noticeable on
boot because all PGs will see these operations at once (if there are a
bunch of deletes happening).  We need to process these transactions
before we can serve reads (before we activate) currently since we use
the on disk state (modulo the objectcontext locks) as authoritative.
That transaction iirc also contains the updated PGLog.  We can't avoid
writing down the PGLog prior to activation, but we *can* delay the
deletes (and even batch/throttle them) if we do some work:
1) During activation, we need to maintain a set of to-be-deleted
objects.  For each of these objects, we need to populate the
objectcontext cache with an exists=false objectcontext so that we
don't erroneously read the deleted data.  Each of the entries in the
to-be-deleted object set would have a reference to the context to keep
it alive until the deletion is processed.
2) Any write operation which references one of these objects needs to
be preceded by a delete if one has not yet been queued (and the
to-be-deleted set updated appropriately).  The tricky part is that the
primary and replicas may have different objects in this set...  The
replica would have to insert deletes ahead of any subop (or the ec
equilivant) it gets from the primary.  For that to work, it needs to
have something like the obc cache.  I have a wip-replica-read branch
which refactors object locking to allow the replica to maintain locks
(to avoid replica-reads conflicting with writes).  That machinery
would probably be the right place to put it.
3) We need to make sure that if a node restarts anywhere in this
process that it correctly repopulates the set of to be deleted
entries.  We might consider a deleted-to version in the log?  Not sure
about this one since it would be different on the replica and the
primary.

Anyway, it's actually more complicated than you'd expect and will
require more design (and probably depends on wip-replica-read
landing).
-Sam

On Mon, Jan 4, 2016 at 3:32 PM, Guang Yang <guangyy@gmail.com> wrote:
> Hi Cephers,
> Happy New Year! I got question regards to the long PG peering..
>
> Over the last several days I have been looking into the *long peering*
> problem when we start a OSD / OSD host, what I observed was that the
> two peering working threads were throttled (stuck) when trying to
> queue new transactions (writing pg log), thus the peering process are
> dramatically slow down.
>
> The first question came to me was, what were the transactions in the
> queue? The major ones, as I saw, included:
>
> - The osd_map and incremental osd_map, this happens if the OSD had
> been down for a while (in a large cluster), or when the cluster got
> upgrade, which made the osd_map epoch the down OSD had, was far behind
> the latest osd_map epoch. During the OSD booting, it would need to
> persist all those osd_maps and generate lots of filestore transactions
> (linear with the epoch gap).
>> As the PG was not involved in most of those epochs, could we only take and persist those osd_maps which matter to the PGs on the OSD?
>
> - There are lots of deletion transactions, and as the PG booting, it
> needs to merge the PG log from its peers, and for the deletion PG
> entry, it would need to queue the deletion transaction immediately.
>> Could we delay the queue of the transactions until all PGs on the host are peered?
>
> Thanks,
> Guang
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
