From: Mike Ryan <mike.ryan@inktank.com>
Subject: Re: PG recovery reservation state chart
Date: Tue, 2 Oct 2012 14:43:06 -0700
Message-ID: <20121002214306.GG8206@splice>
References: <20121002194858.GC8206@splice>
 <alpine.DEB.2.00.1210021434450.27524@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50816 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932356Ab2JBVnJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 2 Oct 2012 17:43:09 -0400
Received: by padhz1 with SMTP id hz1so5643645pad.19
        for <ceph-devel@vger.kernel.org>; Tue, 02 Oct 2012 14:43:09 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1210021434450.27524@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

> This all looks right to me.  I only have one concern: if, at some future 
> point, we decide it's necessary or worthwhile to avoid non-backfill 
> recovery due to targets begin full, does this approach preclude an elegant 
> solution?

I believe this encourages an elegant solution:

We add a new state if a remote reservation is rejected:

   WaitRemoteRecoveryReserved -> SleepALittle -> LocalReserving
  
In the new state we drop the remote reservations we acquired and wait
until a timer goes off before transitioning back into LocalReserving.
