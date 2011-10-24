From: Christian Brunner <chb@muc.de>
Subject: Re: ceph on non-btrfs file systems
Date: Mon, 24 Oct 2011 18:22:42 +0200
Message-ID: <CAO47_-9jp===DT=scpe=U8BnPnUCAVz7xUWVCC9AMVmx67CdaA@mail.gmail.com>
References: <Pine.LNX.4.64.1110231739380.25255@cobra.newdream.net>
Reply-To: chb@muc.de
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46535 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932276Ab1JXQWn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Oct 2011 12:22:43 -0400
Received: by vws1 with SMTP id 1so4620886vws.19
        for <ceph-devel@vger.kernel.org>; Mon, 24 Oct 2011 09:22:43 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.1110231739380.25255@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

Thanks for explaining this. I don't have any objections against btrfs
as a osd filesystem. Even the fact that there is no btrfs-fsck doesn't
scare me, since I can use the ceph replication to recover a lost
btrfs-filesystem. The only problem I have is, that btrfs is not stable
on our side and I wonder what you are doing to make it work. (Maybe
it's related to the load pattern of using ceph as a backend store for
qemu).

Here is a list of the btrfs problems I'm having:

- When I run ceph with the default configuration (btrfs snaps enabled)
I can see a rapid increase in Disk-I/O after a few hours of uptime.
Btrfs-cleaner is using more and more time in
btrfs_clean_old_snapshots().
- When I run ceph with btrfs snaps disabled, the situation is getting
slightly better. I can run an OSD for about 3 days without problems,
but then again the load increases. This time, I can see that the
ceph-osd (blkdev_issue_flush) and btrfs-endio-wri are doing more work
than usual.

Another thing is that I'm seeing a WARNING: at fs/btrfs/inode.c:2114
from time to time. Maybe it's related to the performance issues, but
seems to be able to verify this.

It's really sad to see, that ceph performance and stability is
suffering that much from the underlying filesystems and that this
hasn't changed over the last months.

Kind regards,
Christian

2011/10/24 Sage Weil <sage@newdream.net>:
> Although running on ext4, xfs, or whatever other non-btrfs you want m=
ostly
> works, there are a few important remaining issues:
>
> 1- ext4 limits total xattrs for 4KB. =A0This can cause problems in so=
me
> cases, as Ceph uses xattrs extensively. =A0Most of the time we don't =
hit
> this. =A0We do hit the limit with radosgw pretty easily, though, and =
may
> also hit it in exceptional cases where the OSD cluster is very unheal=
thy.
>
> There is a large xattr patch for ext4 from the Lustre folks that has =
been
> floating around for (I think) years. =A0Maybe as interest grows in ru=
nning
> Ceph on ext4 this can move upstream.
>
> Previously we were being forgiving about large setxattr failures on e=
xt3,
> but we found that was leading to corruption in certain cases (because=
 we
> couldn't set our internal metadata), so the next release will assert/=
crash
> in that case (fail-stop instead of fail-maybe-eventually-corrupt).
>
> XFS does not have an xattr size limit and thus does have this problem=
=2E
>
> 2- The other problem is with OSD journal replay of non-idempotent
> transactions. =A0On non-btrfs backends, the Ceph OSDs use a write-ahe=
ad
> journal. =A0After restart, the OSD does not know exactly which transa=
ctions
> in the journal may have already been committed to disk, and may reapp=
ly a
> transaction again during replay. =A0For most operations (write, delet=
e,
> truncate) this is fine.
>
> Some operations, though, are non-idempotent. =A0The simplest example =
is
> CLONE, which copies (efficiently, on btrfs) data from one object to
> another. =A0If the source object is modified, the osd restarts, and t=
hen
> the clone is replayed, the target will get incorrect (newer) data. =A0=
=46or
> example,
>
> 1- clone A -> B
> 2- modify A
> =A0 <osd crash, replay from 1>
>
> B will get new instead of old contents.
>
> (This doesn't happen on btrfs because the snapshots allow us to repla=
y
> from a known consistent point in time.)
>
> For things like clone, skipping the operation of the target exists al=
most
> works, except for cases like
>
> 1- clone A -> B
> 2- modify A
> ...
> 3- delete B
> =A0 <osd crash, replay from 1>
>
> (Although in that example who cares if B had bad data; it was removed
> anyway.) =A0The larger problem, though, is that that doesn't always w=
ork;
> CLONERANGE copies a range of a file from A to B, where B may already
> exist.
>
> In practice, the higher level interfaces don't make full use of the
> low-level interface, so it's possible some solution exists that caref=
ul
> avoids the problem with a partial solution in the lower layer. =A0Thi=
s makes
> me nervous, though, as it is easy to break.
>
> Another possibility:
>
> =A0- on non-btrfs, we set a xattr on every modified object with the
> =A0 op_seq, the unique sequence number for the transaction.
> =A0- for any (potentially) non-idempotent operation, we fsync() befor=
e
> =A0 continuing to the next transaction, to ensure that xattr hits dis=
k.
> =A0- on replay, we skip a transaction if the xattr indicates we alrea=
dy
> =A0 performed this transaction.
>
> Because every 'transaction' only modifies on a single object (file),
> this ought to work. =A0It'll make things like clone slow, but let's f=
ace it:
> they're already slow on non-btrfs file systems because they actually =
copy
> the data (instead of duplicating the extent refs in btrfs). =A0And it=
 should
> make the full ObjectStore iterface safe, without upper layers having =
to
> worry about the kinds and orders of transactions they perform.
>
> Other ideas?
>
> This issue is tracked at http://tracker.newdream.net/issues/213.
>
> sage
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
