From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 16:14:07 +0100
Message-ID: <CAJH6TXi2g_Z56SfEjsK9tTdvxBvHUbMfM5UuQf37LAL4K5wTaQ@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<50F72150.7080002@inktank.com>
	<CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
	<CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
	<50F7FE9B.6050908@inktank.com>
	<44CC6A16-2ADD-4DBB-8B07-0E16032AEDA2@ornl.gov>
	<CAJH6TXhMXfsgx607aOxpLmpq15vg44AW8NHbm_Yw8yC45CHyKA@mail.gmail.com>
	<F926561F-9D73-4B74-AFC7-F5B962810733@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f173.google.com ([74.125.82.173]:45547 "EHLO
	mail-we0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755593Ab3AQPOJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 10:14:09 -0500
Received: by mail-we0-f173.google.com with SMTP id z2so297826wey.18
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 07:14:07 -0800 (PST)
In-Reply-To: <F926561F-9D73-4B74-AFC7-F5B962810733@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Mark Nelson <mark.nelson@inktank.com>, Joseph Glanville <joseph.glanville@orionvm.com.au>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2013/1/17 Atchley, Scott <atchleyes@ornl.gov>:
> IPoIB appears as a traditional Ethernet device to Linux and can be used as such. Ceph has no idea that it is not Ethernet.

Ok. Now it's clear.
AFAIK, a standard SDR IB card should give use more speed than GbE
(less overhead?) and lower latency, I think.
