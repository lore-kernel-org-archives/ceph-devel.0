From: Sage Weil <sage@newdream.net>
Subject: Re: question about snapset
Date: Fri, 3 Feb 2017 14:05:16 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1702031359260.3660@piezo.novalocal>
References: <CAB7xdi=b=HxAepvKna-Rfi9z9Wd+SAxADsbZUkYk-TuEkYJnjA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33292 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752346AbdBCOFU (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 3 Feb 2017 09:05:20 -0500
In-Reply-To: <CAB7xdi=b=HxAepvKna-Rfi9z9Wd+SAxADsbZUkYk-TuEkYJnjA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: sheng qiu <herbert1984106@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 2 Feb 2017, sheng qiu wrote:
> Hi cephers,
> 
> We are reading the codes of Ceph I/O path. We found within the
> do_op(), it tries to get the object context each time as well as the
> snapset context.
> 
> may i ask what's the usage of the snapset context and what's the
> relationship between snapset context and the individual object? Does
> each object has a snapset context ? Does it stores as attribute within
> the onode that associated with the object?
> i read some articles said only head object has snapset context, may i
> ask what's the head object and what's the relationship between a head
> object and other non-head objects?

A given logical object may be contained by several snapshots, and we'll 
have a separate clone for each unique version of the object. The 
head (snapid == CEPH_NOSNAP) is the latest read/write version of the 
object.  A clone (snapid < CEPH_NOSNAP) is the version for some number of 
snapshots.  For example, if you wrote X, took snapshot 1, write X', wrote 
X'', took snap 2, took snap 3, then wrote X''', you'd have 3 clones with 
something like

X    (snapid 1) snaps=[1]
X''  (snapid 3) snaps=[2,3]
X''' (head) clones=[1,2]

The SnapSet is attached to the head and tells us we have 2 clones (1 and 
3).  Each clone has a snaps vector that tells us which snaps it exists in.  
There's some other bookkeeping in SnapSet as well that tells us what data 
extents are identical across adjacent clones (so that they can share 
blocks on disk efficiently).

There's one annoying oddity that if the head doesn't logically exist we 
create an object with snapid CEPH_SNAPDIR and attach the SnapSet to 
that.  We hope to remove this soon (by storing SnapSet on head and marking 
head as a whiteout) as it complicates the code.

Hope that helps!
sage
