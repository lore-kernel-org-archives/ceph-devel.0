From: jie sun <0maidou0@gmail.com>
Subject: Re: mon down
Date: Tue, 15 Jan 2013 18:02:09 +0800
Message-ID: <CAB6Jr7RxhN+kWYk98M_PAxLwJ1-EzUCbAx2V7hOYmxWhXvkAuA@mail.gmail.com>
References: <CAB6Jr7RiHwYnSAGjzLG=8ises4VwsfX3xDRep0e2sHChB1B_Ow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:54061 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752994Ab3AOKCJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 05:02:09 -0500
Received: by mail-pa0-f49.google.com with SMTP id bi1so7289pad.36
        for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 02:02:09 -0800 (PST)
In-Reply-To: <CAB6Jr7RiHwYnSAGjzLG=8ises4VwsfX3xDRep0e2sHChB1B_Ow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

Hi all,
    Forgot to say, my ceph version is 0.48.2, and os is opensuse
11.4(kernel 2.6.37).
    Thank you.

2013/1/15 jie sun <0maidou0@gmail.com>:
> Hi all,
>     I have done some tests nowadays. I made a ceph cluster with 1 mon
> 1 mds and 10 osds. Then I made a block device(use "rbd create/rbd
> map/.." mount it do a virtual machine as a disk). I stored some data
> on the disk and broke down the mon.
>     I want to know if there is any way to find out my data with some
> operations? Can I recreate a mon to take the place of the mon before?
>     Any suggestions are welcome, thank you.
