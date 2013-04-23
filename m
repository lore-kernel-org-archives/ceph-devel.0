From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Tue, 23 Apr 2013 17:06:04 +0200
Message-ID: <CAF6-1L5bUiSO-6YLvDitb6GKhuiZJSy4RLwD27_HODsR1y-KGw@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<51704AF4.7060908@42on.com>
	<CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com>
	<67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be>
	<CAF6-1L50V3cn0Sqcw-LajZh=dO=x91HTe4mL2yQ-k5yiGeJ2sg@mail.gmail.com>
	<E6E1667B-879F-4BF4-85DE-308C01BB7930@openminds.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f49.google.com ([209.85.214.49]:47785 "EHLO
	mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755970Ab3DWPGG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Apr 2013 11:06:06 -0400
Received: by mail-bk0-f49.google.com with SMTP id w5so314217bku.22
        for <ceph-devel@vger.kernel.org>; Tue, 23 Apr 2013 08:06:04 -0700 (PDT)
In-Reply-To: <E6E1667B-879F-4BF4-85DE-308C01BB7930@openminds.be>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Bernard Grymonpon <bernard@openminds.be>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi,

> - client dom0: a simple quick debootstrap, and a low amount of memory to bypass buffers

I assume you meant domU ?
You ran those tests in a VM right ?

> Thx for the work you've put in this! Seems to work nicely at first glance, but I'll do some more tests later on (with a more recent ceph cluster)...

Thanks for testing. When you do more tests, it'd be interesting to
compare the kernel driver with the blktap driver.

I've actually identified a bottleneck caused the Xen IO ring splitting
large requests into small 44k chunks, which tends to lower RBD
performance a lot ... I'l still investigating possible solutions to
that.

Cheers,

    Sylvain
