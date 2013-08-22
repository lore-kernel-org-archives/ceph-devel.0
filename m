From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: radosgw-agent testing
Date: Thu, 22 Aug 2013 09:02:00 -0700
Message-ID: <CABBk=J9HMwngLXYLZZJ9e-29gtiCMMZXBdzbHKLWeG0zWJJ63w@mail.gmail.com>
References: <CAA8043hiySh18_LR_v3opM=sMiSikciLr9o3+35M9=xs29t55g@mail.gmail.com>
	<CABBk=J_+76wWUgxHq=LEivbP7Ksp3a070DjCbcNsZXWtMScg7Q@mail.gmail.com>
	<CAA8043iSY7uezUJBh3_=_8UUEX_nHmsiRXVYHBH49Ns2tpnp-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ve0-f181.google.com ([209.85.128.181]:54507 "EHLO
	mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753036Ab3HVQCA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Aug 2013 12:02:00 -0400
Received: by mail-ve0-f181.google.com with SMTP id jz10so1658727veb.40
        for <ceph-devel@vger.kernel.org>; Thu, 22 Aug 2013 09:02:00 -0700 (PDT)
In-Reply-To: <CAA8043iSY7uezUJBh3_=_8UUEX_nHmsiRXVYHBH49Ns2tpnp-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: christophe courtaut <christophe.courtaut@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Aug 22, 2013 at 8:56 AM, christophe courtaut
<christophe.courtaut@gmail.com> wrote:
>> On Thu, Aug 22, 2013 at 4:38 AM, christophe courtaut
>> <christophe.courtaut@gmail.com> wrote:
>>> Hi Yehuda,
>>>
>>> I'm currently trying to test the radosgw-agent which lives in
>>> https://github.com/ceph/radosgw-agent
>>>
>>> I modified the vstart.sh script (you can see it here
>>> https://github.com/ceph/ceph/pull/522) to be able to launch multiple
>>> cluster with vstart.sh in different directories.
>>>
>>> I created a little script to automate the launch of two clusters and
>>> the setup of region and zone, so that i have a master and a slave
>>> cluster.
>>>
>>> With that setup, i encounter two problems:
>>>
>>> First when i try to create a bucket after setup is done using s3cmd,
>>> got this error
>>> ERROR: Access to bucket 'TEST' was denied.
>>> in the function open_bucket_pool_ctx, it tries to open the pool
>>> .rgw.buckets.index, but this pool doesn't seems to exist.
>>> Is this behaviour correct? Is it due to my setup? or should this pool
>>> be created?
>>
>> This pool should have been automatically created (if didn't exist
>> before). Not sure why it's not happening.
>
> Ok. I don't know where the automatic creation of this pool should be
> handled though.
>
>>>
>>> Second, is that i get a 403 while using the radosgw-agent on the
>>> previous setup, with the test.sh script.
>>> Am i doing something wrong here?
>>
>> Did you set the 'system' flag on the appropriate users?
>
> No i did miss that point. btw the option was not mentionned in the
> radosgw-admin help.
> here comes a pull request for that : https://github.com/ceph/ceph/pull/528
>
>>> To reproduce the first bug:
>>>
>>> - Get the vstart.sh script from https://github.com/ceph/ceph/pull/522
>>> - Get the script to launch cluster and the *.master *.zone files
>>> - Launch the script
>>> - Try to create a bucket with s3cmd
>>>
>>> To reproduce the second one :
>>>
>>> - Do the same setup as for the first one
>>> - Get the radosgw-agent repo
>>> - Get the test.sh script in this directory
>>> - Launch the test.sh script
>>>
>>> You can find below the various files i mentionned earlier
>>>
>>> the script for launching clusters
>>> http://pastebin.com/VSJhwRSs
>>>
>>> master.region file
>>> http://pastebin.com/pCrRpM3w
>>>
>>> master.zone file
>>> http://pastebin.com/gi1DDNvr
>>>
>>> slave.region file
>>> http://pastebin.com/idgMDYjj
>>>
>>> slave.zone file
>>> http://pastebin.com/m2KRnqdJ
>>
>> On both slave and master zone you didn't set the placement pools, so
>> it resorts to the default. What does 'radosgw-admin zone get' show on
>> both?
>
> radosgw-admin -c cluster-master/ceph.conf zone get
>
> { "domain_root": ".rgw",
>   "control_pool": ".rgw.control",
>   "gc_pool": ".rgw.gc",
>   "log_pool": ".log",
>   "intent_log_pool": ".intent-log",
>   "usage_log_pool": ".usage",
>   "user_keys_pool": ".users",
>   "user_email_pool": ".users.email",
>   "user_swift_pool": ".users.swift",
>   "user_uid_pool": ".",
>   "system_key": { "access_key": "0555b35654ad1656d804",
>       "secret_key":
> "h7GhxuBLTrlhVUyxSPUKUV8r\/2EI4ngqJxD7iBdBYLhwluN30JaT3Q=="},
>   "placement_pools": []}
>
> radosgw-admin -c cluster-slave/ceph.conf zone get
>
> { "domain_root": ".rgw",
>   "control_pool": ".rgw.control",
>   "gc_pool": ".rgw.gc",
>   "log_pool": ".log",
>   "intent_log_pool": ".intent-log",
>   "usage_log_pool": ".usage",
>   "user_keys_pool": ".users",
>   "user_email_pool": ".users.email",
>   "user_swift_pool": ".users.swift",
>   "user_uid_pool": ".",
>   "system_key": { "access_key": "0555b35654ad1656d804",
>       "secret_key":
> "h7GhxuBLTrlhVUyxSPUKUV8r\/2EI4ngqJxD7iBdBYLhwluN30JaT3Q=="},
>   "placement_pools": []}
>
> Indeed placement_pools seems empty.
> Is this mandatory?

No, albeit recommended. Otherwise it reverts to the original pool
placement system (probably what happened).

> If so do i need to create the pools first?

It's always recommended to create the pools first, that way you
control the amount of pgs you want per pool. However, for such a test
environment it shouldn't be an issue.

> On Both cluster?

Each zone is separate.

> Should they be the same?

Doesn't really matter, unless you're running everything on the same
cluster, in which case each zone should have its own set of pools.


Yehuda
