From: John Spray <jspray@redhat.com>
Subject: Re: ceph.dir.rbytes inconsistent on different hosts
Date: Wed, 14 Jun 2017 08:34:36 -0400
Message-ID: <CALe9h7c6DQM40UK8p_cS0x9xzsa9fQDoe_8ntJTEe9mh6cyepA@mail.gmail.com>
References: <CAGbvivJw+gEDijgq3eG41k78K2AGh+HknKwE7FKVUGo01Wd3SA@mail.gmail.com>
 <CABZ+qq=NUHM6v7v5kS5FD8DQsPiSNbBAgU+qY1=vcANNZ4+zHg@mail.gmail.com>
 <CAGbvivLGTLXDLb5JUr3481L-CE0tJo2eR9LZ2akBeh8gz29d-A@mail.gmail.com>
 <CALe9h7f8sg+z5WaKkPsqQ1go_AWkKyiMn5GM8+xz1e6RWWHG3Q@mail.gmail.com> <FA6D3991-C236-4D52-9F1C-3FDCB24C2B41@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f176.google.com ([209.85.128.176]:35855 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751904AbdFNMe6 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 08:34:58 -0400
Received: by mail-wr0-f176.google.com with SMTP id 36so66020814wry.3
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 05:34:57 -0700 (PDT)
In-Reply-To: <FA6D3991-C236-4D52-9F1C-3FDCB24C2B41@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Wyllys Ingersoll <wyllys.ingersoll@keepertech.com>, Dan van der Ster <dan@vanderster.com>, Ceph Development <ceph-devel@vger.kernel.org>

Nice!

On Wed, Jun 14, 2017 at 3:59 AM, Yan, Zheng <zyan@redhat.com> wrote:
>
>> On 14 Jun 2017, at 03:19, John Spray <jspray@redhat.com> wrote:
>>
>> On Tue, Jun 13, 2017 at 9:05 AM, Wyllys Ingersoll
>> <wyllys.ingersoll@keepertech.com> wrote:
>>> That sounds similar but Im not sure if its the same issue.  Our mounts
>>> were done using kernel mounting, not fuse.
>>
>> The fix for userspace was to issue a stat on inodes before reading
>> virtual xattrs:
>>
>> commit 532dc4b68e538c189ef828f67cecd0d647a62250
>> Author: John Spray <john.spray@redhat.com>
>> Date:   Wed Mar 15 15:32:47 2017 +0000
>>
>>    client: getattr before read on ceph.* xattrs
>>
>>    Previously we were returning values for quota, layout
>>    xattrs without any kind of update -- the user just got
>>    whatever happened to be in our cache.
>>
>>    Clearly this extra round trip has a cost, but reads of
>>    these xattrs are fairly rare, happening on admin
>>    intervention rather than in normal operation.
>>
>> We didn't look at doing it in the kernel client at that point because
>> the motivation was to fix quota handling, and the kernel client
>> doesn't do quotas.
>>
>> It seems like we should probably update the kernel client to do the
>> same thing -- Zheng, what do you think?
>>
> done, https://github.com/ceph/ceph-client/commit/d69a42d91de651d5981d1b5538132ff362a9ee
>
> Regards
> Yan, Zheng
>
>> John
>>
>>> On Tue, Jun 13, 2017 at 6:02 AM, Dan van der Ster <dan@vanderster.com> wrote:
>>>> Sounds like this issue?
>>>>
>>>>   http://tracker.ceph.com/issues/17939
>>>>
>>>> Cheers, Dan
>>>>
>>>>
>>>>
>>>> On Mon, Jun 12, 2017 at 9:45 PM, Wyllys Ingersoll
>>>> <wyllys.ingersoll@keepertech.com> wrote:
>>>>> Ceph 10.2.7
>>>>> Ubuntu 16.04.2
>>>>>
>>>>> We have 2 hosts running identical versions of ceph with identical
>>>>> ceph.conf configuration files.
>>>>> Both mount /cephfs with the same options.
>>>>>
>>>>> We have a directory under /cephfs with a 4GB file in it.  The
>>>>> ceph.dir.rbytes xattr reported by ceph is different on the 2 hosts.
>>>>> One is correct, one is not.
>>>>>
>>>>> One host reports the 'ceph.dir.rbytes' correctly as 4129644548, the
>>>>> other reports it incorrectly as  2389190660
>>>>> Any ideas why this would be happening ?
>>>>>
>>>>> - Wyllys Ingersoll
>>>>>  Keeper Technology, LLC
>>>>>
>>>>>
>>>>> HOST A (correct values):
>>>>> $ ls -alF /cephfs/exports/smbtest
>>>>> total 4032857
>>>>> drwxrwxrwx 1 root    root    4129644548 May 31 11:28 ./
>>>>> drwxr-xr-x 1 root    root    4129644548 May 31 11:25 ../
>>>>> -rw-r--r-- 1 2000501 2000514       4096 May 31 11:26 ._.DS_Store
>>>>> -rw-r--r-- 1 2000501 2000514       6148 Jun  1 14:37 .DS_Store
>>>>> -rw-r--r-- 1 2000501 2000514 4129634304 Jun 12 15:25 test-2017-05-30-m1.iso
>>>>>
>>>>> $ getfattr -d -m ceph.dir /cephfs/exports/smbtest
>>>>> getfattr: Removing leading '/' from absolute path names
>>>>> # file: cephfs/exports/smbtest
>>>>> ceph.dir.rbytes="4129644548"
>>>>>
>>>>> HOST B (incorrect values)
>>>>> $ ls -alF /cephfs/exports/smbtest
>>>>> total 4032857
>>>>> drwxrwxrwx 1 root          root         2389190660 May 31 11:28 ./
>>>>> drwxr-xr-x 1 root          root         4129644548 May 31 11:25 ../
>>>>> -rw-r--r-- 1 2000501 2000514       4096 May 31 11:26 ._.DS_Store
>>>>> -rw-r--r-- 1 2000501 2000514       6148 Jun  1 14:37 .DS_Store
>>>>> -rw-r--r-- 1 2000501 2000514 4129634304 Jun 12 15:25 test-2017-05-30-m1.iso
>>>>>
>>>>> $ getfattr -d -m ceph.dir.rbytes /cephfs/exports/smbtest
>>>>> getfattr: Removing leading '/' from absolute path names
>>>>> # file: cephfs/exports/smbtest
>>>>> ceph.dir.rbytes="2389190660"
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
