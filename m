From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: ceph-disk improvements
Date: Tue, 5 Apr 2016 11:26:56 +0200
Message-ID: <CAOi1vP_mnMP_n7xSPXgEycYRifja0k4LE7PBG7epL1uUNWjaJw@mail.gmail.com>
References: <alpine.DEB.2.11.1604011129360.22014@cpach.fuggernut.com>
	<2041558235.2113.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
	<alpine.DEB.2.11.1604030859210.19675@cpach.fuggernut.com>
	<1651492587.2194.160e133c-ee3f-4c6e-9b8b-e4d468651d78.open-xchange@ox.pcextreme.nl>
	<CA+HUO7LfPzCvFzi59ydivYdkCcbrRqdQSJVjVZtuar6avND9tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:35370 "EHLO
	mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757868AbcDEJ05 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Apr 2016 05:26:57 -0400
Received: by mail-lf0-f45.google.com with SMTP id c126so6060229lfb.2
        for <ceph-devel@vger.kernel.org>; Tue, 05 Apr 2016 02:26:57 -0700 (PDT)
In-Reply-To: <CA+HUO7LfPzCvFzi59ydivYdkCcbrRqdQSJVjVZtuar6avND9tA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sebastien Han <shan@redhat.com>
Cc: Wido den Hollander <wido@42on.com>, Sage Weil <sweil@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>, Samuel Yaple <sam@yaple.net>

On Tue, Apr 5, 2016 at 10:30 AM, Sebastien Han <shan@redhat.com> wrote:
> Wido, I just discussed that with Sam last week and it seems that
> bcache allocates a minor of 1 when creating the device.
> Sam ended up writing this:
> https://yaple.net/2016/03/31/bcache-partitions-and-dkms/
> The fix is not complex not sure why it is not part of bcache yet...

I think it's just that no one complained loud enough.

>
> Not sure if it's ceph-disk's job to do all of this with bcache though...
> We might need to check with the bache guys what are their plans about this.
> If this will go through at some point we might just wait, if not we
> could implement the partition trick on ceph-disk.

Making something like this go through shouldn't be a problem.  Sam's
patch is a bit of quick hack though - it messes up bcache device IDs
and also limits the number of partitions to 16.  Better to avoid
another hard-coded constant, if possible.

    # ls -lh /dev/bcache*
    brw-rw---- 1 root disk 254,  0 Mar 31 20:17 /dev/bcache0
    brw-rw---- 1 root disk 254,  1 Mar 31 20:17 /dev/bcache0p1
    brw-rw---- 1 root disk 254, 16 Mar 31 20:17 /dev/bcache16
    brw-rw---- 1 root disk 254, 17 Mar 31 20:17 /dev/bcache16p1
    brw-rw---- 1 root disk 254, 32 Mar 31 20:17 /dev/bcache32
    brw-rw---- 1 root disk 254, 33 Mar 31 20:17 /dev/bcache32p1

We had to solve almost exactly this problem in rbd.  I can submit
a patch for bcache if it helps ceph-disk in the long run.

Thanks,

                Ilya
