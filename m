From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: cephfs: status of directory fragmentation and multiple filesystems
Date: Thu, 30 Jun 2016 20:19:56 -0700
Message-ID: <CAJ4mKGZ2YODhYcps=7itGd4YgrCbRsApJn0-Ez5+tLjhGA46ZA@mail.gmail.com>
References: <CA+H5UW0Uu_+GYNq6EKw7GguiL-w3bEv3AKV72APLSbqgkLzS6A@mail.gmail.com>
 <CAJ4mKGZQ3C8HT=m=0afmEe3tLA=xpxb==VHfKtPpOAgSC-gxPQ@mail.gmail.com> <CAEYCsV+Nu=6r7+cVTay2exuZSgsPXNK-YnKS3jzvgus-y-NhUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33134 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751969AbcGADUI (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 30 Jun 2016 23:20:08 -0400
Received: by mail-vk0-f49.google.com with SMTP id k68so50425106vkb.0
        for <ceph-devel@vger.kernel.org>; Thu, 30 Jun 2016 20:20:08 -0700 (PDT)
In-Reply-To: <CAEYCsV+Nu=6r7+cVTay2exuZSgsPXNK-YnKS3jzvgus-y-NhUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Radoslaw Zarzynski <rzarzynski@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Jun 30, 2016 at 7:17 PM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> Greg,
>     Would you mind sharing your insight about potential issue of
> multiple FS?  It looks to me like we can separate every component of
> the cluster --- i.e , each FS has its own data pool ,meta pool, and
> even the pools can be mapped to different osds. Seperate MDS nodes so
> they dont  compete for memory .  The only sharing part is Monitor , so
> seems it is simpler than the dir frag and very likely to work ?

I actually expect it does work. John may have more thoughts since he
wrote it, but the code merged pretty late in the Jewel cycle and there
are a few things to think about
1) comparative lack of testing, due to newness of code,
2) possibility that some interfaces may change,
3) lack of multi-fs awareness in many of the fsck systems.

This comes up especially if, for instance, you want to give each
tenant their own FS. Providing them an MDS daemon may be feasible, but
giving each user their own pool probably isn't. We'll be enabling (or
have enabled? I forget) you to put each FS in a different namespace,
rather than separate pools, but none of the fsck tools are prepared to
see multiple inodes of the same number distinguished only by
namespace.
-Greg

>
>      As single MDS can only sustain 1~2 CPU cores and provide less
> than 2000 TPS for most of the operation (tested with mds_log = false ,
> which is the upper bound of performance. op including rename, utime,
> open).  So multi-fs is some kind of *must have* for  one like to
> provide FS service.
>
> Xiaoxi
>
> 2016-06-30 1:53 GMT+08:00 Gregory Farnum <gfarnum@redhat.com>:
>> On Wed, Jun 29, 2016 at 10:47 AM, Radoslaw Zarzynski
>> <rzarzynski@mirantis.com> wrote:
>>> Hello,
>>>
>>> I saw the recent question about having more than 1 active
>>> MDS in a cluster. I would like to ask similar ones but in
>>> the matter of 1) directory fragmentation and 2) running
>>> multiple filesystems within same cluster.
>>>
>>> When those features are expected to be production-ready?
>>> What do we need to achieve this status?
>>
>> These are both all about the QA work of just making sure they're
>> well-tested in the nightlies, and demonstrating that the functionality
>> isn't broken. We're expecting dirfrags to be enabled in Kraken; I
>> don't know if there's a target timeline around multi-fs.
>>
>> There are available tickets in the tracker that basically come out to
>> "demonstrate dirfrags actually get exercised in the nightlies", etc if
>> you're interested in contributing!
>> -Greg
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
