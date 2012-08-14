From: Sage Weil <sage@inktank.com>
Subject: Re: cherry-pick 7adc6c08f14 for stable branch
Date: Tue, 14 Aug 2012 09:10:54 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208140910140.18862@cobra.newdream.net>
References: <502A1013.6040302@bisect.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54982 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab2HNQKz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 14 Aug 2012 12:10:55 -0400
In-Reply-To: <502A1013.6040302@bisect.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Kukawka <danny.kukawka@bisect.de>
Cc: ceph-devel@vger.kernel.org

On Tue, 14 Aug 2012, Danny Kukawka wrote:
> Hi,
> 
> could you please cherry-pick:
> ---------------
> commit 7adc6c08f1474806c83ef6c89e8752d6cfd35bfd
> Author: Sage Weil <sage@inktank.com>
> Date:   Mon Jul 9 17:24:19 2012 -0700
> 
>     mon: simplify logmonitor check_subs; less noise
> 
>      * simple helper to translate name to id
>      * verify sub type is valid in caller
>      * assert sub type is valid in method
>      * simplify iterator usage
> 
>     Among other things, this gets rid of this noise in the logs:
> 
>     2012-07-10 20:51:42.617152 7facb23f1700  1 mon.a@1(peon).log v310
> check_sub sub monmap not log type
> 
>     Signed-off-by: Sage Weil <sage@inktank.com>
> ---------------
> 
> from master to the stable branch?

No problem.  I just tagged and built 0.48.1, but I'll put this into stable 
for 0.48.2.

sage


> 
> Thanks!
> 
> Danny
> 
> 
