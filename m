From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 10:50:00 -0500
Message-ID: <25E46CD3-17AA-4F31-B157-4B3666408C82@ornl.gov>
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta01.ornl.gov ([128.219.177.14]:43836 "EHLO mta01.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755844Ab3AQPuB convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 10:50:01 -0500
In-Reply-To: <CAJH6TXi2g_Z56SfEjsK9tTdvxBvHUbMfM5UuQf37LAL4K5wTaQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Joseph Glanville <joseph.glanville@orionvm.com.au>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Jan 17, 2013, at 10:14 AM, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com> wrote:

> 2013/1/17 Atchley, Scott <atchleyes@ornl.gov>:
>> IPoIB appears as a traditional Ethernet device to Linux and can be used as such. Ceph has no idea that it is not Ethernet.
> 
> Ok. Now it's clear.
> AFAIK, a standard SDR IB card should give use more speed than GbE
> (less overhead?) and lower latency, I think.

Yes. It should get close to 1 GB/s where 1GbE is limited to about 125 MB/s. Lower latency? Probably since most Ethernet drivers set interrupt coalescing by default. Intel e1000 driver, for example, have a cluster mode that reduces (or turns off) interrupt coalescing. I don't know if ceph is latency sensitive or not.

Scott