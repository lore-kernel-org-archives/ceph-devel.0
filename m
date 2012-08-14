From: Sage Weil <sage@inktank.com>
Subject: Re: Fix local messages and lost wake-up in SimpleMessenger
Date: Tue, 14 Aug 2012 09:00:02 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208140857400.18862@cobra.newdream.net>
References: <or7gt2ypox.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54898 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab2HNQAD (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 12:00:03 -0400
In-Reply-To: <or7gt2ypox.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

A huge pile of SimpleMessenger refactors, cleanups, and fixes (wip-msgr) 
was just merged into master, and this code was changed around quite a bit.  
Did you have a specific test case that was triggering the problem?  If so, 
do you mind running it on the current master?

Most of the cleanups/fixes were motivated by testing with socket failure 
injection enabled (e.g., 'ms inject socket failures = 500' to simulate a 
failure on every ~500th socket read or write).  This is being added to the 
rados regression test suite.

Thanks!
sage


On Tue, 14 Aug 2012, Alexandre Oliva wrote:

> Don't wait for a signal if the dispatch queue is non-empty already,
> and support a non-NULL pipe for local responses.  If we were to
> require pipe to be NULL for that, the response would be lost.
> 
> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  src/msg/SimpleMessenger.cc |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/src/msg/SimpleMessenger.cc b/src/msg/SimpleMessenger.cc
> index 53e36cd..973219f 100644
> --- a/src/msg/SimpleMessenger.cc
> +++ b/src/msg/SimpleMessenger.cc
> @@ -373,7 +373,7 @@ void SimpleMessenger::DispatchQueue::entry()
>        }
>        lock.Lock();
>      }
> -    if (!stop)
> +    if (queued_pipes.empty() && !stop)
>        cond.Wait(lock); //wait for something to be put on queue
>    }
>    lock.Unlock();
> @@ -2477,7 +2477,7 @@ void SimpleMessenger::submit_message(Message *m, Connection *con, const entity_a
>    }
>  
>    // local?
> -  if (!pipe && my_inst.addr == dest_addr) {
> +  if (my_inst.addr == dest_addr) {
>      if (!destination_stopped) {
>        // local
>        ldout(cct,20) << "submit_message " << *m << " local" << dendl;
> -- 
> 1.7.7.6
> 
> -- 
> Alexandre Oliva, freedom fighter    http://FSFLA.org/~lxoliva/
> You must be the change you wish to see in the world. -- Gandhi
> Be Free! -- http://FSFLA.org/   FSF Latin America board member
> Free Software Evangelist      Red Hat Brazil Compiler Engineer
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
