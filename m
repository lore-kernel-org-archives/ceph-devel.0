From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: ack vs commit
Date: Thu, 3 Dec 2015 17:39:04 -0800
Message-ID: <CAJ4mKGbwikMiRsYasu3Fg1RcrCq_5zKV8f1b4Qo5CCTANzjHNw@mail.gmail.com>
References: <alpine.DEB.2.00.1512031641060.20799@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:33680 "EHLO
	mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753487AbbLDBjH convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 20:39:07 -0500
Received: by wmec201 with SMTP id c201so53414232wme.0
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 17:39:04 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1512031641060.20799@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Dec 3, 2015 at 4:54 PM, Sage Weil <sweil@redhat.com> wrote:
> From the beginning Ceph has had two kinds of acks for rados write/upd=
ate
> operations: ack (indicating the operation is accepted, serialized, an=
d
> staged in the osd's buffer cache) and commit (indicating the write is
> durable).  The client, if it saw a failure on the OSD before getting =
the
> commit, would have to resend the write to the new or recovered OSD,
> attaching the version it got with the original ack so that the
> new/recovered OSD could preserve the order.  (This is what the
> replay_window pool property is for.)
>
> The only user for this functionality is CephFS, and only when a file =
is
> opened for write or read/write by multiple clients.  When that happen=
s,
> the clients do all read/write operations synchronously with the OSDs,=
 and
> effectively things are ordered there, at the object.  The idea is/was=
 to
> avoid penalizing this sort of IO by waiting for commits when the clie=
nts
> aren't actually asking for that--at least until they call f[data]sync=
, at
> which point the client will block and wait for the second commit repl=
ies
> to arrive.
>
> In practice, this doesn't actually help: everybody runs the OSDs on X=
=46S,
> and FileStore has to do write-ahead journaling, which means that thes=
e
> operations are committed and durable before they are readable, and th=
e
> clients only ever see 'commit' (and not 'ack' followed by 'commit')
> (commit implies ack too).   If you run the OSD on btrfs, you might se=
e
> some acks (journaling and writes to the file system/page cache are do=
ne in
> parallel).
>
> With newstore/bluestore, the current implementation doesn't make any
> attempt to make a write readable before it is durable.  This could be
> changed, but.. I'm not sure it's worth it.  For most workloads (RBD, =
RGW)
> we only care about making writes durable as quickly as possible, and =
all
> of the OSD optimization efforts are focusing on making this as fast a=
s
> possible.  Is there much marginal benefit to the initial ack?  It's o=
nly
> the CephFS clients with the same file open from multiple hosts that m=
ight
> see a small benefit.
>
> On the other hand, there is a bunch of code in the OSD and on the
> client side to deal with the dual-ack behavior we could potentially d=
rop.
> Also, we are generating lots of extra messages on the backend network=
 for
> both ack and commit, even though the librados users don't usually car=
e
> (the clients don't get the dual acks unless they request them).
>
> Also, it is arguably Wrong and a Bad Thing that you could have client=
 A
> write to file F, client B reads from file F and sees that data, the O=
SD
> and client A both fail, and when things recover client B re-reads the=
 same
> portion of the file and sees the file content from before client A's
> change.  The MDS is extremely careful about this on the metadata side=
: no
> side-effects of one client are visible to any other client until they=
 are
> durable, so that a combination MDS and client failure will never make
> things appear to go back in time.
>
> Any opinions here?  My inclination is to remove the functionality (le=
ss
> code, less complexity, more sane semantics), but we'd be closing the =
door
> on what might have been a half-decent idea (separating serialization =
from
> durability when multiple clients have the same file open for
> read/write)...

I've considered this briefly in the past, but I'd really rather we keep=
 it:

1) While we don't make much use of it right now, I think it's a useful
feature for raw RADOS users

2) It's an incredibly useful protocol semantic for future performance
work of the sort that makes Sam start to cry, but which I find very
interesting. Consider a future when RBD treats the OSDs more like a
disk with a cache, and is able to send out operations to get them out
of local memory, without forcing them instantly to permanent storage.
Similarly, I think as soon as we have a backend that lets us use a bit
of 3D Crosspoint in a system, we'll wish we had this functionality
again.
(Likewise with CephFS, where many many users will have different
consistency expectations thanks to NFS and other parallel FSes which
really aren't consistent.)

Maybe we just think it's not worth it and we'd rather throw this out.
But the only complexity this really lets us drop is the OSD replay
stuff (which realistically I can't assess) =E2=80=94 the dual acks is n=
ot hard
to work with, and doesn't get changed much anyway. If we drop this now
and decide to bring back any similar semantic in the future I think
that'll be a lot harder than simply carrying it, both in terms of
banging it back into the code, and especially in terms of getting it
deployed to all the clients in the world again.
-Greg
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
