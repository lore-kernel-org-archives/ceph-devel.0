From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] Relax journal trim_finish assertion to pass when (to ==
 trimmed_pos).
Date: Tue, 12 Apr 2011 08:40:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1104120839390.12198@cobra.newdream.net>
References: <or62qjxzq3.fsf@livre.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46755 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757585Ab1DLPhN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Apr 2011 11:37:13 -0400
In-Reply-To: <or62qjxzq3.fsf@livre.localdomain>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
Cc: ceph-devel@vger.kernel.org

On Tue, 12 Apr 2011, Alexandre Oliva wrote:
> I'm getting relatively frequent MDS crashes.  I believe this happens as
> a replay-standby node is about to take over once the MDS it follows is
> restarted, most often because it stopped making progress for a long
> time.  In the core files I checked, waitfor_trim was empty, so this
> shouldn't have ill effects.  Since I'm not sure how to trigger this
> particular assertion failure, I can't say that I've tested this patch
> thoroughly, but unless the purpose of the assertion is to catch the ==
> case, I think it's safe to put it in.

The assertion is that way on purpose.. we shouldn't be trimming to a 
offset we've already trimmed to.  Looking at the code it's not obvious how 
we're getting into that particular corner, though.  Can you reproduce the 
problem with

	debug journaler = 20

?  That should have enough information to track down exactly where things 
are going awry.

Thanks!
sage


> 
> ---
> Relax journal trim_finish assertion to pass when (to == trimmed_pos).
> 
> Signed-off-by: Alexandre Oliva <oliva@lsd.ic.unicamp.br>
> ---
>  src/osdc/Journaler.cc |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/src/osdc/Journaler.cc b/src/osdc/Journaler.cc
> index f3241c4..4f4811c 100644
> --- a/src/osdc/Journaler.cc
> +++ b/src/osdc/Journaler.cc
> @@ -960,7 +960,7 @@ void Journaler::_trim_finish(int r, uint64_t to)
>    assert(r >= 0);
>    
>    assert(to <= trimming_pos);
> -  assert(to > trimmed_pos);
> +  assert(to >= trimmed_pos);
>    trimmed_pos = to;
>  
>    // finishers?
> -- 
> 1.7.4.2
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
