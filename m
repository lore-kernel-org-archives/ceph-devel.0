From: Dan Mick <dan.mick@inktank.com>
Subject: Re: does still not recommended place rbd device on nodes, where osd
 daemon located?
Date: Wed, 21 Nov 2012 12:29:14 -0800
Message-ID: <50AD399A.2010203@inktank.com>
References: <CAHULbCmY6j3GbRFs_fyO1VP5_-BG5Cg1H_Kvfg1nN3jMMpyvHA@mail.gmail.com> <alpine.DEB.2.00.1211200849080.7369@cobra.newdream.net> <CAHULbC=Hk0ADhKB-GT-LCrHnzdGOyPTEJTxOp4=+bHVBdVQuCw@mail.gmail.com> <CAPYLRzg9DiKTY24w4DSY2t4ATk=VxNC0GHSM32_s9U7SAqi+yA@mail.gmail.com> <CAHULbCmMvBWq7xpZ1faTieROUpHSBBnNKcr6x3VC5sDkLodjrQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-da0-f46.google.com ([209.85.210.46]:32936 "EHLO
	mail-da0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab2KUU3R (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Nov 2012 15:29:17 -0500
Received: by mail-da0-f46.google.com with SMTP id p5so1868970dak.19
        for <ceph-devel@vger.kernel.org>; Wed, 21 Nov 2012 12:29:17 -0800 (PST)
In-Reply-To: <CAHULbCmMvBWq7xpZ1faTieROUpHSBBnNKcr6x3VC5sDkLodjrQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ruslan usifov <ruslan.usifov@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Still not certain I'm understanding *just* what you mean, but I'll point 
out that you can set up a cluster with rbd images, mount them from a 
separate non-virtualized host with kernel rbd, and expand those images 
and take advantage of the newly-available space on the separate host, 
just as though you were expanding a RAID device.  Maybe that fits your 
use case, Ruslan?

On 11/21/2012 12:05 PM, ruslan usifov wrote:
> Yes i mean exactly this. it's a great pity :-( Maybe present some ceph
> equivalent that solve my problem?
>
> 2012/11/21 Gregory Farnum <greg@inktank.com>:
>> On Wed, Nov 21, 2012 at 4:33 AM, ruslan usifov <ruslan.usifov@gmail.com> wrote:
>>> So, not possible use ceph as scalable block device without visualization?
>>
>> I'm not sure I understand, but if you're trying to take a bunch of
>> compute nodes and glue their disks together, no, that's not a
>> supported use case at this time. There are a number of deadlock issues
>> caused by this sort of loopback; it's the same reason you shouldn't
>> mount NFS on the server host.
>> We may in the future manage to release an rbd-fuse client that you can
>> use to do this with a little less pain, but it's not ready at this
>> point.
>> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
