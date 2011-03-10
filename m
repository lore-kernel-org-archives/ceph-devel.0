From: Sage Weil <sage@newdream.net>
Subject: Re: Another question about PG::do_peer
Date: Thu, 10 Mar 2011 10:17:39 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1103101006030.986@cobra.newdream.net>
References: <AANLkTikWHRrOJom30_CFi2jqdZ3YP41AZqCE4_nM4Jk_@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:55803 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752030Ab1CJSP1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 10 Mar 2011 13:15:27 -0500
In-Reply-To: <AANLkTikWHRrOJom30_CFi2jqdZ3YP41AZqCE4_nM4Jk_@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry Chang <henry.cy.chang@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 10 Mar 2011, Henry Chang wrote:
> Hi,
> 
> Another question is about PG::do_peer. I wonder if we should modify
> the condition of inferring no missing as follows:
> 
> diff --git a/src/osd/PG.cc b/src/osd/PG.cc
> index e634296..4ce3336 100644
> --- a/src/osd/PG.cc
> +++ b/src/osd/PG.cc
> @@ -1632,7 +1632,7 @@ void PG::do_peer(ObjectStore::Transaction& t,
> list<Context*>& tfin,
>      if (pi.is_empty())
>        continue;
>      if (peer_missing.find(peer) == peer_missing.end()) {
> -      if (pi.last_update == pi.last_complete) {
> +      if (pi.last_update == pi.last_complete && pi.last_update >= log.tail) {
>         dout(10) << " infering no missing (last_update==last_complete)
> for osd" << peer << dendl;
>         peer_missing[peer].num_missing();  // just create the entry.
>         search_for_missing(peer_info[peer], &peer_missing[peer], peer);
>
> If pi.last_update < log.tail, we cannot know if the peer has any
> missing. Shouldn't we try to pull the peer's missing+backlog first
> before inferring no missing and go ahead activating the pg?

Yeah, this is definitely broken, but I think it's broken even beyond that 
specific case.  It looks like it's just an ill-conceived optimization.  
The problem is that peer_missing needs to have missing in terms of the 
master log (on the primary), not the peer's log, and in order to 
calculate that we need pull the log+missing.  (In the 
last_update==last_complete case I was trying to optimize, the missing set 
will just be empty.)  The current code missing the case where the replica 
has a divergent log or and older last_update (even one > log.tail).

I think this shortcut _only_ makes sense when the replica is perfectly up 
to date, i.e.

      if (pi.last_update == pi.last_complete &&
	  pi.last_update == info.last_update) {

Does that sound right?

> Sorry for separating my questions into multiple emails.

No problem, it's easier that way.  :)

Thanks!
sage
