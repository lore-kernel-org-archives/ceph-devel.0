From: Gregory Farnum <gregory.farnum@dreamhost.com>
Subject: Re: mds sync wrlock
Date: Wed, 29 Jun 2011 15:33:42 -0700
Message-ID: <57F6F997-D0E8-448F-AEDB-8FCE26F182CC@dreamhost.com>
References: <BANLkTin9SkuYVnatyXoKCjHiJevCizKwVA@mail.gmail.com> <B0DF7127-A5BF-4DAE-A22C-1FD9C284172B@dreamhost.com> <BANLkTim_k-8Wqqx6e6W+R0LdaNvCGPUNng@mail.gmail.com> <D948AD56-6ADE-4D6C-BC2D-627D73C79663@dreamhost.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:36342 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753215Ab1F2Wdn convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Jun 2011 18:33:43 -0400
In-Reply-To: <D948AD56-6ADE-4D6C-BC2D-627D73C79663@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregory.farnum@dreamhost.com>
Cc: huang jun <hjwsm1989@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>


On Jun 29, 2011, at 1:01 PM, Gregory Farnum wrote:
> Ah. Each directory has a lot of different locks protecting different pieces of state. Here, the only write lock that is being held for the creates in dir b is the nestlock, which protects the rstats (recursive stats). Generally that lock shouldn't block creates though. How long does your test take to run?
> Since the lock says it's flushing I wonder if there's something else going on that's hurting your OSD performance and stalling it out.
> 
> I'll see if I can reproduce it locally.


I reproduced this locally and talked it over with Sage. The problem was just an unwise strategy for dealing with cache coherency that we applied a fairly simple fix for. It's in master on commit 310032ee8128f6417ac302c0f5ecd27c691cbcc7, which you should be able to cherry-pick if you wish. :)
-Greg