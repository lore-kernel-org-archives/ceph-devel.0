From: Douglas Fuller <dfuller@redhat.com>
Subject: Re: A design for CephFS forward scrub with multiple MDS
Date: Wed, 21 Sep 2016 06:58:49 -0400
Message-ID: <448CAE51-31E6-43FD-9BF0-CDEEA982493E@redhat.com>
References: <45C6F82E-6242-41CE-BBA6-1F5200E0B9BC@redhat.com>
 <CAJ4mKGYo+P3JHH4OyzdAtmfx5JaMCT+xCzPLA45=BK50KJLAhg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 10.0 \(3226\))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f51.google.com ([209.85.214.51]:37799 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755939AbcIUK6v (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 06:58:51 -0400
Received: by mail-it0-f51.google.com with SMTP id 186so46461739itf.0
        for <ceph-devel@vger.kernel.org>; Wed, 21 Sep 2016 03:58:51 -0700 (PDT)
In-Reply-To: <CAJ4mKGYo+P3JHH4OyzdAtmfx5JaMCT+xCzPLA45=BK50KJLAhg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>


> On Sep 21, 2016, at 2:29 AM, Gregory Farnum <gfarnum@redhat.com> wrote:
> 
> On Tue, Sep 20, 2016 at 10:16 AM, Douglas Fuller <dfuller@redhat.com> wrote:
>> 
>> When popping an inode from the scrub stack, it’s important to note that its authority may have been changed by some intervening export. The scrubbing MDS will drop any file inode for which it is no longer authoritative, assuming this would be handled by the correct MDS. For directory inodes, forward a request to the authoritative MDS to scrub the directory. This may result in attempts to scrub the same inodes more than once (though we track this and can avoid most of the work), it seems necessary in order to guarantee no directories are missed due to splits or exports (NB: this is correct, right?).
> 
> I think we need to spell this out a little more. Some thoughts:
> * right now, the ScrubStack is just a CInode*. This needs to turn into
> a two-way reference.

I wasn’t at the datatype level of detail here. I agree it can’t be a CInode* anymore, and figured it’d have to be something we could fetch if it is exported while on the stack.

> * When we freeze a tree for export, we need a new step that removes it
> from the ScrubStack and sets up the "remote scrub" state we'd have if
> it were a freshly-encountered subtree boundary
>  * this may involve some delayed execution of remote scrub requests,
> or of bundling up the need for a scrub in the exported state

Directories don’t know where their subtree roots are, so I’m not sure how we would remove subdirectories and their contained files from the stack if one of their parents were exported. I think the stack could be “dumb” in some sense and not care what happens to the items on it. If we pop a file inode for which we are not authoritative, we drop it on the floor, assuming its parent directory will cause it to be scrubbed elsewhere. If we pop a directory inode for which we are not authoritative, we send a request to the authoritative MDS to scrub it.

Some duplicate work is created here since a subtree could be exported and then we will end up requesting multiple scrub operations (which could race one another) in the same directory hierarchy. That’s inefficient, but can be handled fairly well by the existing code. If we want to avoid that, we could either:
* When we pop a directory inode for which we are not authoritative, trace back to the nearest subtree root. We would need to maintain state for that subtree root anyway, so that could be checked to avoid duplication of work.
* Create a wrapper data structure for scrubbing a given subtree and link scrub stack elements back to that. The problem would then be maintaining that data structure in the face of subtree changes.

>> Outbound scrub requests will need to be tracked and restarted in the case of MDS failure.
>> 
>> It may be the case that, in the case of a badly thrashing directory hierarchy, that many unnecessary sub-scrub requests may be created and duplicate work attempted. We can short-circuit the duplicate work by noting (as we do in the single-MDS case) when we have already scrubbed an inode and bailing when we attempt to do it again. I’m not sure that extra or unnecessary requests are avoidable or if they will pose a serious performance concern.
> 
> I think a good design won't let this be much a problem. If subtrees
> move continuously we might have to "chase" the scrub (which perhaps
> argues for sending the scrub state along with the metadata export),
> but otherwise more fragmentation will require more messages but the
> system should handle that (it will presumably be constant state at the
> boundaries).
> -Greg

