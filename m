From: Thorwald Lundqvist <thorwald@jumpstarter.io>
Subject: Re: Ceph kRBD stuck after disk crash
Date: Tue, 5 Aug 2014 16:38:01 +0200
Message-ID: <CAPZO0-N4EFAZLr4M_xLPPjhkqao+Rd6dSm5mLNinr_V6-ALA_Q@mail.gmail.com>
References: <CAPZO0-O2eRt1t9o_aN6vZ88gwfT2MMcvjN-Y+-BiFkXHuPo3tA@mail.gmail.com>
	<CALFYKtD5oTTTujLU-ax6+_Yz2p5+9qgYMXepHH4rcAo38nXXiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:49801 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752121AbaHEOiE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Aug 2014 10:38:04 -0400
Received: by mail-la0-f45.google.com with SMTP id ty20so804160lab.4
        for <ceph-devel@vger.kernel.org>; Tue, 05 Aug 2014 07:38:01 -0700 (PDT)
In-Reply-To: <CALFYKtD5oTTTujLU-ax6+_Yz2p5+9qgYMXepHH4rcAo38nXXiA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Thank you Eric and Ilya, The disk crash does not seems to not be
related even though it happened almost at the same time then I guess.

No dd until 3.15.9 then. ;)

Thank you again.

On Tue, Aug 5, 2014 at 4:28 PM, Ilya Dryomov <ilya.dryomov@inktank.com> wrote:
> On Tue, Aug 5, 2014 at 5:59 PM, Thorwald Lundqvist
> <thorwald@jumpstarter.io> wrote:
>> Hi!
>>
>> I've just experienced a disk crash in my ceph cluster. This seems to
>> have caused an error in the kernel since every I/O command sent to any
>> mapped RBD is defered indefinitely, even an hour later, the OSD is
>> already taken out of the cluster and ceph -s says HEALTH_OK.
>>
>> A kernel dump is provided at this pastebin link: http://pastebin.com/WMqmiUsM
>>
>> What did I do prior the crash?
>>
>> I mapped one clean rbd device at /dev/rbd0 and one rbd device that had
>> a partition and ext4 filesystem at 20GB each
>>
>> I started to dd rbd1 to rbd0 (dd if=/dev/rbd1 of=/dev/rbd0 bs=4M) It
>> copied a few GB, then deep-scrub started and at that moment one of the
>> disks failed. and dd got stuck (disk defered). And it still is.
>>
>> I think that only a reboot of the server can fix this problem now.
>>
>> This is not normal behavior when a disk crashes, right?
>
> No, it's not ;)  Technically this is not a crash though, it's more of
> a deadlock - one process ended up blocking forever while holding
> a crucial lock.  See http://tracker.ceph.com/issues/8818.
>
> The fix is going to be in 3.17-rc1 so it should catch the last 3.15
> stable update.
>
> Thanks,
>
>                 Ilya
