From: Sylvain Munaut <s.munaut@whatever-company.com>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Fri, 19 Apr 2013 16:37:42 +0200
Message-ID: <CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com>
	<51704AF4.7060908@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f47.google.com ([209.85.214.47]:53694 "EHLO
	mail-bk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030587Ab3DSOho (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 10:37:44 -0400
Received: by mail-bk0-f47.google.com with SMTP id ji2so158063bkc.6
        for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 07:37:43 -0700 (PDT)
In-Reply-To: <51704AF4.7060908@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel@vger.kernel.org

Hi,

> My Xen is kind of rusty, last time I used it was about 3 years ago, but
> can't you do something similar like with Qemu? Just submit all the arguments
> semi-column separated?

Yes probably, I just didn't get to it. I wanted to check first if this
approach was solving the issues I had with RBD kernel driver.

I'll try to stick as closely to the qemu syntax.

Cheers,

   Sylvain
