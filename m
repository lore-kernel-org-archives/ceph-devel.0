From: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>
Subject: Re: dmcrypt with luks keys in hammer
Date: Mon, 20 Jul 2015 18:23:47 -0400
Message-ID: <CAGbvivJHpzvFDpNo4ZYZL5W1uzG2pMNHM+VjzSsH-2oyV7LZ-A@mail.gmail.com>
References: <CAGbvivJH4UJtkcHmgvA7c88YJ6hgmm86fArqJJOszrtBh=kgrg@mail.gmail.com>
	<alpine.DEB.2.00.1507201419330.8878@cobra.newdream.net>
	<CAGbviv+2O1z-=9WWSFAFzox=B5dgsASNpYpi5jinmgPW=VTVVw@mail.gmail.com>
	<alpine.DEB.2.00.1507201521000.8878@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:38743 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755882AbbGTWXr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 20 Jul 2015 18:23:47 -0400
Received: by iggf3 with SMTP id f3so92650760igg.1
        for <ceph-devel@vger.kernel.org>; Mon, 20 Jul 2015 15:23:47 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1507201521000.8878@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org

On Mon, Jul 20, 2015 at 6:21 PM, Sage Weil <sage@newdream.net> wrote:
> On Mon, 20 Jul 2015, Wyllys Ingersoll wrote:
>> No luck with ceph-disk-activate (all or just one device).
>>
>> $ sudo ceph-disk-activate /dev/sdv1
>> mount: unknown filesystem type 'crypto_LUKS'
>> ceph-disk: Mounting filesystem failed: Command '['/bin/mount', '-t',
>> 'crypto_LUKS', '-o', '', '--', '/dev/sdv1',
>> '/var/lib/ceph/tmp/mnt.QHe3zK']' returned non-zero exit status 32
>>
>>
>> Its odd that it should complain about the "crypto_LUKS" filesystem not
>> being recognized, because it did mount some of the LUKS systems
>> successfully, though not sometimes just the data and not the journal
>> (or vice versa).
>>
>> $ lsblk /dev/sdb
>> NAME                                            MAJ:MIN RM   SIZE RO
>> TYPE  MOUNTPOINT
>> sdb                                               8:16   0   3.7T  0 disk
>> ??sdb1                                            8:17   0   3.6T  0 part
>> ? ??e8bc1531-a187-4fd2-9e3f-cf90255f89d0 (dm-0) 252:0    0   3.6T  0
>> crypt /var/lib/ceph/osd/ceph-54
>> ??sdb2                                            8:18   0    10G  0 part
>>   ??temporary-cryptsetup-1235 (dm-6)            252:6    0   125K  1 crypt
>>
>>
>> $ blkid /dev/sdb1
>> /dev/sdb1: UUID="d6194096-a219-4732-8d61-d0c125c49393" TYPE="crypto_LUKS"
>>
>>
>> A race condition (or other issue) with udev seems likely given that
>> its rather random which ones come up and which ones don't.
>
> A race condition during creation or activation?  If it's activation I
> would expect ceph-disk activate ... to work reasonably reliably when
> called manually (on a single device at a time).
>
> sage
>


Im not sure. I do know that all of the disks *did* work after the
initial installation and activation, but they fail after reboot, and
the failures are non-deterministic.  Im not really sure how to debug
it any further.
