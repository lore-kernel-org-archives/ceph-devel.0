From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 14:44:41 +0100
Message-ID: <CAJH6TXjEpES5Ygh2KU8CCwfvRKsvHBYYJKiRdCFX1MdFOz7NDg@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<50F72150.7080002@inktank.com>
	<CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
	<CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
	<50F7FE9B.6050908@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f46.google.com ([74.125.82.46]:52482 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752776Ab3AQNon (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 08:44:43 -0500
Received: by mail-wg0-f46.google.com with SMTP id dr13so1589382wgb.13
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 05:44:42 -0800 (PST)
In-Reply-To: <50F7FE9B.6050908@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Joseph Glanville <joseph.glanville@orionvm.com.au>, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org

2013/1/17 Mark Nelson <mark.nelson@inktank.com>:
> There's been some talk about rsockets on the list before.  I think there are
> a couple of different folks that have tried (succeeded?) in getting it
> working.  barring that, it sounds like if you tune interrupt affinity
> settings and various other bits you can get IPoIB up into the 2GB/s+ range
> which while not RDMA speed, is at least better than 10GbE.

More over, an SDR/DDR IB switch is much more cheaper than a full 10GbE switch.
