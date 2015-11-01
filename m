From: Sage Weil <sage@newdream.net>
Subject: Re: why we use two ObjectStore::Transaction in
 ReplicatedBackend::submit_transaction?
Date: Sun, 1 Nov 2015 06:47:07 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511010646540.19081@cobra.newdream.net>
References: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com> <alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net> <CALZt5jwEocBc2uqvec11ynWVWu=M=pG5wZSw_quFBVoaCgZcZQ@mail.gmail.com> <alpine.DEB.2.00.1510311340560.19081@cobra.newdream.net>
 <CANE=7sWnQHAY=6GbXPzMM63qENZFRyiuKT6L2VHHG7yppUmA5A@mail.gmail.com> <alpine.DEB.2.00.1511010639440.19081@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33486 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbbKAOrH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Nov 2015 09:47:07 -0500
In-Reply-To: <alpine.DEB.2.00.1511010639440.19081@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>
Cc: Ning Yao <zay11022@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 1 Nov 2015, Sage Weil wrote:
> On Sun, 1 Nov 2015, ??? wrote:
> > Yes, I think so.
> > keeping them separate and pass them to
> > ObjectStore::queue_transactions() would increase the time on
> > transaction encode process and exhaust more cpu.
> > 
> > The transaction::append holds 0.8% cpu on my environment.
> > The transaction encoding is also really a bottleneck which process
> > holds 1.8% cpu on my environment.
> 
> Where is the append() caller you're looking at?  I'm not seeing it.

Oh, I see:  https://github.com/ceph/ceph/pull/6439

This makes sense to me.
sage

