From: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Subject: Re: Fix local messages and lost wake-up in SimpleMessenger
Date: Tue, 14 Aug 2012 15:50:21 -0300
Message-ID: <orsjbpxq8i.fsf@livre.localdomain>
References: <or7gt2ypox.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lsd-gw.ic.unicamp.br ([143.106.7.165]:38135 "EHLO
	boneca.lsd.ic.unicamp.br" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757254Ab2HNSu1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Aug 2012 14:50:27 -0400
Received: from freie (gw-to-emilia.oliva.athome.lsd.ic.unicamp.br [172.31.160.17] (may be forged))
	by boneca.lsd.ic.unicamp.br (8.14.5/8.14.5) with ESMTP id q7EIoOGA001551
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 15:50:25 -0300
Received: from livre.localdomain (livre-to-gw.oliva.athome.lsd.ic.unicamp.br [172.31.160.19])
	by freie (8.14.5/8.14.5) with ESMTP id q7EIoN6u007367
	for <ceph-devel@vger.kernel.org>; Tue, 14 Aug 2012 15:50:24 -0300
In-Reply-To: <or7gt2ypox.fsf@livre.localdomain> (Alexandre Oliva's message of
	"Tue, 14 Aug 2012 01:55:11 -0300")
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Aug 14, 2012, Alexandre Oliva <oliva@lsd.ic.unicamp.br> wrote:

> Don't wait for a signal if the dispatch queue is non-empty already,
> and support a non-NULL pipe for local responses.  If we were to
> require pipe to be NULL for that, the response would be lost.

Although this patch applies to 0.50, I developed it on 0.48argonaut, I
failed to mention.  It occurred to me that I haven't even tried to
duplicate on 0.50 the problem I'd observed consistently on 0.48, namely,
that accessing (stat) hardlinks that were not in the MDS cache would
hard-block the client, because the MDS would issue an archortable
request to itself, and the response wouldn't find its way back.

At first, I thought the response had been queued but not picked up
because it would be signalled before the dispatcher returned and
Wait()ed for the signal, so it could be a lost wake-up race condition.
That turned out to not fix the problem, but I figured I'd leave the hunk
in, for it appeared to make sense on its own (the spelling of the
empty() call is different in 0.50 and 0.48, FWIW).

> -    if (!stop)
> +    if (queued_pipes.empty() && !stop)
>        cond.Wait(lock); //wait for something to be put on queue


Debugging further, I noticed that the anchortable request was issued the
first time (and never re-issued, for the request remained in the pending
queue), but the response didn't make it back: it was handled as a remote
request, rather than a local one, because we find a pipe at the time of
posting the response.  However, since there aren't threads for such
local pipes, the response is AFAICT queued but never sent.  Once I
enabled the destination for the response to be recognized as local in
spite of the existence of the pipe, the response found its way back to
the (local) requester and the client didn't hang any more.  At that
point, I stopped digging.

>    // local?
> -  if (!pipe && my_inst.addr == dest_addr) {
> +  if (my_inst.addr == dest_addr) {


I ran a 0.48 with this (or rather the equivalent) change for a bit, then
upgraded to 0.50, ported the patches, tested them for a bit, and posted
the patches.  The client hang was 100% reproducible with the unpatched
0.48, as long as the hardlinked inode was out of the MDS cache, and it
could only be temporarily averted by accessing the hardlinked file by
another name that, I suppose, didn't require a self-request of
anchortable lookup.  After the patch, the problem is gone for good.

-- 
Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
You must be the change you wish to see in the world. -- Gandhi
Be Free! -- http://FSFLA.org/   FSF Latin America board member
Free Software Evangelist      Red Hat Brazil Compiler Engineer
