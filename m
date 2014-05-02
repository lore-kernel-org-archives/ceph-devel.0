From: Hannes Landeholm <hannes@jumpstarter.io>
Subject: Re: rbd unmap deadlock
Date: Fri, 2 May 2014 18:23:37 +0200
Message-ID: <CABt9es85qWwoZNwq_-=7NANV8ZejTKbA6jRfE0nxdVhbZd+GMw@mail.gmail.com>
References: <CABt9es9QGaVKT7KNtnXhrGNSSdhn12Kgn1e2nUSuUys3A-3Ysg@mail.gmail.com>
	<5363C338.1090506@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f180.google.com ([209.85.217.180]:58463 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752774AbaEBQXj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 May 2014 12:23:39 -0400
Received: by mail-lb0-f180.google.com with SMTP id w7so3312792lbi.11
        for <ceph-devel@vger.kernel.org>; Fri, 02 May 2014 09:23:38 -0700 (PDT)
In-Reply-To: <5363C338.1090506@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Fri, May 2, 2014 at 6:09 PM, Alex Elder <elder@ieee.org> wrote:
> On 05/02/2014 11:04 AM, Hannes Landeholm wrote:
>>
>> Hi, I just had a rbd unmap operation deadlock on my development
>> machine. The file system was in heavy use before I did it but I have a
>> sync barrier before the umount and unmap so it shouldn't matter. The
>> rbd unmap hanged in "State:  D (disk sleep)". I have so far waited
>> over 10 minutes, this normally takes < 1 sec.
>>
>> Here is the /proc/pid/stack output:
>>
>> [<ffffffff8107e23a>] flush_workqueue+0x11a/0x5a0
>> [<ffffffffa031b415>] ceph_msgr_flush+0x15/0x20 [libceph]
>> [<ffffffffa03219c6>] ceph_monc_stop+0x46/0x120 [libceph]
>> [<ffffffffa031af28>] ceph_destroy_client+0x38/0xa0 [libceph]
>> [<ffffffffa0359b88>] rbd_client_release+0x68/0xa0 [rbd]
>> [<ffffffffa0359bec>] rbd_put_client+0x2c/0x30 [rbd]
>> [<ffffffffa0359c06>] rbd_dev_destroy+0x16/0x30 [rbd]
>> [<ffffffffa0359c77>] rbd_dev_image_release+0x57/0x60 [rbd]
>> [<ffffffffa035adc7>] do_rbd_remove.isra.25+0x167/0x1b0 [rbd]
>> [<ffffffffa035ae54>] rbd_remove+0x24/0x30 [rbd]
>> [<ffffffff8136ea67>] bus_attr_store+0x27/0x30
>> [<ffffffff81218d4d>] sysfs_kf_write+0x3d/0x50
>> [<ffffffff8121c982>] kernfs_fop_write+0xd2/0x140
>> [<ffffffff811a67fa>] vfs_write+0xba/0x1e0
>> [<ffffffff811a7206>] SyS_write+0x46/0xc0
>> [<ffffffff814e66e9>] system_call_fastpath+0x16/0x1b
>> [<ffffffffffffffff>] 0xffffffffffffffff
>>
>> Unfortunately our rbd.ko does not appear to have any debug symbols.
>>
>> Other unmaps also hanged after this that have the same parent. (We are
>> using layering.) Linux version: 3.14.1.
>
> Is this "stock" 3.14.1?  Can you provide the full output of "uname -a"?
> And if possible, either /proc/config.gz or /boot/config-3.13.1 (or
> whichever file seems to match the currently-running kernel)?

Yes, this is a "stock" Arch 3.14.1 kernel with no custom patches.

uname: Linux localhost 3.14.1-1-js #1 SMP PREEMPT Tue Apr 15 17:59:05
CEST 2014 x86_64 GNU/Linux

config: http://pastebin.com/unZCzXZZ

Thank you for your time,
--
Hannes Landeholm
