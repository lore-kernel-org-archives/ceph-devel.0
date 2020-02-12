From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: fs add reconfiguring superblock parameters support
Date: Wed, 12 Feb 2020 22:45:11 +0800
Message-ID: <8983edb7-8f8e-9b73-12eb-9f19ace5b440@redhat.com>
References: <20200212085454.35665-1-xiubli@redhat.com>
 <CAOi1vP_GJ99XW-ncn2WD1GwvkZ4MU2HqXAbQiuGm3hqmg3otPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32664 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728139AbgBLOp2 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Feb 2020 09:45:28 -0500
In-Reply-To: <CAOi1vP_GJ99XW-ncn2WD1GwvkZ4MU2HqXAbQiuGm3hqmg3otPQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2020/2/12 19:17, Ilya Dryomov wrote:
> On Wed, Feb 12, 2020 at 9:55 AM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This will enable the remount and reconfiguring superblock params
>> for the fs. Currently some mount options are not allowed to be
>> reconfigured.
>>
>> It will working like:
>> $ mount.ceph :/ /mnt/cephfs -o remount,mount_timeout=100
>>
>> URL:https://tracker.ceph.com/issues/44071
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   block/bfq-cgroup.c           |   1 +
>>   drivers/block/rbd.c          |   2 +-
>>   fs/ceph/caps.c               |   2 +
>>   fs/ceph/mds_client.c         |   5 +-
>>   fs/ceph/super.c              | 126 +++++++++++++++++++++++++++++------
>>   fs/ceph/super.h              |   2 +
>>   include/linux/ceph/libceph.h |   4 +-
>>   net/ceph/ceph_common.c       |  83 ++++++++++++++++++++---
>>   8 files changed, 192 insertions(+), 33 deletions(-)
>>
>> diff --git a/block/bfq-cgroup.c b/block/bfq-cgroup.c
>> index e1419edde2ec..b3d42200182e 100644
>> --- a/block/bfq-cgroup.c
>> +++ b/block/bfq-cgroup.c
>> @@ -12,6 +12,7 @@
>>   #include <linux/ioprio.h>
>>   #include <linux/sbitmap.h>
>>   #include <linux/delay.h>
>> +#include <linux/rbtree.h>
> Hi Xiubo,
>
> This hunk touches the block layer.

Ah, okay, I thought I have removed this.

[...]
>> +       if (memcmp(&new_opts->fsid, &opts->fsid, sizeof(opts->fsid)))
>> +               return invalf(fc, "ceph: reconfiguration of fsid not allowed");
>> +
>> +       if (strcmp_null(new_opts->name, opts->name))
>> +               return invalf(fc, "ceph: reconfiguration of name not allowed");
>> +
>> +       if (new_opts->key && (!opts->key ||
>> +               new_opts->key->type != opts->key->type ||
>> +               new_opts->key->created.tv_sec != opts->key->created.tv_sec ||
>> +               new_opts->key->created.tv_nsec != opts->key->created.tv_nsec ||
>> +               new_opts->key->len != opts->key->len ||
>> +               memcmp(new_opts->key->key, opts->key->key, opts->key->len)))
>> +               return invalf(fc, "ceph: reconfiguration of secret not allowed");
>> +
>> +       opts->osd_keepalive_timeout = new_opts->osd_keepalive_timeout;
>> +       opts->osd_idle_ttl = new_opts->osd_idle_ttl;
>> +       opts->mount_timeout = new_opts->mount_timeout;
>> +       opts->osd_request_timeout = new_opts->osd_request_timeout;
> What is the use case for reconfiguring any of these options?  They are
> all low level and aren't really meant to be reconfigured.

Okay, actually now these are not needed to reconfigured.

>> +       opts->flags = new_opts->flags;
> This is particularly true for flags.  Reconfiguring tcp_nodelay will
> not have effect on sockets that are already open, reconfiguring noshare
> will not unshare the client instance, etc.  Messing with crc or
> cephx_sign_messages is very likely to hang the client.

Okay, will check this more.

> Thanks,
>
>                  Ilya
>
