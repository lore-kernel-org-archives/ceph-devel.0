From: Sage Weil <sage@newdream.net>
Subject: Re: why we use two ObjectStore::Transaction in
 ReplicatedBackend::submit_transaction?
Date: Sun, 1 Nov 2015 06:42:40 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1511010639440.19081@cobra.newdream.net>
References: <CANE=7sWNry9QYHkV=DK8NOudeU7UNNoRya8-be1BFiG=9YGn3g@mail.gmail.com> <alpine.DEB.2.00.1510310617240.19081@cobra.newdream.net> <CALZt5jwEocBc2uqvec11ynWVWu=M=pG5wZSw_quFBVoaCgZcZQ@mail.gmail.com> <alpine.DEB.2.00.1510311340560.19081@cobra.newdream.net>
 <CANE=7sWnQHAY=6GbXPzMM63qENZFRyiuKT6L2VHHG7yppUmA5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:33474 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752917AbbKAOml (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 1 Nov 2015 09:42:41 -0500
In-Reply-To: <CANE=7sWnQHAY=6GbXPzMM63qENZFRyiuKT6L2VHHG7yppUmA5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?GB2312?B?s9jQxdTz?= <xmdxcxz@gmail.com>
Cc: Ning Yao <zay11022@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sun, 1 Nov 2015, ??? wrote:
> Yes, I think so.
> keeping them separate and pass them to
> ObjectStore::queue_transactions() would increase the time on
> transaction encode process and exhaust more cpu.
> 
> The transaction::append holds 0.8% cpu on my environment.
> The transaction encoding is also really a bottleneck which process
> holds 1.8% cpu on my environment.

Where is the append() caller you're looking at?  I'm not seeing it.

sage


> 
> 2015-11-01 4:42 GMT+08:00 Sage Weil <sage@newdream.net>:
> > On Sat, 31 Oct 2015, Ning Yao wrote:
> >> Yeah, since issue_op is called before log_operation, we may consider
> >> to reuse op_t after sent encoded op_t to the wire. local_t.append(),
> >> at least, does copy the op_bl in op_t transaction and we may avoid
> >> this memory copy, and if we can avoid this append operation as well as
> >> in sub_op_modify_impl(), it, at least, improves the performance 1%~2%
> >> under my testing environment using ssd as Filestore backend.
> >> The only difference we find in this path is that local_t should be
> >> done first, but actually it seems that the order of the transaction is
> >> not quite important. If so, we may refactor and improve this?
> >
> > I seem to recall that in teh EC case the order does matter (I had switched
> > the append order when trying to fix this before but had to revert because
> > things broke).
> >
> > And I'm a bit nervous about re-using local_t and relying on the send vs
> > submit timing.  Is it not practical to keep them separate and
> > pass them both down to ObjectStore::queue_transactions()?
> >
> > sage
> 
> 
> 
> -- 
> Regards,
> xinze
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
