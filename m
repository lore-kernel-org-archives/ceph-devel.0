From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: max rbd devices
Date: Tue, 28 Jul 2015 09:38:11 +0300
Message-ID: <CAOi1vP80S138HcbSb-CXYQoa2-r-z=LDHB5iEVsmNohzGCn=Ug@mail.gmail.com>
References: <CAGbvivKdOFwMqbsLc7wzhYfF=BzMVXXUVR0oBgmq-eC8S-b3JQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34675 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752778AbbG1GiM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Jul 2015 02:38:12 -0400
Received: by wibud3 with SMTP id ud3so166835837wib.1
        for <ceph-devel@vger.kernel.org>; Mon, 27 Jul 2015 23:38:11 -0700 (PDT)
In-Reply-To: <CAGbvivKdOFwMqbsLc7wzhYfF=BzMVXXUVR0oBgmq-eC8S-b3JQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Mon, Jul 27, 2015 at 11:38 PM, Wyllys Ingersoll
<wyllys.ingersoll@keepertech.com> wrote:
> I found a thread from 2012 talking about the maximum number of RBD
> devices that can be mapped, it seems to cap out at around 228.  There
> was discussion about possibly fixing this by using a registered/fixed
> major block device and bumping the minor device number for each new
> mapping.
>
> http://www.spinics.net/lists/ceph-devel/msg09362.html
>
> Did this ever progress any further or was an official bug ever filed?
> Im seeing this issue now and was just wondering if there are
> workarounds (other than not creating that many mappings).

What are your kernel and ceph versions?

It's been fixed in 3.14 with the addition of single_major parameter to
rbd.ko.  It's off by default because old userspace doesn't know how to
deal with it.  If you are on 3.14 or later and your userspace is new
enough (0.75 or later IIRC), rbd map will load with single_major=Y.

The new theoretical limit is 65536 rbd devices, but I must confess
I haven't tried to map more than ~4000.

Thanks,

                Ilya
