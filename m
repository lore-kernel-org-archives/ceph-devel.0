From: Sage Weil <sweil@redhat.com>
Subject: C++11
Date: Mon, 29 Sep 2014 08:24:12 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1409290821220.14393@cobra.newdream.net>
References: <1410796508-28711-1-git-send-email-j@jannau.net> <1411994072-18850-1-git-send-email-j@jannau.net> <CANP1eJGxY8wR4smOfZ49+1dwjWCU7FrdbOG4UvMJR7UP77UX4g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45681 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751601AbaI2PYN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Sep 2014 11:24:13 -0400
In-Reply-To: <CANP1eJGxY8wR4smOfZ49+1dwjWCU7FrdbOG4UvMJR7UP77UX4g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Milosz Tanski <milosz@adfin.com>
Cc: Janne Grunau <j@jannau.net>, ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 29 Sep 2014, Milosz Tanski wrote:
> A second more general Ceph question is somewhat off-topic. What about
> C++11 use in the Ceph code base (like in this case)? It's not
> explicitly prohibited by the coding style document, but I imagine the
> goal is to build on as many systems as possible and quite a few
> supported distros have pretty old versions of GCC. I'm asking this
> because I imagine some of the performance work that's about to happen
> will want to use things like lockless queues, and then you get into
> C++11 memory model and std::atomic... etc.

We are all very eager to move to C++11.  The challenge is that we still 
need to build packages for the target distros.  That doesn't necessarily 
mean that the compilers on those distros need to support c++11 as long as 
the runtime does... if we can make the build enviroment sane.

I'm really curious what other projects do here...

sage
