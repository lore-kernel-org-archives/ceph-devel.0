From: Stefan Priebe <s.priebe@profihost.ag>
Subject: Re: flashcache
Date: Thu, 17 Jan 2013 17:20:24 +0100
Message-ID: <50F824C8.3040704@profihost.ag>
References: <CAJH6TXiJjEq4C7k5p39Eo+pgwoq372r29RJriBee+irJPLvLpw@mail.gmail.com> <alpine.DEB.2.00.1301161325280.27925@cobra.newdream.net> <50F72150.7080002@inktank.com> <CAJH6TXjY+vhEme6mAsnkWwVD2Xix7N_5GOAHEA92DszASz3yMQ@mail.gmail.com> <CAOzFzEhXTTtMDtsgR1ckRsdSxuCo=f8HGwd2+kJEthSGbwq1-w@mail.gmail.com> <50F7FE9B.6050908@inktank.com> <44CC6A16-2ADD-4DBB-8B07-0E16032AEDA2@ornl.gov> <CAJH6TXhMXfsgx607aOxpLmpq15vg44AW8NHbm_Yw8yC45CHyKA@mail.gmail.com> <F926561F-9D73-4B74-AFC7-F5B962810733@ornl.gov> <CAJH6TXi2g_Z56SfEjsK9tTdvxBvHUbMfM5UuQf37LAL4K5wTaQ@mail.gmail.com> <25E46CD3-17AA-4F31-B157-4B3666408C82@ornl.gov> <CAJH6TXj_JjmUsK4FhZhPiH0Eh4hYouJCJCMCmk6A1F2rw6=fxA@mail.gmail.com> <D36B9470-CEF7-43D2-83E3-F91ABA983100@ornl.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ph.de-nserver.de ([85.158.179.214]:38543 "EHLO
	mail-ph.de-nserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757006Ab3AQQUY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 17 Jan 2013 11:20:24 -0500
In-Reply-To: <D36B9470-CEF7-43D2-83E3-F91ABA983100@ornl.gov>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Atchley, Scott" <atchleyes@ornl.gov>
Cc: Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com>, Mark Nelson <mark.nelson@inktank.com>, Joseph Glanville <joseph.glanville@orionvm.com.au>, Sage Weil <sage@inktank.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

Am 17.01.2013 17:12, schrieb Atchley, Scott:
> On Jan 17, 2013, at 11:01 AM, Gandalf Corvotempesta <gandalf.corvotempesta@gmail.com> wrote:
>
>> 2013/1/17 Atchley, Scott <atchleyes@ornl.gov>:
>>> Yes. It should get close to 1 GB/s where 1GbE is limited to about 125 MB/s. Lower latency? Probably since most Ethernet drivers set interrupt coalescing by default. Intel e1000 driver, for example, have a cluster mode that reduces (or turns off) interrupt coalescing. I don't know if ceph is latency sensitive or not.
>>
>> Sorry, I meant 10GbE.
>
> 10GbE should get close to 1.2 GB/s compared to 1 GB/s for IB SDR. Latency again depends on the Ethernet driver.

We're using bonded active/active 2x10GbE with Intel ixgbe and i'm able 
to get 2.3GB/s.

Not sure how to measure latency effectively.

Stefan
