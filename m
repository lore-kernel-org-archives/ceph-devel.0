From: Nam Dang <namd@de.cs.titech.ac.jp>
Subject: Re: SIGSEGV in cephfs-java, but probably in Ceph
Date: Tue, 5 Jun 2012 20:22:28 +0900
Message-ID: <CAHwdYF1Uhg5ZriNZBJN9xXNdLEP=gLoFRechn8OKO3dxDkUt9g@mail.gmail.com>
References: <CAHwdYF3na4dHqpQmAth+gEKBLeqLKSHAd-6MChgKjRyBrO+Ttw@mail.gmail.com>
 <CAHwdYF2CF77XnyHG16gi_hPbZ8VNbEzn0XpikKMDdcGWcd2-CQ@mail.gmail.com>
 <DC393A32-288A-4BF2-B618-9D6E0A5C29B9@cs.ucsc.edu> <05C460A496DC45689D6578B20D699425@inktank.com>
 <217DCA5E-26E6-4357-96E7-0C9AF4E06071@cs.ucsc.edu> <9C7F8B20FB3B49508B9FBEE725AB34EE@inktank.com>
 <CAPrxi59++wux__pY1M0qu+=YcVWAbkbLVWuxa95=ZLo8R64XiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.nap.gsic.titech.ac.jp ([131.112.222.52]:35139 "EHLO
	mail2.nap.gsic.titech.ac.jp" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933168Ab2FELXC (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Jun 2012 07:23:02 -0400
Received: from 209.85.215.46 (209.85.215.46 [209.85.215.46])
	by mail2.nap.gsic.titech.ac.jp (deepsmtpd.so 3.5.54)
	with ESMTP id <CAHwdYF1Uhg5ZriNZBJN9xXNdLEP=gLoFRechn8OKO3dxDkUt9g@mail.gmail.com>
	for <ceph-devel@vger.kernel.org>; Tue, 5 Jun 2012 20:22:52 +0900
Received: by lahd3 with SMTP id d3so3692886lah.19
        for <ceph-devel@vger.kernel.org>; Tue, 05 Jun 2012 04:22:49 -0700 (PDT)
In-Reply-To: <CAPrxi59++wux__pY1M0qu+=YcVWAbkbLVWuxa95=ZLo8R64XiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <jayhawk@soe.ucsc.edu>, Greg Farnum <greg@inktank.com>, Noah Watkins <jayhawk@cs.ucsc.edu>, ceph-devel <ceph-devel@vger.kernel.org>

Hi Noah,

Thank you for the push. Now I don't have SIGSEGV anymore. By the way,
is there any way to move the ceph_is_mounted() function into the java
library's code instead of putting it in the main Ceph's code?

> The basic idea was that threads in Java did not map 1:1 with kernel
> threads (think co-routines), which would break a lot of stuff,
> especially futex. Looking at some documentation, old JVMs had
> something called Green Threads, but have now been abandoned in favor
> of native threads. So maybe this theory is now irrelevant, and
> evidence seems to suggest you're right and Java is using native
> threads.

I check the error without multithreading and it was the same. And I'm
using Java 6, so threads should be real threads.
My guess is that it's related to some internal locking mechanism.

Best regards,
Nam Dang
