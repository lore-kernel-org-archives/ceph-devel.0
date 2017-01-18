From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: failed to mount CephFS sub directory: permission denied or I/O error
Date: Wed, 18 Jan 2017 10:38:37 -0800
Message-ID: <CAJ4mKGbAb5GA_t3+wAUd+0iOgN8-w+-ANXmPnnfcJGsR7gx+Hw@mail.gmail.com>
References: <CAD-gW=mFgSxAcn9xh2ny3zxxydL85D1gqOoF31t1dFFzFHmGng@mail.gmail.com>
 <CAD-gW=mR1DJRQLJVwMPv6Fju0uTbo3uoU7kYGC=PgtPLJPK_aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f54.google.com ([209.85.214.54]:37061 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751914AbdARSij (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 18 Jan 2017 13:38:39 -0500
Received: by mail-it0-f54.google.com with SMTP id r185so17228140ita.0
        for <ceph-devel@vger.kernel.org>; Wed, 18 Jan 2017 10:38:39 -0800 (PST)
In-Reply-To: <CAD-gW=mR1DJRQLJVwMPv6Fju0uTbo3uoU7kYGC=PgtPLJPK_aQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Huamin Chen <hchen@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I updated your ticket http://tracker.ceph.com/issues/18589 with what I
think is going on here. Note that adding "mds allow r" grants read
capabilities on *everything*, which you probably don't want.
-Greg

On Wed, Jan 18, 2017 at 9:35 AM, Huamin Chen <hchen@redhat.com> wrote:
> Adding "mds caps allow r" fixes the problem.
>
> On Wed, Jan 18, 2017 at 11:38 AM, Huamin Chen <hchen@redhat.com> wrote:
>>
>> Hi
>>
>> I have trouble mounting a ceph fs sub directory. I am using ceph jewel.
>> [root@rootfs-dev cephfs]# ceph version
>> ceph version 10.2.5 (c461ee19ecbc0c5c330aca20f7392c9a00730367)
>>
>>
>> First I got permission denied with the following caps:
>>
>> [root@rootfs-dev cephfs]# ceph auth get client.bar
>> exported keyring for client.bar
>> [client.bar]
>> key = AQA+ln9Yfm6DKhAA10k7QkdkfIAKqmM6xeCsxA==
>> caps mds = "allow rw path=/volumes/kubernetes/test1"
>> caps mon = "allow *"
>> caps osd = "allow rwx pool=fs_data"
>> [root@rootfs-dev cephfs]# mount -t ceph
>> 172.24.0.4:6789:/volumes/kubernetes/test1 /tmp/mnt -o
>> name=bar,secret=AQA+ln9Yfm6DKhAA10k7QkdkfIAKqmM6xeCsxA==
>> mount error 13 = Permission denied
>>
>>
>> Then I modified caps, this time I got I/O error.
>>
>> [root@rootfs-dev cephfs]# ceph auth caps client.bar mon 'allow *' mds
>> 'allow *' osd 'allow  *'
>> updated caps for client.bar
>> [root@rootfs-dev cephfs]# mount -t ceph
>> 172.24.0.4:6789:/volumes/kubernetes/test1 /tmp/mnt -o
>> name=bar,secret=AQA+ln9Yfm6DKhAA10k7QkdkfIAKqmM6xeCsxA==
>> mount error 5 = Input/output error
>>
>>
>> However ceph-fuse can mount the sub directory, using the same credential.
>>
>> [root@rootfs-dev cephfs]# ceph-fuse /mnt/test --id=bar
>> --client-mountpoint=/volumes/kubernetes/test1
>> ceph-fuse[41114]: starting ceph client
>> 2017-01-18 16:30:07.400280 7f83f2f27ec0 -1 init, newargv = 0x7f83fd126780
>> newargc=11
>> ceph-fuse[41114]: starting fuse
>>
>> Help appreciated.
>>
>> Thanks
>>
>> Huamin
>
>
