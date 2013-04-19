From: Bernard Grymonpon <bernard@openminds.be>
Subject: Re: Xen blktap driver for Ceph RBD : Anybody wants to test ? :p
Date: Fri, 19 Apr 2013 16:40:24 +0200
Message-ID: <67AC8E8B-C295-49EA-BD52-39F06E3C5A37@openminds.be>
References: <CAF6-1L714v7xtXe_Bg396jm+7Fi5ivUoxX79dpZ4dmT8MFj-aA@mail.gmail.com> <51704AF4.7060908@42on.com> <CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.2 \(1499\))
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from november.openminds.be ([195.47.215.47]:40043 "EHLO
	november.openminds.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030593Ab3DSOrk convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Apr 2013 10:47:40 -0400
Received: from [10.1.11.79] (office.loft169.be [88.151.240.193])
	by november.openminds.be (Postfix) with ESMTPA id D9DFC120F951
	for <ceph-devel@vger.kernel.org>; Fri, 19 Apr 2013 16:40:24 +0200 (CEST)
In-Reply-To: <CAF6-1L5uhOknmR7O6TtrYoiE6Sqb1FbN1-U2cpDbAR31-i2=5A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

We can test this, but just a couple of lines of input might be needed to get us going with this without digging through all the code.

Rgds,
Bernard
Openminds BVBA

On 19 Apr 2013, at 16:37, Sylvain Munaut <s.munaut@whatever-company.com> wrote:

> Hi,
> 
>> My Xen is kind of rusty, last time I used it was about 3 years ago, but
>> can't you do something similar like with Qemu? Just submit all the arguments
>> semi-column separated?
> 
> Yes probably, I just didn't get to it. I wanted to check first if this
> approach was solving the issues I had with RBD kernel driver.
> 
> I'll try to stick as closely to the qemu syntax.
> 
> Cheers,
> 
>   Sylvain
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

