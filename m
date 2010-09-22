From: Sage Weil <sage@newdream.net>
Subject: Re: Several patches for CEPH
Date: Wed, 22 Sep 2010 12:16:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1009221212110.3172@cobra.newdream.net>
References: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:47939 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754200Ab0IVTOm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 22 Sep 2010 15:14:42 -0400
In-Reply-To: <AANLkTi=LJHRqKGYQ44h_K75oq2L9KUsZWoS1o--ipwCt@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Henry C Chang <henry_c_chang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Wed, 22 Sep 2010, Henry C Chang wrote:
> 2. http://github.com/tcloud/ceph/commit/e3147e8929220997017de8fffa34b9d9c2abf9cf
> 
> We hit this assert fail once. Can you check if this patch is reasonable?

I pushed a different fix for this, 

	http://ceph.newdream.net/git/?p=ceph.git;a=commitdiff;h=a783f409e5e5524b4f2c15f78c716ca77e8aeb3c

I think the problem was that the state reset (canceling of timer events, 
etc.) wasn't happening when the election was started due to another node 
(i.e., didn't come through Monitor::call_election()).

The SafeTimer class (which handles the timeouts) is set up to handle mutex 
acquisition for you and let you cancel events without worrying about 
races, and the mutex is held over this whole function, so moving the 
'state = ' bit around doesn't actually change behavior wrt the timeouts.

Thanks!
sage
