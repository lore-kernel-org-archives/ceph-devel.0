From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: Ceph kRBD stuck after disk crash
Date: Tue, 5 Aug 2014 18:28:07 +0400
Message-ID: <CALFYKtD5oTTTujLU-ax6+_Yz2p5+9qgYMXepHH4rcAo38nXXiA@mail.gmail.com>
References: <CAPZO0-O2eRt1t9o_aN6vZ88gwfT2MMcvjN-Y+-BiFkXHuPo3tA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f48.google.com ([209.85.216.48]:65370 "EHLO
	mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753527AbaHEO2I (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 10:28:08 -0400
Received: by mail-qa0-f48.google.com with SMTP id m5so990729qaj.35
        for <ceph-devel@vger.kernel.org>; Tue, 05 Aug 2014 07:28:07 -0700 (PDT)
In-Reply-To: <CAPZO0-O2eRt1t9o_aN6vZ88gwfT2MMcvjN-Y+-BiFkXHuPo3tA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Thorwald Lundqvist <thorwald@jumpstarter.io>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Aug 5, 2014 at 5:59 PM, Thorwald Lundqvist
<thorwald@jumpstarter.io> wrote:
> Hi!
>
> I've just experienced a disk crash in my ceph cluster. This seems to
> have caused an error in the kernel since every I/O command sent to any
> mapped RBD is defered indefinitely, even an hour later, the OSD is
> already taken out of the cluster and ceph -s says HEALTH_OK.
>
> A kernel dump is provided at this pastebin link: http://pastebin.com/WMqmiUsM
>
> What did I do prior the crash?
>
> I mapped one clean rbd device at /dev/rbd0 and one rbd device that had
> a partition and ext4 filesystem at 20GB each
>
> I started to dd rbd1 to rbd0 (dd if=/dev/rbd1 of=/dev/rbd0 bs=4M) It
> copied a few GB, then deep-scrub started and at that moment one of the
> disks failed. and dd got stuck (disk defered). And it still is.
>
> I think that only a reboot of the server can fix this problem now.
>
> This is not normal behavior when a disk crashes, right?

No, it's not ;)  Technically this is not a crash though, it's more of
a deadlock - one process ended up blocking forever while holding
a crucial lock.  See http://tracker.ceph.com/issues/8818.

The fix is going to be in 3.17-rc1 so it should catch the last 3.15
stable update.

Thanks,

                Ilya
