From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 17:01:34 +0100
Message-ID: <CAJH6TXj_JjmUsK4FhZhPiH0Eh4hYouJCJCMCmk6A1F2rw6=fxA@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<50F72150.7080002@inktank.com>
	<CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
	<CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
	<50F7FE9B.6050908@inktank.com>
	<44CC6A16-2ADD-4DBB-8B07-0E16032AEDA2@ornl.gov>
	<CAJH6TXhMXfsgx607aOxpLmpq15vg44AW8NHbm_Yw8yC45CHyKA@mail.gmail.com>
	<F926561F-9D73-4B74-AFC7-F5B962810733@ornl.gov>
	<CAJH6TXi2g_Z56SfEjsK9tTdvxBvHUbMfM5UuQf37LAL4K5wTaQ@mail.gmail.com>
	<25E46CD3-17AA-4F31-B157-4B3666408C82@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f179.google.com ([74.125.82.179]:37686 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756708Ab3AQQBf convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 11:01:35 -0500
Received: by mail-we0-f179.google.com with SMTP id r6so331657wey.24
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 08:01:34 -0800 (PST)
In-Reply-To: <25E46CD3-17AA-4F31-B157-4B3666408C82@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Mark Nelson <mark.nelson@inktank.com>, Joseph Glanville <joseph.glanville@orionvm.com.au>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2013/1/17 Atchley, Scott <atchleyes@ornl.gov>:
> Yes. It should get close to 1 GB/s where 1GbE is limited to about 125 MB/s. Lower latency? Probably since most Ethernet drivers set interrupt coalescing by default. Intel e1000 driver, for example, have a cluster mode that reduces (or turns off) interrupt coalescing. I don't know if ceph is latency sensitive or not.

Sorry, I meant 10GbE.
