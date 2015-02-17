From: Sage Weil <sage@newdream.net>
Subject: Re: Concurrent access of the object via Rados API...
Date: Mon, 16 Feb 2015 17:28:52 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1502161727371.22050@cobra.newdream.net>
References: <CA+U0gVgPc76oaLaQka5WgeBEOWF3c+hjfpjtt7VBJs1FjkdgAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40412 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751277AbbBQB2x (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 16 Feb 2015 20:28:53 -0500
In-Reply-To: <CA+U0gVgPc76oaLaQka5WgeBEOWF3c+hjfpjtt7VBJs1FjkdgAA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dennis Chen <kernel.org.gnu@gmail.com>
Cc: ceph-users <ceph-users@ceph.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, 17 Feb 2015, Dennis Chen wrote:
> Hello,
> 
> For the case of multiple clients(separate process) accessing an object
> in the cluster, is the exclusive protection of the shared object
> needed for the caller?
> 
> Process A::rados::ioctx.write(obj, ...)
> Process B::rados::ioctx.write(obj, ...)

This is correct.  Racing reads/writes get ordered when they arrive at the 
OSD, and we make sure that updates are atomic and durable despite any 
OSD/disk/network failures.

sage



> 
> or:
> 
> Process A::
>     mylock.lock();
>     ioctx.write(obj, ..)
>     mylock.unlock()
> 
> Process B::
>     mylock.lock();
>     ioctx.write(obj, ..)
>     mylock.unlock()
> 
> which one is correct?
> 
> -- 
> Den
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
