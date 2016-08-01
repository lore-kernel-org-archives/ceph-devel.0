From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: snapshot implementation problems/options
Date: Mon, 1 Aug 2016 06:52:22 -0700
Message-ID: <CAJ4mKGbPhW_QefWtUCr-c8j5MM1Th6pvncybo+iyoj1Rd5mSJw@mail.gmail.com>
References: <CAJ4mKGbf-zvTkZaqqsZDOA=ZrCsq=WRP80DM3wQpXcOWxYX-hg@mail.gmail.com>
 <alpine.DEB.2.11.1607281928430.1098@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:34333 "EHLO
	mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbcHAOAR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Aug 2016 10:00:17 -0400
Received: by mail-ua0-f180.google.com with SMTP id 35so106710433uap.1
        for <ceph-devel@vger.kernel.org>; Mon, 01 Aug 2016 07:00:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1607281928430.1098@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>, John Spray <jspray@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Zheng Yan <zyan@redhat.com>

On Mon, Aug 1, 2016 at 12:48 AM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 25 Jul 2016, Gregory Farnum wrote:
>> Now that we've got a stable base filesystem, we're thinking about how
>> to enable and support long-term the "add-on" features. I've lately
>> been diving into our snapshot code and thinking about alternatives
>> that might be easier to implement and debug (we've had snapshots
>> "basically working" for a long time, and Zheng has made them a lot
>> more reliable, but they still have some issues especially with
>> multi-mds stuff).
>>
>> I sent in a PR (https://github.com/ceph/ceph/pull/10436) with some
>> basic snapshot documentation, and you may have seen my email on
>> ceph-users about the expected semantics. This is to discuss in a
>> little more detail some of the pieces I've run into that are hard, and
>> the alternatives.
>>
>> Perhaps the most immediately fixable problem is the "past_parents"
>> links I reference there. When generating the snapids for a SnapContext
>> we look at our local SnapRealm *and* all of its past_parents to
>> generate the complete list. As a consequence, you need to have *all*
>> of the past_parents loaded in memory when doing writes. :( We've had a
>> lot of bugs, at least one remains, and I don't know how much are
>> unfound.
>> Luckily, this is fairly simple to solve: when we create a new
>> SnapRealm, or move it or anything, we can merge its ancestral snapids
>> into the local SnapRealm's list (ie, into the list of snaps in the
>> associated sr_t on-disk). It looks to be so easy a change that tfter
>> going through the code, I'm a little baffled that wasn't the design to
>> begin with! (The trade-off is that on-disk inode structures which
>> frequently move through SnapRealms will get a little larger. I can't
>> imagine it being a big deal, especially in comparison to forcing all
>> the snap parent inodes to be pinned in the cache.)
>
> +1
>
>> The other big source of bugs in our system is more diffuse, but also
>> all for one big feature: we asynchronously flush snapshot data (both
>> file data to the OSDs and metadata caps to the MDS). If we were trying
>> to ruthlessly simplify things, I'd want to eliminate all that code in
>> favor of simply forcing synchronous writeback when taking a snapshot.
>> I haven't worked through all the consequences of it yet (probably it
>> would involve a freeze on the tree and revoking all caps?) but I'd
>> expect it to reduce the amount of code and complication by a
>> significant amount. I'm inclined to attempt this but it depends on
>> what snapshot behavior we consider acceptable.
>
> I would be inclined to keep the async behavior here despite the
> complexity.  Unless there are fundamental issues we can't fix I think the
> complexity is worth it.

Ha. We talked about this in standup last week and came to the
conclusion that we actually prefer synchronous flushes, because they
make the data loss semantics easier for users to understand. Sync
snaps seem similarly necessary if an HPC machine were using them for
checkpoints. Can you talk about the advantages of async snaps?


>
>> =============
>>
>> The last big idea I'd like to explore is changing the way we store
>> metadata. I'm not sure about this one yet, but I find the idea of
>> taking actual RADOS snapshots of directory objects, instead of copying
>> the dentries. If we force clients to flush out all data during a
>> snapshot, this becomes pretty simple; it's much harder if we try and
>> maintain async flushing.
>>
>> Upsides: we don't "pollute" normal file IO with the snapshotted
>> entries. Clean up of removed snapshots happens OSD-side with less MDS
>> work. The best part: we can treat snapshot trees and read activity as
>> happening on entirely separate but normal pieces of the metadata
>> hierarchy, instead of on weird special-rule snapshot IO (by just
>> attaching a SnapContext to all the associated IO, instead of tracking
>> which dentry the snapid applies to, which past version we should be
>> reading, etc).
>>
>> Downsides: when actually reading snapshot data, there's more
>> duplication in the cache. The OSDs make some attempt at efficient
>> copy-on-write of omap data, but it doesn't work very well on backfill,
>> so we should expect it to take more disk space. And as I mentioned, if
>> we don't do synchronous snapshots, then it would take some extra
>> machinery to make sure we flush data out in the right order to make
>> this work.
>
> What if we keep async snap flushes, but separate out snapped metadata in a
> different dirfrag.. either a snap of the same object or a different
> object.  We would need to wait until all the snap cap flushes came in
> before writing it out, so the simplest approach would probably be to
> create all of the dentries/inodes in the cache and mark it dirty, and
> defer writing the dirfrag until the last cap flush comes in.  If we do a
> snap of the same dirfrag, we additionally need to defer any writes to
> newer dirfrags too (bc we have to write to rados is chronological order
> for that object).  That's annoying, but possibly worth it to avoid having
> to do cleanup.
>
> All of the complicated 'follows' stuff isn't going to go away,
> though--it'll just switch change from a dentry to a dirfrag property.
>
>> =============
>>
>> Side point: hard links are really unpleasant with our snapshots in
>> general. Right now snapshots apply to the primary link, but not to
>> others. I can't think of any good solutions: the best one so far
>> involves moving the inode (either logically or physically) out of the
>> dentry, and then setting up logic similar to that used for
>> past_parents and open_snap_parents() whenever you open it from
>> anywhere. :( I've about convinced myself that's just a flat
>> requirement (unless we want to go back to having a global lookup table
>> for all hard links!), but if anybody has alternatives I'd love to hear
>> them...
>
> IMO the current "sloppy" semantics (snapshot applies to first/primary
> link) are good enough.  Hard links are pretty rare, and often in the same
> directory anyway.  I agree that to solve it properly the file needs its
> own snaprealm, which is pretty annoying.

Mmm. It's true that they're rare, but it's also a very surprising
behavior for users that's hard to explain. Maybe as an interim measure
we could disallow creating snapshots at directories which have a
traversing hard link? I think I've worked out how to do that
reasonably efficiently.
-Greg
