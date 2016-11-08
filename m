From: Orit Wasserman <owasserm@redhat.com>
Subject: Re: Lots of radosgw-admin commands fail after upgrade
Date: Tue, 8 Nov 2016 12:21:08 +0100
Message-ID: <CABo9giRgopdCqURUJQX3OHCG=O_Q17ZuoJxeX-1-tc1aXpzN1g@mail.gmail.com>
References: <CAFehDbCTSPLmh8LY03q0cfV1v2ACzF24ZShAk+OgSXYJLVjPqg@mail.gmail.com>
 <CABo9giRVAb-+2zvKWTWhRVF4fftG=szDxgrXBXNmDpH-yQrWMw@mail.gmail.com>
 <CAFehDbC6yBsbQCPVmwE+DCod-Xmbafp1MU_r1wYZ0xd_q3Dt3Q@mail.gmail.com>
 <CABo9giTbFUrW1uE4iO5c5=4S4sT9mtxoD+8gi1vemcLCf3RVew@mail.gmail.com> <CAFehDbAeF6UqhGHUVYOjvTDhE-+qDAGfLPnk==bbjEUypzeWPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36919 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752961AbcKHLVL (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Nov 2016 06:21:11 -0500
Received: by mail-wm0-f51.google.com with SMTP id t79so232486420wmt.0
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 03:21:10 -0800 (PST)
In-Reply-To: <CAFehDbAeF6UqhGHUVYOjvTDhE-+qDAGfLPnk==bbjEUypzeWPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mustafa Muhammad <mustafa1024m@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, Nov 7, 2016 at 10:05 AM, Mustafa Muhammad
<mustafa1024m@gmail.com> wrote:
> I understood the script and applied it, "zone get" works fine now with
> realm, but "radosgw-admin zonegroup get" gives "master_zone":
> "default" and realm id with value, then after a minute it goes back to
> empty master_zone and realm id.

Hi,
Is it possible you have an old radosgw-admin running (from hammer)?
if so you encountered http://tracker.ceph.com/issues/17371, it will be
fixed in 10.2.4.
Can you provides logs?

Try the procedure again and this time also run in the end:
radosgw-admin period update --commit

Orit

> So I still get:
> radosgw-admin bucket stats
> 2016-11-07 12:04:13.680779 7f7a88e929c0  0 zonegroup default missing
> zone for master_zone=
> couldn't init storage provider
> What should I do?
>
> Thanks
> Mustafa
>
> On Wed, Nov 2, 2016 at 12:39 PM, Orit Wasserman <owasserm@redhat.com> wrote:
>> Hi,
>> You have hit the master zone issue.
>> Here is a fix I prefer:
>> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2016-July/011157.html
>> It is very important notice to run the fix when the radosgw is down.
>>
>> Good luck,
>> Orit
>>
>> On Tue, Nov 1, 2016 at 10:07 PM, Mustafa Muhammad
>> <mustafa1024m@gmail.com> wrote:
>>> On Tue, Nov 1, 2016 at 5:04 PM, Orit Wasserman <owasserm@redhat.com> wrote:
>>>> Hi,
>>>> what version of jewel are you using?
>>>> can you try raodsgw-admin zone get --rgw-zone default and
>>>> radosgw-admin zonegroup get --rgw-zonegroup default?
>>>>
>>> Hello, I am using 10.2.3
>>> #radosgw-admin zone get --rgw-zone default
>>> {
>>>     "id": "default",
>>>     "name": "default",
>>>     "domain_root": ".rgw",
>>>     "control_pool": ".rgw.control",
>>>     "gc_pool": ".rgw.gc",
>>>     "log_pool": ".log",
>>>     "intent_log_pool": ".intent-log",
>>>     "usage_log_pool": ".usage",
>>>     "user_keys_pool": ".users",
>>>     "user_email_pool": ".users.email",
>>>     "user_swift_pool": ".users.swift",
>>>     "user_uid_pool": ".users.uid",
>>>     "system_key": {
>>>         "access_key": "",
>>>         "secret_key": ""
>>>     },
>>>     "placement_pools": [],
>>>     "metadata_heap": ".rgw.meta",
>>>     "realm_id": ""
>>> }
>>>
>>> # radosgw-admin zonegroup get --rgw-zonegroup default
>>> {
>>>     "id": "default",
>>>     "name": "default",
>>>     "api_name": "",
>>>     "is_master": "true",
>>>     "endpoints": [],
>>>     "hostnames": [],
>>>     "hostnames_s3website": [],
>>>     "master_zone": "",
>>>     "zones": [
>>>         {
>>>             "id": "default",
>>>             "name": "default",
>>>             "endpoints": [],
>>>             "log_meta": "false",
>>>             "log_data": "false",
>>>             "bucket_index_max_shards": 0,
>>>             "read_only": "false"
>>>         }
>>>     ],
>>>     "placement_targets": [
>>>         {
>>>             "name": "cinema-placement",
>>>             "tags": []
>>>         },
>>>         {
>>>             "name": "cinema-source-placement",
>>>             "tags": []
>>>         },
>>>         {
>>>             "name": "default-placement",
>>>             "tags": []
>>>         },
>>>         {
>>>             "name": "erasure-placement",
>>>             "tags": []
>>>         },
>>>         {
>>>             "name": "share-placement",
>>>             "tags": []
>>>         },
>>>         {
>>>             "name": "share2016-placement",
>>>             "tags": []
>>>         },
>>>         {
>>>             "name": "test-placement",
>>>             "tags": []
>>>         }
>>>     ],
>>>     "default_placement": "default-placement",
>>>     "realm_id": ""
>>> }
>>>
>>>
>>> Thanks
>>> Mustafa
>>>
>>>> Orit
>>>>
>>>> On Tue, Nov 1, 2016 at 2:13 PM, Mustafa Muhammad <mustafa1024m@gmail.com> wrote:
>>>>> Hello,
>>>>> I have production cluster configured with multiple placement pools according to:
>>>>>
>>>>> http://cephnotes.ksperis.com/blog/2014/11/28/placement-pools-on-rados-gw
>>>>>
>>>>> After upgrading to Jewel, most radosgw-admin are failing, probably
>>>>> because there is no realm
>>>>>
>>>>>
>>>>> # radosgw-admin realm list
>>>>> {
>>>>>     "default_info": "",
>>>>>     "realms": []
>>>>> }
>>>>>
>>>>>
>>>>> # radosgw-admin zone get
>>>>> unable to initialize zone: (2) No such file or directory
>>>>>
>>>>>
>>>>> # radosgw-admin regionmap get
>>>>> failed to read current period info: 2016-11-01 16:08:14.099948
>>>>> 7f21b55ee9c0  0 RGWPeriod::init failed to init realm  id  : (2) No
>>>>> such file or directory(2) No such file or directory
>>>>> {
>>>>>     "zonegroups": [],
>>>>>     "master_zonegroup": "",
>>>>>     "bucket_quota": {
>>>>>         "enabled": false,
>>>>>         "max_size_kb": -1,
>>>>>         "max_objects": -1
>>>>>     },
>>>>>     "user_quota": {
>>>>>         "enabled": false,
>>>>>         "max_size_kb": -1,
>>>>>         "max_objects": -1
>>>>>     }
>>>>> }
>>>>>
>>>>>
>>>>> # radosgw-admin bucket stats
>>>>> 2016-11-01 16:07:55.860053 7f6e747f89c0  0 zonegroup default missing
>>>>> zone for master_zone=
>>>>> couldn't init storage provider
>>>>>
>>>>> I have previous region.conf.json and zone.conf.json, how can I make
>>>>> everything work again? Will creating new realm fix this?
>>>>>
>>>>> Regards
>>>>> Mustafa Muhammad
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
