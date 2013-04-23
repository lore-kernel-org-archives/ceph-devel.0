From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Tue, 23 Apr 2013 21:13:42 +0200
Message-ID: <F6197C3E-519B-43E2-B696-FE535DC727A8@openminds.be>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com> <51704AF4.7060908@42on.com> <CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com> <67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be> <CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com> <E6E1667B-879F-4BF4-85DE-308C01BB7930@openminds.be> <CAF6-1L5bUiSO-6YLvDitb6GKhuiZJSy4RLwD27_HODsR1y-KGw@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:53865 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756720Ab3DWTNr convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Apr 2013 15:13:47 -0400
In-Reply-To: <CAF6-1L5bUiSO-6YLvDitb6GKhuiZJSy4RLwD27_HODsR1y-KGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>



On 23 Apr 2013, at 17:06, Sylvain Munaut <s.munaut@whatever-company.com> wrote:

> Hi,
> 
>> - client dom0: a simple quick debootstrap, and a low amount of memory to bypass buffers
> 
> I assume you meant domU ?
> You ran those tests in a VM right ?

Right! DomU indeed, not dom0. The benchmarks are done on /dev/xvdb, being the rbd device. I was able to block-attach/detach them also on the dom0, but that is trivial once it works.

> 
>> Thx for the work you've put in this! Seems to work nicely at first glance, but I'll do some more tests later on (with a more recent ceph cluster)...
> 
> Thanks for testing. When you do more tests, it'd be interesting to
> compare the kernel driver with the blktap driver.

I'll be upgrading my testcluster first to the latest stable ceph release, and then run some endurance-tests against the setup. But that won't happen before mid next week.

> 
> I've actually identified a bottleneck caused the Xen IO ring splitting
> large requests into small 44k chunks, which tends to lower RBD
> performance a lot ... I'l still investigating possible solutions to
> that.

Feel free to bug me once it is fixed, if you want some testing.

Rgds,
Bernard
Openminds BVBA

> 
> Cheers,
> 
>    Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

