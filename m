From: Sage Weil <sage@newdream.net>
Subject: Re: OSD scalability & thread stacksize
Date: Fri, 2 Jul 2010 10:08:40 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007021006070.32597@cobra.newdream.net>
References: <AANLkTilDYesH_4FFEPUdLGvQRoZcW99czwfGru44RW3i@mail.gmail.com>
 <Pine.LNX.4.64.1007010724060.5822@cobra.newdream.net>
 <AANLkTikMO6VLTd4VyGhxWnJhgGbXHFNc10Z7uf-GRA66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48051 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756701Ab0GBSYm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Jul 2010 14:24:42 -0400
In-Reply-To: <AANLkTikMO6VLTd4VyGhxWnJhgGbXHFNc10Z7uf-GRA66@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul <paul_chiang@tcloudcomputing.com>
Cc: ceph-devel@vger.kernel.org

On Fri, 2 Jul 2010, Paul wrote:
> Yes, this seems to be what is happening. Taking a look, our kernels
> had ulimit -v set to equal total physical memory. After setting ulimit
> -v to unlimited, 32748 threads can be created regardless of what stack
> size is allocated to each thread, at which point pthread_create
> returns ENOMEM rather than EAGAIN. I'd still prefer to manage the
> allocated size though, since kernel settings might not be totally
> within our control.

That explains it.  I pushed out your patches (with a few small changes), 
and set the default stack size for the msgr threads to 1MB.  If you run 
with something smaller reliably (I suspect 32 KB is a safe bet) let us 
know.

I also cherry-picked a few other bug fixes for that tree, btw.  Let me me 
know if I missed anything important.

sage
