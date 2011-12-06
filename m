From: Tomasz Paszkowski <ss7pro@gmail.com>
Subject: Re: Ceph Best Practices
Date: Tue, 6 Dec 2011 20:33:03 +0100
Message-ID: <CAMvP8PCqaPM_aVFC1s1bYk46XzFN3KzHh2wEPm9P9uiqQgrDjQ@mail.gmail.com>
References: <CABGLbPHXtga0tXYRrF=bLmtJK1U439TDZkEXsvBkc=LFyFiaDg@mail.gmail.com>
 <CABGLbPHuo52tUSWWSt2=fbLNK1FoeLM-qALHKmUfb4P9T6gcZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:34022 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751866Ab1LFTdZ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 6 Dec 2011 14:33:25 -0500
Received: by dadv6 with SMTP id v6so5481291dad.19
        for <ceph-devel@vger.kernel.org>; Tue, 06 Dec 2011 11:33:25 -0800 (PST)
In-Reply-To: <CABGLbPHuo52tUSWWSt2=fbLNK1FoeLM-qALHKmUfb4P9T6gcZQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Mon, Dec 5, 2011 at 10:47 PM, Steven Crothers
<steven.crothers@gmail.com> wrote:
> Hello,
>
> I have a quick question about the way to layout disks in the OSDs. I
> can't really find the information I'm looking for on the Wiki or in
> the existing mailing list archives that I have saved (4-5months
> worth).
>
> In the even a large OSD is being build (say 20 drives, same make/model
> 2TB). How would you build the OSD? Is it best to format each disk
> individually or build them into a raid group? Is there performance
> benefits to having each disk setup individually or perhaps having X
> amount of raid groups on the system?

It depends on workload you're going to put on this system. Remember
that CEPH is splitting each image into 4MB/s chunks. If you are going
to assign
each disk individually than each chunk will be only on single drive.
If you'll assign huge raid protected block device than each chunk may
be placed on more than 1 drive.
You have to also consider what is better for you in case if one of the
drives will fail. Do you prefer raid controller doing rebuild process
or do you want host cpu and ceph to take care of it.
Another issue here is that smaller disk drive is easier to recover
after failure (eg: filesystem failure ;).



> How would someone theoretically utilize this amount of storage as
> efficiently as possible?

It depends on CPU power you have on each box and planned workload. You
can always setup four logical drives on raid controller and than
import them to OSD if your host CPU is hitting maximal utilization.




-- 
Tomasz Paszkowski
SS7, Asterisk, SAN, Datacenter, Cloud Computing
+48500166299
