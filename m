From: Mustafa Muhammad <mustafa1024m@gmail.com>
Subject: Re: Lots of radosgw-admin commands fail after upgrade
Date: Wed, 9 Nov 2016 08:45:01 +0300
Message-ID: <CAFehDbDDF0cMiHre0DnbSD2-sxc6cFubLVHSOs2HMTtLbkeKJA@mail.gmail.com>
References: <CAFehDbCTSPLmh8LY03q0cfV1v2ACzF24ZShAk+OgSXYJLVjPqg@mail.gmail.com>
 <CABo9giRVAb-+2zvKWTWhRVF4fftG=szDxgrXBXNmDpH-yQrWMw@mail.gmail.com>
 <CAFehDbC6yBsbQCPVmwE+DCod-Xmbafp1MU_r1wYZ0xd_q3Dt3Q@mail.gmail.com>
 <CABo9giTbFUrW1uE4iO5c5=4S4sT9mtxoD+8gi1vemcLCf3RVew@mail.gmail.com>
 <CAFehDbAeF6UqhGHUVYOjvTDhE-+qDAGfLPnk==bbjEUypzeWPw@mail.gmail.com>
 <CABo9giRgopdCqURUJQX3OHCG=O_Q17ZuoJxeX-1-tc1aXpzN1g@mail.gmail.com>
 <CAFehDbDaDdMHTtxLqq8kjd5Xd9RePqDDCXtJm7_7UMCD7Q3LOg@mail.gmail.com> <CABo9giTWVHYGdrqpmtYP8-iDY5tM+a4MrBczwha27=g-HzmRcw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:34921 "EHLO
        mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750774AbcKIFpE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 9 Nov 2016 00:45:04 -0500
Received: by mail-lf0-f52.google.com with SMTP id b14so155821120lfg.2
        for <ceph-devel@vger.kernel.org>; Tue, 08 Nov 2016 21:45:03 -0800 (PST)
In-Reply-To: <CABo9giTWVHYGdrqpmtYP8-iDY5tM+a4MrBczwha27=g-HzmRcw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Orit Wasserman <owasserm@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Tue, Nov 8, 2016 at 3:16 PM, Orit Wasserman <owasserm@redhat.com> wrote:
> On Tue, Nov 8, 2016 at 1:11 PM, Mustafa Muhammad <mustafa1024m@gmail.com> wrote:
>> On Tue, Nov 8, 2016 at 2:21 PM, Orit Wasserman <owasserm@redhat.com> wrote:
>>> On Mon, Nov 7, 2016 at 10:05 AM, Mustafa Muhammad
>>> <mustafa1024m@gmail.com> wrote:
>>>> I understood the script and applied it, "zone get" works fine now with
>>>> realm, but "radosgw-admin zonegroup get" gives "master_zone":
>>>> "default" and realm id with value, then after a minute it goes back to
>>>> empty master_zone and realm id.
>>>
>>> Hi,
>>> Is it possible you have an old radosgw-admin running (from hammer)?
>>> if so you encountered http://tracker.ceph.com/issues/17371, it will be
>>> fixed in 10.2.4.
>>
>> I found I have one Infernalis 9.2.1
>>
>
> that explains it ...
>
>>> Can you provides logs?
>>
>> What logs exactly?
>>
> rgw logs but it looks like we know the cause so it is not important.
>
>>>
>>> Try the procedure again and this time also run in the end:
>>> radosgw-admin period update --commit
>>
>> After updating that RGW?
>>
> yes after doing all the steps
>
All RGWs now on 10.2.2, can't make them 10.2.3 because they won't start.
Stopped them all and run the script again with "radosgw-admin period
update --commit" at the end, still getting:
"zonegroup default missing zone for master_zone="
If I wait till 10.2.4, should it be fixed?

Regards
Mustafa

>>>
>>> Orit
>>>
>>
>> Thanks a lot :)
>>
>> Regards
>> Mustafa
>>
>>>> So I still get:
>>>> radosgw-admin bucket stats
>>>> 2016-11-07 12:04:13.680779 7f7a88e929c0  0 zonegroup default missing
>>>> zone for master_zone=
>>>> couldn't init storage provider
>>>> What should I do?
>>>>
>>>> Thanks
>>>> Mustafa
>>>>
>>>> On Wed, Nov 2, 2016 at 12:39 PM, Orit Wasserman <owasserm@redhat.com> wrote:
>>>>> Hi,
>>>>> You have hit the master zone issue.
>>>>> Here is a fix I prefer:
>>>>> http://lists.ceph.com/pipermail/ceph-users-ceph.com/2016-July/011157.html
>>>>> It is very important notice to run the fix when the radosgw is down.
>>>>>
>>>>> Good luck,
>>>>> Orit
>>>>>
>>>>> On Tue, Nov 1, 2016 at 10:07 PM, Mustafa Muhammad
>>>>> <mustafa1024m@gmail.com> wrote:
>>>>>> On Tue, Nov 1, 2016 at 5:04 PM, Orit Wasserman <owasserm@redhat.com> wrote:
>>>>>>> Hi,
>>>>>>> what version of jewel are you using?
>>>>>>> can you try raodsgw-admin zone get --rgw-zone default and
>>>>>>> radosgw-admin zonegroup get --rgw-zonegroup default?
>>>>>>>
>>>>>> Hello, I am using 10.2.3
>>>>>> #radosgw-admin zone get --rgw-zone default
>>>>>> {
>>>>>>     "id": "default",
>>>>>>     "name": "default",
>>>>>>     "domain_root": ".rgw",
>>>>>>     "control_pool": ".rgw.control",
>>>>>>     "gc_pool": ".rgw.gc",
>>>>>>     "log_pool": ".log",
>>>>>>     "intent_log_pool": ".intent-log",
>>>>>>     "usage_log_pool": ".usage",
>>>>>>     "user_keys_pool": ".users",
>>>>>>     "user_email_pool": ".users.email",
>>>>>>     "user_swift_pool": ".users.swift",
>>>>>>     "user_uid_pool": ".users.uid",
>>>>>>     "system_key": {
>>>>>>         "access_key": "",
>>>>>>         "secret_key": ""
>>>>>>     },
>>>>>>     "placement_pools": [],
>>>>>>     "metadata_heap": ".rgw.meta",
>>>>>>     "realm_id": ""
>>>>>> }
>>>>>>
>>>>>> # radosgw-admin zonegroup get --rgw-zonegroup default
>>>>>> {
>>>>>>     "id": "default",
>>>>>>     "name": "default",
>>>>>>     "api_name": "",
>>>>>>     "is_master": "true",
>>>>>>     "endpoints": [],
>>>>>>     "hostnames": [],
>>>>>>     "hostnames_s3website": [],
>>>>>>     "master_zone": "",
>>>>>>     "zones": [
>>>>>>         {
>>>>>>             "id": "default",
>>>>>>             "name": "default",
>>>>>>             "endpoints": [],
>>>>>>             "log_meta": "false",
>>>>>>             "log_data": "false",
>>>>>>             "bucket_index_max_shards": 0,
>>>>>>             "read_only": "false"
>>>>>>         }
>>>>>>     ],
>>>>>>     "placement_targets": [
>>>>>>         {
>>>>>>             "name": "cinema-placement",
>>>>>>             "tags": []
>>>>>>         },
>>>>>>         {
>>>>>>             "name": "cinema-source-placement",
>>>>>>             "tags": []
>>>>>>         },
>>>>>>         {
>>>>>>             "name": "default-placement",
>>>>>>             "tags": []
>>>>>>         },
>>>>>>         {
>>>>>>             "name": "erasure-placement",
>>>>>>             "tags": []
>>>>>>         },
>>>>>>         {
>>>>>>             "name": "share-placement",
>>>>>>             "tags": []
>>>>>>         },
>>>>>>         {
>>>>>>             "name": "share2016-placement",
>>>>>>             "tags": []
>>>>>>         },
>>>>>>         {
>>>>>>             "name": "test-placement",
>>>>>>             "tags": []
>>>>>>         }
>>>>>>     ],
>>>>>>     "default_placement": "default-placement",
>>>>>>     "realm_id": ""
>>>>>> }
>>>>>>
>>>>>>
>>>>>> Thanks
>>>>>> Mustafa
>>>>>>
>>>>>>> Orit
>>>>>>>
>>>>>>> On Tue, Nov 1, 2016 at 2:13 PM, Mustafa Muhammad <mustafa1024m@gmail.com> wrote:
>>>>>>>> Hello,
>>>>>>>> I have production cluster configured with multiple placement pools according to:
>>>>>>>>
>>>>>>>> http://cephnotes.ksperis.com/blog/2014/11/28/placement-pools-on-rados-gw
>>>>>>>>
>>>>>>>> After upgrading to Jewel, most radosgw-admin are failing, probably
>>>>>>>> because there is no realm
>>>>>>>>
>>>>>>>>
>>>>>>>> # radosgw-admin realm list
>>>>>>>> {
>>>>>>>>     "default_info": "",
>>>>>>>>     "realms": []
>>>>>>>> }
>>>>>>>>
>>>>>>>>
>>>>>>>> # radosgw-admin zone get
>>>>>>>> unable to initialize zone: (2) No such file or directory
>>>>>>>>
>>>>>>>>
>>>>>>>> # radosgw-admin regionmap get
>>>>>>>> failed to read current period info: 2016-11-01 16:08:14.099948
>>>>>>>> 7f21b55ee9c0  0 RGWPeriod::init failed to init realm  id  : (2) No
>>>>>>>> such file or directory(2) No such file or directory
>>>>>>>> {
>>>>>>>>     "zonegroups": [],
>>>>>>>>     "master_zonegroup": "",
>>>>>>>>     "bucket_quota": {
>>>>>>>>         "enabled": false,
>>>>>>>>         "max_size_kb": -1,
>>>>>>>>         "max_objects": -1
>>>>>>>>     },
>>>>>>>>     "user_quota": {
>>>>>>>>         "enabled": false,
>>>>>>>>         "max_size_kb": -1,
>>>>>>>>         "max_objects": -1
>>>>>>>>     }
>>>>>>>> }
>>>>>>>>
>>>>>>>>
>>>>>>>> # radosgw-admin bucket stats
>>>>>>>> 2016-11-01 16:07:55.860053 7f6e747f89c0  0 zonegroup default missing
>>>>>>>> zone for master_zone=
>>>>>>>> couldn't init storage provider
>>>>>>>>
>>>>>>>> I have previous region.conf.json and zone.conf.json, how can I make
>>>>>>>> everything work again? Will creating new realm fix this?
>>>>>>>>
>>>>>>>> Regards
>>>>>>>> Mustafa Muhammad
>>>>>>>> --
>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
