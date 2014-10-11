From: Andrey Korolyov <andrey@xdel.ru>
Subject: Re: [Qemu-devel] qemu drive-mirror to rbd storage : no sparse rbd image
Date: Sat, 11 Oct 2014 12:30:40 +0400
Message-ID: <CABYiri_An2fxAJYzxwdDJjFnUF2ME4HjY-jrcWE_jrDi9bshvw@mail.gmail.com>
References: <20141011070118.GB4965@fam-t430.nay.redhat.com>
 <c22b3e6d-2fbc-4de9-8bfd-d3eb39ea8fe2@mailpro> <20141011082535.GC4965@fam-t430.nay.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:42594 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751795AbaJKIbB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 11 Oct 2014 04:31:01 -0400
Received: by mail-qc0-f172.google.com with SMTP id o8so3020326qcw.17
        for <ceph-devel@vger.kernel.org>; Sat, 11 Oct 2014 01:31:00 -0700 (PDT)
In-Reply-To: <20141011082535.GC4965@fam-t430.nay.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Fam Zheng <famz@redhat.com>
Cc: Alexandre DERUMIER <aderumier@odiso.com>, qemu-devel <qemu-devel@nongnu.org>, Ceph Devel <ceph-devel@vger.kernel.org>

On Sat, Oct 11, 2014 at 12:25 PM, Fam Zheng <famz@redhat.com> wrote:
> On Sat, 10/11 10:00, Alexandre DERUMIER wrote:
>> >>What is the source format? If the zero clusters are actually unallocated in the
>> >>source image, drive-mirror will not write those clusters either. I.e. with
>> >>"drive-mirror sync=top", both source and target should have the same "qemu-img
>> >>map" output.
>>
>> Thanks for your reply,
>>
>> I had tried drive mirror (sync=full) with
>>
>> raw file (sparse) -> rbd  (no sparse)
>> rbd (sparse) -> rbd (no sparse)
>> raw file (sparse) -> qcow2 on ext4  (sparse)
>> rbd (sparse) -> raw on ext4 (sparse)
>>
>> Also I see that I have the same problem with target file format on xfs.
>>
>> raw file (sparse) -> qcow2 on xfs  (no sparse)
>> rbd (sparse) -> raw on xfs (no sparse)
>>
>
> These don't tell me much. Maybe it's better to show the actual commands and how
> you tell sparse from no sparse?
>
> Does "qcow2 -> qcow2" work for you on xfs?
>
>>
>> I only have this problem with drive-mirror, qemu-img convert seem to simply skip zero blocks.
>>
>>
>> Or maybe this is because I'm using sync=full ?
>>
>> What is the difference between full and top ?
>>
>> ""sync": what parts of the disk image should be copied to the destination;
>>   possibilities include "full" for all the disk, "top" for only the sectors
>>   allocated in the topmost image".
>>
>> (what is topmost image ?)
>
> For "sync=top", only the clusters allocated in the image itself is copied; for
> "full", all those clusters allocated in the image itself, and its backing
> image, and it's backing's backing image, ..., are copied.
>
> The image itself, having a backing image or not, is called the topmost image.
>
> Fam
> --

Just a wild guess - Alexandre, did you tried detect-zeroes blk option
for mirroring targets?
