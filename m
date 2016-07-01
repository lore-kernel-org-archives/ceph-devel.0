From: John Spray <jspray@redhat.com>
Subject: Re: cephfs: status of directory fragmentation and multiple filesystems
Date: Fri, 1 Jul 2016 12:13:58 +0100
Message-ID: <CALe9h7c7xRc+t_YM1+p=mnUcmCt1zj_2W=OdC7jCNaONB65rkQ@mail.gmail.com>
References: <CA+H5UW0Uu_+GYNq6EKw7GguiL-w3bEv3AKV72APLSbqgkLzS6A@mail.gmail.com>
 <CAJ4mKGZQ3C8HT=m=0afmEe3tLA=xpxb==VHfKtPpOAgSC-gxPQ@mail.gmail.com> <CAEYCsV+Nu=6r7+cVTay2exuZSgsPXNK-YnKS3jzvgus-y-NhUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f180.google.com ([209.85.220.180]:33690 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751960AbcGALOS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 1 Jul 2016 07:14:18 -0400
Received: by mail-qk0-f180.google.com with SMTP id o76so82174890qke.0
        for <ceph-devel@vger.kernel.org>; Fri, 01 Jul 2016 04:14:18 -0700 (PDT)
In-Reply-To: <CAEYCsV+Nu=6r7+cVTay2exuZSgsPXNK-YnKS3jzvgus-y-NhUQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Xiaoxi Chen <superdebuger@gmail.com>
Cc: Gregory Farnum <gfarnum@redhat.com>, Radoslaw Zarzynski <rzarzynski@mirantis.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Jul 1, 2016 at 3:17 AM, Xiaoxi Chen <superdebuger@gmail.com> wrote:
> Greg,
>     Would you mind sharing your insight about potential issue of
> multiple FS?  It looks to me like we can separate every component of
> the cluster --- i.e , each FS has its own data pool ,meta pool, and
> even the pools can be mapped to different osds. Seperate MDS nodes so
> they dont  compete for memory .  The only sharing part is Monitor , so
> seems it is simpler than the dir frag and very likely to work ?
>
>      As single MDS can only sustain 1~2 CPU cores and provide less
> than 2000 TPS for most of the operation (tested with mds_log = false ,
> which is the upper bound of performance. op including rename, utime,
> open).  So multi-fs is some kind of *must have* for  one like to
> provide FS service.

One of the reasons for the multi fs capability was for cases like Manila ;-)

The multi-filesystem support is indeed simpler than the other
experimental features, although that's not to say it's necessarily not
buggy.  For example, in the 10.2.0 release we had a bug where if you
were mounting a non-default filesystem the clients would fail to pick
up on MDS failover: http://tracker.ceph.com/issues/16022

The main thing I'd say about the multi-fs support is that if it seems
like it's working for you, it's probably going to keep working (unlike
some other things which might work fine for weeks and then one day hit
an issue almost at random).

We are currently a bit behind on backporting fixes to jewel, so if
you're developing against things like multi-fs, I would suggest that
you develop your integration with master, and then make sure the right
bits have made it into a jewel release before deploying to production.

John

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
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
