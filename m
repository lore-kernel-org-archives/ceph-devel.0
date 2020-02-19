From: Xiubo Li <xiubli@redhat.com>
Subject: Re: BUG: ceph_inode_cachep and ceph_dentry_cachep caches are not
 clean when destroying
Date: Wed, 19 Feb 2020 19:01:03 +0800
Message-ID: <bed8db55-50e1-a787-c9d4-a7c0f3c6c9d2@redhat.com>
References: <23e2b9a7-5ff6-1f07-ff03-08abcbf1457f@redhat.com>
 <CAOi1vP8b1aCph3NkAENEtAKfPDa8J03cNxwOZ+KSn1-te=6g0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21254 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726497AbgBSLBN (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Feb 2020 06:01:13 -0500
In-Reply-To: <CAOi1vP8b1aCph3NkAENEtAKfPDa8J03cNxwOZ+KSn1-te=6g0w@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Patrick Donnelly <pdonnell@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2020/2/19 18:53, Ilya Dryomov wrote:
> On Wed, Feb 19, 2020 at 10:39 AM Xiubo Li <xiubli@redhat.com> wrote:
>> Hi Jeff, Ilya and all
>>
>> I hit this call traces by running some test cases when unmounting the fs
>> mount points.
>>
>> It seems there still have some inodes or dentries are not destroyed.
>>
>> Will this be a problem ? Any idea ?
> Hi Xiubo,
>
> Of course it is a problem ;)
>
> These are all in ceph_inode_info and ceph_dentry_info caches, but
> I see traces of rbd mappings as well.  Could you please share your
> test cases?  How are you unloading modules?

I am not sure exactly in which one, mostly I was running the following 
commands.

1, ./bin/rbd map share -o mount_timeout=30

2, ./bin/rbd unmap share

3, ./bin/mount.ceph :/ /mnt/cephfs/

4, `for i in {0..1000}; do mkdir /mnt/cephfs/dir$0; done` and `for i in 
{0..1000}; do rm -rf /mnt/cephfs/dir$0; done`

5, umount /mnt/cephfs/

6, rmmod ceph; rmmod rbd; rmmod libceph

This it seems none business with the rbd mappings.

Thanks.

BRs

Xiubo


> Thanks,
>
>                  Ilya
>
