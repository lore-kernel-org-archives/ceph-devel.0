From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: A design for CephFS forward scrub with multiple MDS
Date: Tue, 20 Sep 2016 23:29:24 -0700
Message-ID: <CAJ4mKGYo+P3JHH4OyzdAtmfx5JaMCT+xCzPLA45=BK50KJLAhg@mail.gmail.com>
References: <45C6F82E-6242-41CE-BBA6-1F5200E0B9BC@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f179.google.com ([209.85.161.179]:35184 "EHLO
        mail-yw0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbcIUG3Z (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Sep 2016 02:29:25 -0400
Received: by mail-yw0-f179.google.com with SMTP id u82so36998945ywc.2
        for <ceph-devel@vger.kernel.org>; Tue, 20 Sep 2016 23:29:25 -0700 (PDT)
In-Reply-To: <45C6F82E-6242-41CE-BBA6-1F5200E0B9BC@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, John Spray <jspray@redhat.com>

On Tue, Sep 20, 2016 at 10:16 AM, Douglas Fuller <dfuller@redhat.com> wrote:
> This serves to assemble some discussions we’ve had recently surrounding performing CephFS forward scrub in the case of multiple, active MDSs. I have been doing some implementation work recently in this area and it became a large enough departure from current practice that it’s probably time to revisit the design altogether. This message is intended to summarize the discussions I’ve had so far and to serve as a straw man for any changes that may be needed. It contains a couple questions as well.
>
> Currently, CephFS forward scrub proceeds straightforwardly by enqueuing inodes onto a stack as they are found, completing each parent directory once all of its children have been scrubbed. In a multi-MDS system, this will need to be extended to handle subtrees present on other MDSs.
>
> The proposed design is as follows:
>
> We scrub a local subtree as we would in the single-MDS case: follow the directory hierarchy downward, pushing found items onto a stack and completing directories once all their children are complete. When a subtree boundary is encountered, send a message to the authoritative MDS for that subtree requesting that it be scrubbed. When subtree scrubbing is complete, send a message to the requesting MDS with the completion information and relevant rstats for the parent directory inode (NB: do we have to block the scrubbing of all ancestors, then?).
>
> When popping an inode from the scrub stack, it’s important to note that its authority may have been changed by some intervening export. The scrubbing MDS will drop any file inode for which it is no longer authoritative, assuming this would be handled by the correct MDS. For directory inodes, forward a request to the authoritative MDS to scrub the directory. This may result in attempts to scrub the same inodes more than once (though we track this and can avoid most of the work), it seems necessary in order to guarantee no directories are missed due to splits or exports (NB: this is correct, right?).

I think we need to spell this out a little more. Some thoughts:
* right now, the ScrubStack is just a CInode*. This needs to turn into
a two-way reference.
* When we freeze a tree for export, we need a new step that removes it
from the ScrubStack and sets up the "remote scrub" state we'd have if
it were a freshly-encountered subtree boundary
  * this may involve some delayed execution of remote scrub requests,
or of bundling up the need for a scrub in the exported state

> Outbound scrub requests will need to be tracked and restarted in the case of MDS failure.
>
> It may be the case that, in the case of a badly thrashing directory hierarchy, that many unnecessary sub-scrub requests may be created and duplicate work attempted. We can short-circuit the duplicate work by noting (as we do in the single-MDS case) when we have already scrubbed an inode and bailing when we attempt to do it again. I’m not sure that extra or unnecessary requests are avoidable or if they will pose a serious performance concern.

I think a good design won't let this be much a problem. If subtrees
move continuously we might have to "chase" the scrub (which perhaps
argues for sending the scrub state along with the metadata export),
but otherwise more fragmentation will require more messages but the
system should handle that (it will presumably be constant state at the
boundaries).
-Greg
