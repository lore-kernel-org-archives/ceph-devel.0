From: Sage Weil <sage@newdream.net>
Subject: Re: Client still connect failed leader after that mon down
Date: Thu, 17 Dec 2015 05:27:54 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1512170525540.10312@cobra.newdream.net>
References: <CAKZcxgeK8=au4yBxcsP+=ewtFr8_ruZCxUKJtWWSk6eGc-b8Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54017 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbbLQN1z (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Dec 2015 08:27:55 -0500
In-Reply-To: <CAKZcxgeK8=au4yBxcsP+=ewtFr8_ruZCxUKJtWWSk6eGc-b8Ow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jaze Lee <jazeltq@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 17 Dec 2015, Jaze Lee wrote:
> Hello cephers:
>     In our test, there are three monitors. We find client run ceph
> command will slow when the leader mon is down. Even after long time, a
> client run ceph command will also slow in first time.
> >From strace, we find that the client first to connect the leader, then
> after 3s, it connect the second.
> After some search we find that the quorum is not change, the leader is
> still the down monitor.
> Is that normal?  Or is there something i miss?

It's normal.  Even when the quorum does change, the client doesn't 
know that.  It should be contacting a random mon on startup, though, so I 
would expect the 3s delay 1/3 of the time.

A long-standing low-priority feature request is to have the client contact 
2 mons in parallel so that it can still connect quickly if one is down.  
It's requires some non-trivial work in mon/MonClient.{cc,h} though and I 
don't think anyone has looked at it seriously.

sage

