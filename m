From: Sage Weil <sage@inktank.com>
Subject: Re: Fix local messages and lost wake-up in SimpleMessenger
Date: Tue, 14 Aug 2012 15:49:36 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208141534040.18862@cobra.newdream.net>
References: <or7gt2ypox.fsf@livre.localdomain> <orsjbpxq8i.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:57605 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751863Ab2HNWth (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 18:49:37 -0400
In-Reply-To: <orsjbpxq8i.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

On Tue, 14 Aug 2012, Alexandre Oliva wrote:
> On Aug 14, 2012, Alexandre Oliva <oliva@lsd.ic.unicamp.br> wrote:
> 
> > Don't wait for a signal if the dispatch queue is non-empty already,
> > and support a non-NULL pipe for local responses.  If we were to
> > require pipe to be NULL for that, the response would be lost.
> 
> Although this patch applies to 0.50, I developed it on 0.48argonaut, I
> failed to mention.  It occurred to me that I haven't even tried to
> duplicate on 0.50 the problem I'd observed consistently on 0.48, namely,
> that accessing (stat) hardlinks that were not in the MDS cache would
> hard-block the client, because the MDS would issue an archortable
> request to itself, and the response wouldn't find its way back.
> 
> At first, I thought the response had been queued but not picked up
> because it would be signalled before the dispatcher returned and
> Wait()ed for the signal, so it could be a lost wake-up race condition.
> That turned out to not fix the problem, but I figured I'd leave the hunk
> in, for it appeared to make sense on its own (the spelling of the
> empty() call is different in 0.50 and 0.48, FWIW).
> 
> > -    if (!stop)
> > +    if (queued_pipes.empty() && !stop)
> >        cond.Wait(lock); //wait for something to be put on queue
> 
> 
> Debugging further, I noticed that the anchortable request was issued the
> first time (and never re-issued, for the request remained in the pending
> queue), but the response didn't make it back: it was handled as a remote
> request, rather than a local one, because we find a pipe at the time of
> posting the response.  However, since there aren't threads for such
> local pipes, the response is AFAICT queued but never sent.  Once I
> enabled the destination for the response to be recognized as local in
> spite of the existence of the pipe, the response found its way back to
> the (local) requester and the client didn't hang any more.  At that
> point, I stopped digging.

That's a nice bit of debugging!
 
> >    // local?
> > -  if (!pipe && my_inst.addr == dest_addr) {
> > +  if (my_inst.addr == dest_addr) {
> 
> 
> I ran a 0.48 with this (or rather the equivalent) change for a bit, then
> upgraded to 0.50, ported the patches, tested them for a bit, and posted
> the patches.  The client hang was 100% reproducible with the unpatched
> 0.48, as long as the hardlinked inode was out of the MDS cache, and it
> could only be temporarily averted by accessing the hardlinked file by
> another name that, I suppose, didn't require a self-request of
> anchortable lookup.  After the patch, the problem is gone for good.

Do you mind trying to reproduce this on the current master?  A quick 
inspection of the code makes me think this isn't present after the 
refactor, but I suspect it'll be quicker for you to reproduce than for me.  

BTW, if you have a script or anything you were using to test, that'd be 
great to add to our test suite.  Something like

  #!/bin/sh

  mkdir sub1
  touch sub1/a

  # put hardlink in separate dir so b lookup doesn't load a's inode
  mkdir sub2
  ln sub1/a sub2/b
 
  # push it out of the mds cache
  for dir in `seq 1 100` ; do
    mkdir $dir
    for file in `seq 1 100` ; do
      touch $dir/$file
    done
  done

  stat b

?

Thanks again!
sage
