From: "Atchley, Scott" <atchleyes@ornl.gov>
Subject: Re: flashcache
Date: Tue, 22 Jan 2013 16:06:18 -0500
Message-ID: <EC8A8ED0-DBD0-4C29-93D0-C656CD4A82A9@ornl.gov>
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
 <CAJH6TXj_JjmUsK4FhZhPiH0Eh4hYouJCJCMCmk6A1F2rw6=fxA@mail.gmail.com>
 <D36B9470-CEF7-43D2-83E3-F91ABA983100@ornl.gov>
 <CAJH6TXidPR+-Mg-=9xwSPRN_SVkZ=8Fv2rfJ5tyk86mNp8fcKw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta02.ornl.gov ([128.219.177.12]:58553 "EHLO mta02.ornl.gov"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136Ab3AVVGU convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 16:06:20 -0500
In-Reply-To: <CAJH6TXidPR+-Mg-=9xwSPRN_SVkZ=8Fv2rfJ5tyk86mNp8fcKw@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>
Cc: Mark Nelson <mark.nelson@inktank.com>, Joseph Glanville <joseph.glanville@orionvm.com.au>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Jan 17, 2013, at 11:19 AM, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com> wrote:

> 2013/1/17 Atchley, Scott <atchleyes@ornl.gov>:
>> 10GbE should get close to 1.2 GB/s compared to 1 GB/s for IB SDR. Latency again depends on the Ethernet driver.
> 
> 10GbE faster than IB SDR? Really ?

Define faster. Throughput or latency?

Throughput, yes. You can easily measure 1.2 GB/s using many 10GbE NICs.

Latency, (mostly) no. IB SDR is about 4 us while the best TCP performance I have measured over 10GbE is about 16 us (interrupt coalescing turned off, NAGLE off, etc). Some vendors (e.g. Myricom and SolarFlare) have userspace, OS-bypass socket libraries for their NICs that get this down to 3-6 us.

Scott