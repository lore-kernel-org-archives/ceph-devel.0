From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 10:00:55 -0500
Message-ID: <F926561F-9D73-4B74-AFC7-F5B962810733@ornl.gov>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com>
 <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net>
 <50F72150.7080002@inktank.com>
 <CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com>
 <CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com>
 <50F7FE9B.6050908@inktank.com>
 <44CC6A16-2ADD-4DBB-8B07-0E16032AEDA2@ornl.gov>
 <CAJH6TXhMXfsgx607aOxpLmpq15vg44AW8NHbm_Yw8yC45CHyKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.177.14]:52109 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756027Ab3AQPA6 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 10:00:58 -0500
In-Reply-To: <CAJH6TXhMXfsgx607aOxpLmpq15vg44AW8NHbm_Yw8yC45CHyKA@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Joseph Glanville <joseph.glanville@orionvm.com.au>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Jan 17, 2013, at 9:48 AM, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com> wrote:

> 2013/1/17 Atchley, Scott <atchleyes@ornl.gov>:
>> IB DDR should get you close to 2 GB/s with IPoIB. I have gotten our IB QDR PCI-E Gen. 2 up to 2.8 GB/s measured via netperf with lots of tuning. Since it uses the traditional socket stack through the kernel, CPU usage will be as high (or higher if QDR) than 10GbE.
> 
> Which kind of tuning? Do you have a paper about this?

No, I followed the Mellanox tuning guide and modified their interrupt affinity scripts.

> But, actually, is possible to use ceph with IPoIB in a stable way or
> is this experimental ?

IPoIB appears as a traditional Ethernet device to Linux and can be used as such. Ceph has no idea that it is not Ethernet.

> I don't know if i support for rsocket that is experimental/untested
> and IPoIB is a stable workaroud or what else.

IPoIB is much more used and pretty stable, while rsockets is new with limited testing. That said, more people using it will help Sean improve it.

Ideally, we would like support for zero-copy and reduced CPU usage (via OS-bypass) and with more interconnects than just InfiniBand. :-)

> And is a dual controller needed on each OSD node? Ceph is able to
> handle OSD network failures? This is really important to know. It
> change the whole network topology.

I will let others answer this.

Scott