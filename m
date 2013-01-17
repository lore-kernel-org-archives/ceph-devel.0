From: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 15:48:40 +0100
Message-ID: <CAJH6TXhMXfsgx607aOxpLmpq15vg44AW8NHbm_Yw8yC45CHyKA@mail.gmail.com>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
	<alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
	<50F72150.7080002@inktank.com>
	<CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
	<CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
	<50F7FE9B.6050908@inktank.com>
	<44CC6A16-2ADD-4DBB-8B07-0E16032AEDA2@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48800 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755377Ab3AQOsm convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 09:48:42 -0500
Received: by mail-wi0-f174.google.com with SMTP id hq4so4546729wib.7
        for <ceph-devel@vger.kernel.org>; Thu, 17 Jan 2013 06:48:41 -0800 (PST)
In-Reply-To: <44CC6A16-2ADD-4DBB-8B07-0E16032AEDA2@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Mark Nelson <mark.nelson@inktank.com>, Joseph Glanville <joseph.glanville@orionvm.com.au>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

2013/1/17 Atchley, Scott <atchleyes@ornl.gov>:
> IB DDR should get you close to 2 GB/s with IPoIB. I have gotten our IB QDR PCI-E Gen. 2 up to 2.8 GB/s measured via netperf with lots of tuning. Since it uses the traditional socket stack through the kernel, CPU usage will be as high (or higher if QDR) than 10GbE.

Which kind of tuning? Do you have a paper about this?

But, actually, is possible to use ceph with IPoIB in a stable way or
is this experimental ?
I don't know if i support for rsocket that is experimental/untested
and IPoIB is a stable workaroud or what else.

And is a dual controller needed on each OSD node? Ceph is able to
handle OSD network failures? This is really important to know. It
change the whole network topology.
