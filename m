From: Haomai Wang <haomai@xsky.com>
Subject: Re: ack vs commit
Date: Fri, 4 Dec 2015 10:57:28 +0800
Message-ID: <CACJqLyZ91jC6nhNp04usE5jzdoMN85c6t_H+A7LOSVhWH78wGg@mail.gmail.com>
References: <alpine.DEB.2.00.1512031641060.20799@cobra.newdream.net>
	<CAJ4mKGbwikMiRsYasu3Fg1RcrCq_5zKV8f1b4Qo5CCTANzjHNw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pu1apc01on0090.outbound.protection.outlook.com ([104.47.126.90]:11008
	"EHLO APC01-PU1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754894AbbLDC5o convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 3 Dec 2015 21:57:44 -0500
Received: by ioir85 with SMTP id r85so102741033ioi.1
        for <ceph-devel@vger.kernel.org>; Thu, 03 Dec 2015 18:57:28 -0800 (PST)
In-Reply-To: <CAJ4mKGbwikMiRsYasu3Fg1RcrCq_5zKV8f1b4Qo5CCTANzjHNw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Fri, Dec 4, 2015 at 9:39 AM, Gregory Farnum <gfarnum@redhat.com> wro=
te:
> On Thu, Dec 3, 2015 at 4:54 PM, Sage Weil <sweil@redhat.com> wrote:
>> From the beginning Ceph has had two kinds of acks for rados write/up=
date
>> operations: ack (indicating the operation is accepted, serialized, a=
nd
>> staged in the osd's buffer cache) and commit (indicating the write i=
s
>> durable).  The client, if it saw a failure on the OSD before getting=
 the
>> commit, would have to resend the write to the new or recovered OSD,
>> attaching the version it got with the original ack so that the
>> new/recovered OSD could preserve the order.  (This is what the
>> replay_window pool property is for.)
>>
>> The only user for this functionality is CephFS, and only when a file=
 is
>> opened for write or read/write by multiple clients.  When that happe=
ns,
>> the clients do all read/write operations synchronously with the OSDs=
, and
>> effectively things are ordered there, at the object.  The idea is/wa=
s to
>> avoid penalizing this sort of IO by waiting for commits when the cli=
ents
>> aren't actually asking for that--at least until they call f[data]syn=
c, at
>> which point the client will block and wait for the second commit rep=
lies
>> to arrive.
>>
>> In practice, this doesn't actually help: everybody runs the OSDs on =
XFS,
>> and FileStore has to do write-ahead journaling, which means that the=
se
>> operations are committed and durable before they are readable, and t=
he
>> clients only ever see 'commit' (and not 'ack' followed by 'commit')
>> (commit implies ack too).   If you run the OSD on btrfs, you might s=
ee
>> some acks (journaling and writes to the file system/page cache are d=
one in
>> parallel).
>>
>> With newstore/bluestore, the current implementation doesn't make any
>> attempt to make a write readable before it is durable.  This could b=
e
>> changed, but.. I'm not sure it's worth it.  For most workloads (RBD,=
 RGW)
>> we only care about making writes durable as quickly as possible, and=
 all
>> of the OSD optimization efforts are focusing on making this as fast =
as
>> possible.  Is there much marginal benefit to the initial ack?  It's =
only
>> the CephFS clients with the same file open from multiple hosts that =
might
>> see a small benefit.
>>
>> On the other hand, there is a bunch of code in the OSD and on the
>> client side to deal with the dual-ack behavior we could potentially =
drop.
>> Also, we are generating lots of extra messages on the backend networ=
k for
>> both ack and commit, even though the librados users don't usually ca=
re
>> (the clients don't get the dual acks unless they request them).
>>
>> Also, it is arguably Wrong and a Bad Thing that you could have clien=
t A
>> write to file F, client B reads from file F and sees that data, the =
OSD
>> and client A both fail, and when things recover client B re-reads th=
e same
>> portion of the file and sees the file content from before client A's
>> change.  The MDS is extremely careful about this on the metadata sid=
e: no
>> side-effects of one client are visible to any other client until the=
y are
>> durable, so that a combination MDS and client failure will never mak=
e
>> things appear to go back in time.
>>
>> Any opinions here?  My inclination is to remove the functionality (l=
ess
>> code, less complexity, more sane semantics), but we'd be closing the=
 door
>> on what might have been a half-decent idea (separating serialization=
 from
>> durability when multiple clients have the same file open for
>> read/write)...
>
> I've considered this briefly in the past, but I'd really rather we ke=
ep it:
>
> 1) While we don't make much use of it right now, I think it's a usefu=
l
> feature for raw RADOS users
>
> 2) It's an incredibly useful protocol semantic for future performance
> work of the sort that makes Sam start to cry, but which I find very
> interesting. Consider a future when RBD treats the OSDs more like a
> disk with a cache, and is able to send out operations to get them out
> of local memory, without forcing them instantly to permanent storage.
> Similarly, I think as soon as we have a backend that lets us use a bi=
t
> of 3D Crosspoint in a system, we'll wish we had this functionality
> again.
> (Likewise with CephFS, where many many users will have different
> consistency expectations thanks to NFS and other parallel FSes which
> really aren't consistent.)
>
> Maybe we just think it's not worth it and we'd rather throw this out.
> But the only complexity this really lets us drop is the OSD replay
> stuff (which realistically I can't assess) =E2=80=94 the dual acks is=
 not hard
> to work with, and doesn't get changed much anyway. If we drop this no=
w
> and decide to bring back any similar semantic in the future I think
> that'll be a lot harder than simply carrying it, both in terms of
> banging it back into the code, and especially in terms of getting it
> deployed to all the clients in the world again.

=46or performance side, the ack/commit replies will double the potentia=
l
message number which make fast_dispatch thread overload. If we can
reduce ack, I think it would make this problem disappear.

I check the codes to refresh my mind, I think it make sense for
users(rbd) disable ack wants. So we still has ack logic in osd side,
but we wan't reply ack if caller doesn't need. Since we already has
potential "need_ack" logic in message.

plz correct me if wrong

> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
