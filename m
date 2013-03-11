From: Joao Eduardo Luis <joao.luis@inktank.com>
Subject: Comments on Ceph.com's blog article 'Ceph's New Monitor Changes'
Date: Mon, 11 Mar 2013 12:04:03 +0000
Message-ID: <513DC833.9090806@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:38745 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753735Ab3CKMEz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Mar 2013 08:04:55 -0400
Received: by mail-ee0-f50.google.com with SMTP id e51so2172484eek.23
        for <ceph-devel@vger.kernel.org>; Mon, 11 Mar 2013 05:04:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: florian@hastexo.com, Greg Farnum <greg@inktank.com>

Last Friday, Florian Haas (CC'ed) commented with regard to the Monitor=20
changes blog post [1] on Google+ [2].  This is a transcription of the=20
resulting thread, in which Greg (CC'ed) also participated, and I am now=
=20
cross-posting it to the list for the benefit of the larger community on=
=20
ceph-devel that might not stumble upon the post (although it is public=20
and should not require a G+ account).


[1] - http://ceph.com/dev-notes/cephs-new-monitor-changes/
[2] - https://plus.google.com/110443614427234590648/posts/iuxSyCC5aJp


   -Joao


> Florian Haas on Mar 8, 2013 wrote:
>
> Good to see more Ceph developers providing their insight on recent
> and ongoing codebase changes.
>
> +Joao Eduardo Luis, I have a comment about the transition from the
> file-backed mon store to a leveldb k/v store. As the original
> reporter of   http://tracker.ceph.com/issues/2752, I'm always
> wondering how to best recover if any issue simultaneously bringing
> down all mons were ever to happen again. At the time, +Gregory
> Farnum's suggestion for recovery
> (http://marc.info/?l=3Dceph-devel&m=3D134151077312444&w=3D2) involved
> manipulating files in the mon data directory manually; I wonder if
> the leveldb approach makes this easier or harder.
>
> It tends to be a common source of discomfort among potential Ceph
> users that if their mons ever become unrecoverable, it's almost
> impossible to recover your data (compare to GlusterFS, where you can
> always pull data out of Gluster bricks unharmed, at least as long as
> you don't use striping volumes). With a file backed mon store, I had
> hoped that eventually this might tie into btrfs snapshots such that
> you would have been able to roll back to a known good configuration
> in an emergency. With the switch to leveldb, I no longer foresee that
> ever happening. Mind sharing your thoughts on that?


> Gregory Farnum on Mar 8, 2013 wrote:
>
> Actually LevelDB snapshots just fine.
>
> I'll leave the rest for Joao, or me after I've been awake for more
> than a minute. :)=EF=BB=BF


> Florian Haas on Mar 8, 2013 wrote:
>
> Thanks. So leveldb updates are always atomic, consistent, isolated
> and durable?
>
> Also, do the mons open level leveldb fd with O_SYNC, or do they
> periodically do fsync() or fdatasync()?=EF=BB=BF


> Gregory Farnum on Mar 8, 2013 wrote:
 >
> I'm not entirely sure -- leveldb handles all that stuff on its own
> and  provides the right guarantees at the interface level, so I assum=
e its
> doing those things on its own. ;)
> (In particular it's actually a hierarchy, not a single file.)=EF=BB=BF


> Joao Eduardo Luis on Mar 9, 2013 wrote:
>
> When it comes to manipulating the contents of the store, yeah, it's
> harder now. You'll need a tool that speaks leveldb for that. Which IM=
O
> can actually be nice if we have a tool that allows one to perform min=
or
> incursions in the store in a somewhat automated fashion (say, revert =
to
> an older osdmap) -- and creating a tool to change the store's content=
s
> isn't hard to do either, we just didn't get around to put it together
> (there's one however to read the store's contents, adapting it should=
 be
> easy).
>
> And I can see the discomfort in having the mon store on leveldb inste=
ad
> of the FS. I had never thought about backing up the mon store resorti=
ng
> to, say, btrfs snapshots, as I've been approaching it on a 'distribut=
ed
> is path to success' and maintaining multiple mons around. So I guess
> that it also might make things harder, if btrfs snapshots (or any oth=
er
> snapshot tools for that matter) don't play nice with leveldb (or
> vice-versa). I looked on the internets for a potential solution, and =
it
> looks like someone at stackoverflow [1] recommended performing some
> copies and creating some hard links of some of leveldb's contents to
> achieve that -- it's not a pretty solution and would require the moni=
tor
> to block accesses to the store while performing such operation.
>
> Also, it is worth to mention that leveldb does support snapshots, but
> they will all be lost after leveldb is closed, so there's no gain fro=
m
> such support when attempting to create checkpoints (unless there's
> something I've missed altogether and this is in fact possible!).
> Furthermore, operations are applied in batches (we have a nifty
> interface that abstracts them as transactions, but they're not really
> ACID transactions, although they benefit from Atomicity, Durability a=
nd
> some form of Consistency and limited Isolation [2]), and we force the=
m
> to be written synchronously to leveldb. This basically means that if =
the
> whole batch successfully reaches the disk, everything should be okay;=
 if
> the system crashes sometime in the middle of it, leveldb will
> automatically ignore partial writes, and for a batch of operations th=
at
> will mean the whole batch.
>
> By the way, I believe this discussion should be moved to ceph-devel, =
as
> it can be beneficial to other members of the community. If no one
> objects, I will do as such later today.
>
> [1] - http://goo.gl/7HSCH
> [2] - Atomicity is internally guaranteed by leveldb, resorting to the=
ir
> own magic; Consistency as well, guaranteed by ignoring partial writes=
 if
> a system should fail, but leveldb mostly leaves it up to the user wrt
> how things are flushed to disk; Isolation is fairly limited: you can
> only have one process accessing leveldb at each time, but multiple
> threads can do as they please, and although leveldb will take care of
> most of the required synchronization, some thought should still go in=
to
> that; and Durability is said to be configurable, but I have no idea w=
hat
> that means -- am yet to find a way to make not durable, not that I
> really need it, but would be nice to know. :-)=EF=BB=BF

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
