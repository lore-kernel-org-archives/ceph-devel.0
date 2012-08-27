From: Sage Weil <sage@inktank.com>
Subject: Re: MPI applications on ceph fs
Date: Sun, 26 Aug 2012 21:06:23 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1208262104360.11218@cobra.newdream.net>
References: <36202107-A075-42E6-8B4B-AF6FEB86E2AD@psfc.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:45253 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751243Ab2H0EGY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Aug 2012 00:06:24 -0400
In-Reply-To: <36202107-A075-42E6-8B4B-AF6FEB86E2AD@psfc.mit.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Wright <jwright@psfc.mit.edu>
Cc: ceph-devel@vger.kernel.org

Hi John,

Can you dump running threads?  'echo t > /proc/sysrq-trigger' and then 
attach the output (from dmesg or kern.log).

Thanks!
sage


On Sun, 26 Aug 2012, John Wright wrote:

> Hi All,
> We're running ceph 0.48 on  small three node test cluster. We've had good stability with I/O using dd and iozone especially after upgrading to 0.48. However, we're running into a repeatable lockup of the linux ceph client ( 3.3.5-2.fc16.x86_64 ) when running an mpi program that has simple I/O on a ceph mount. This is an mpi program running processes on two nodes. It is the remote node on which the ceph client locks up. The cient becomes immediately unresponsive and any attempt to access the mounted volume produces a process with status 'D'. I can see no indication in the server logs that it is ever contacted. Regular serial processes run fine on the volume. MPI runs on the nodes work fine when not using the ceph volume.
> 
> So any suggestions on where to look? Any one have an experience testing parallel programs on ceph?
> 
> thanks,
> -john
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
