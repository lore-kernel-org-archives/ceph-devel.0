From: Jeff Layton <jlayton@poochiereds.net>
Subject: Re: lingering caps outstanding after client shutdown?
Date: Tue, 26 Sep 2017 13:34:32 -0400
Message-ID: <1506447272.2552.7.camel@poochiereds.net>
References: <1506432289.3182.16.camel@redhat.com>
         <alpine.DEB.2.11.1709261330380.27895@piezo.novalocal>
         <1506434813.3182.27.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f175.google.com ([209.85.216.175]:46867 "EHLO
        mail-qt0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031084AbdIZReh (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Sep 2017 13:34:37 -0400
Received: by mail-qt0-f175.google.com with SMTP id s18so11129505qta.3
        for <ceph-devel@vger.kernel.org>; Tue, 26 Sep 2017 10:34:37 -0700 (PDT)
In-Reply-To: <1506434813.3182.27.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: "open list:CEPH DISTRIBUTED..." <ceph-devel@vger.kernel.org>

On Tue, 2017-09-26 at 10:06 -0400, Jeff Layton wrote:
> On Tue, 2017-09-26 at 13:31 +0000, Sage Weil wrote:
> > On Tue, 26 Sep 2017, Jeff Layton wrote:
> > > In order to get the correct semantics for a delegation or oplock,
> > 
> > we
> > > need to be able to break delegations on open.
> > 
> > Can you explain this part?  How do the delegation/oplock semantics
> > relate 
> > to open(2)?  I would assume they are related to reads and writes (and
> > data 
> > consistency).  Unless it's a CIFS thing?
> 
> 
> You're correct that we only really need to break delegations on
> conflicting access, but there is a problem here:
> 
> NFS clients can cache shared/deny mode locks if they hold a delegation.
> Once you've granted an open, it's too late to go back and enforce it
> once you go to recall the delegation.
> 
> Since we don't enforce deny mode locks in cephfs, we could argue that
> all of that is the purview of the NFS server and not worry about
> it...at least until we toss something like samba into the mix, at which
> point things get a bit more complicated...
> 

After some discussion with Sage on IRC, I think I understand what's
going on now.

The issue is that Client::get_caps doesn't actually request any caps.
It just waits on the needed caps, under the assumption that you've
already requested the ones you need via an earlier call.

In this case, the file already existed before the client connected, and
there is no interaction with the file by that client prior to the open.
 There is no reason that the MDS thinks that the client wants any caps
for this file, and so the call hangs waiting on caps that will never
arrive.

I've been able to fix the patch by having it call get_caps after the
open call. With that, the MDS knows that the client is holding the file
open, and so will want Fr and/or Fw caps for that. That's sufficient to
satisfy the right delegation break semantic.

The upshot here is that this isn't a bug, after all...

Cheers,
-- 
Jeff Layton <jlayton@poochiereds.net>
