From: Sage Weil <sage@newdream.net>
Subject: Re: async shutdown
Date: Tue, 27 Dec 2016 21:55:15 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1612272154540.10615@piezo.novalocal>
References: <alpine.DEB.2.11.1612272146160.10033@piezo.novalocal>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44824 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752294AbcL0WCq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Dec 2016 17:02:46 -0500
In-Reply-To: <alpine.DEB.2.11.1612272146160.10033@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: haomai@xsky.com
Cc: ceph-devel@vger.kernel.org

On Tue, 27 Dec 2016, Sage Weil wrote:
> I'm chasing a pretty reproducible crash of the rocksdb librados 
> env backend where it asserts on crypto shutdown with this PR applied:
> 
> 	https://github.com/ceph/ceph/pull/12624
> 
> This is generally caused by a memory leak of some crypto object (e.g., 
> CryptoKey).  If it run the test in a loop with ms type = simple it's fine, 
> but with async it crashes after about 10 minutes.  On one run valgrind 
> reported a leak from AsyncConnection, although it didn't make any 
> sense (recv_buf?).  But my suspicion is that the 
> AsyncMessenger::shutdown() call to stack->drain() isn't sufficient to make 
> sure all of the connections have actually been destroyed, which means the 
> cct and crypto shutdown asserts sometimes.
> 
> Does that theory make sense?  Any suggestions how to make sure that 
> the AsyncConnections are reliably reaped during librados shutdown?

...and as soon as I hit send my msg/simple run in a loop also 
crashed.  Nevermind!

sage


> 
> Thanks!
> sage
> 
> 
> BTW here's an example of the crash, although it's not particularly 
> informative in and of itself:
> 
> http://pulpito.ceph.com/sage-2016-12-27_18:31:32-rados-wip-sage-testing---basic-smithi/670919
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
