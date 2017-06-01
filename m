From: David Zafman <dzafman@redhat.com>
Subject: Re: Continous failing osd-scrub-repair.sh
Date: Thu, 1 Jun 2017 01:16:42 -0700
Message-ID: <dee6719f-1188-9e9f-cabd-a7cbcbb88fb1@redhat.com>
References: <2c70fd7a-f0dd-2847-f740-b9e4d248a95f@digiware.nl>
 <3aed9da2-804b-5e7a-6db3-a7663950932e@redhat.com>
 <f864935f-0faf-c0cb-859f-76f2de3d598e@digiware.nl>
 <5716511b-95de-c989-af9e-a3df0893c747@redhat.com>
 <784a780b-50f9-5a82-3907-d4ca3214520c@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46340 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751090AbdFAIQp (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 1 Jun 2017 04:16:45 -0400
In-Reply-To: <784a780b-50f9-5a82-3907-d4ca3214520c@digiware.nl>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>


Willem,

     Yes, I was wrong this wasn't caused by 3ca750d4.   That change 
change only affected the test that did EC on bluestore with EC overwrites.

If you have 44736aac74493b5532c9e3574a37a3642766f212 revert it and see 
if that fixes your problem.

David


On 6/1/17 1:11 AM, Willem Jan Withagen wrote:
>
>
> On 01/06/2017 03:11, David Zafman wrote:
>>
>> The change 3ca750d4 from Josh broke this.  I didn't see before that 
>> the test itself was broken.
>>
> Well then again, this is on FreeBSD, where your millage can (and will) 
> vary.
> For one, we do not do BlueStore atm.
>
> So what is my best option:
>   - See if it is possible if we can fix this?
>   - Disable the test on basis of FreeBSD
>   - Get a different diff-file to compare with?
>
> --WjW
>
>> David
>>
>>
>> On 5/31/17 4:14 PM, Willem Jan Withagen wrote:
>>>
>>>
>>> On 31/05/2017 23:38, David Zafman wrote:
>>>>
>>>> All the failures relate to not have the omap digest available in 
>>>> the object info.  That use to be present before so
>>>>
>>>> that the error omap_digest_mismatch_oi would be detected during 
>>>> this test.
>>>>
>>> So, do you have any idea how this is caused?
>>> What has happened to not have omap digests any longer?
>>>
>>> --WjW
>>>
>>>> David
>>>>
>>>>
>>>> On 5/31/17 1:58 PM, Willem Jan Withagen wrote:
>>>>> Since a few days I have a continuous failing test: 
>>>>> osd-scrub-repair.sh
>>>>>
>>>>> There is a diff failing, where the data looks almost correct. :(
>>>>> Looks there is something wrong with omap_digest.
>>>>>
>>>>> Could this be due to bluestore being enable, whilst FreeBSD does not
>>>>> have that?
>>>>>
>>>>> Anyways, all suggestions are welcome
>>>>>
>>>>> --WjW
>>>>>
>>>>> /home/jenkins/workspace/ceph-master/src/test/osd/osd-scrub-repair.sh:1569: 
>>>>>
>>>>> TEST_corrupt_scrub_replicated:  diff td/osd-scrub-repair/checkcsjson
>>>>> td/osd-scrub-repair/csjson
>>>>> 322c322
>>>>> <     "selected_object_info":
>>>>> "2:f4981d31:::ROBJ4:head(dirty|omap|data_digest|omap_digest s 7 uv 
>>>>> 12 dd
>>>>> 2ddbf8f5 od d7178dfe alloc_hint [0 0 0])",
>>>>> ---
>>>>>>      "selected_object_info":
>>>>> "2:f4981d31:::ROBJ4:head(dirty|omap|data_digest s 7 uv 12 dd 2ddbf8f5
>>>>> alloc_hint [0 0 0])",
>>>>> 333,335c333
>>>>> <         "errors": [
>>>>> <           "omap_digest_mismatch_oi"
>>>>> <         ],
>>>>> ---
>>>>>>          "errors": [],
>>>>> 341,343c339
>>>>> <     "union_shard_errors": [
>>>>> <       "omap_digest_mismatch_oi"
>>>>> <     ]
>>>>> ---
>>>>>>      "union_shard_errors": []
>>>>> 356c352
>>>>> <     "selected_object_info":
>>>>> "2:f4bfd4d1:::ROBJ5:head(dirty|omap|data_digest|omap_digest s 7 uv 
>>>>> 15 dd
>>>>> 2ddbf8f5 od 1a862a41 alloc_hint [0 0 0])",
>>>>> ---
>>>>>>      "selected_object_info":
>>>>> "2:f4bfd4d1:::ROBJ5:head(dirty|omap|data_digest s 7 uv 15 dd 2ddbf8f5
>>>>> alloc_hint [0 0 0])",
>>>>> 367,369c363
>>>>> <         "errors": [
>>>>> <           "omap_digest_mismatch_oi"
>>>>> <         ],
>>>>> ---
>>>>>>          "errors": [],
>>>>> 375,377c369
>>>>> <     "union_shard_errors": [
>>>>> <       "omap_digest_mismatch_oi"
>>>>> <     ]
>>>>> ---
>>>>>>      "union_shard_errors": []
>>>>> 390c382
>>>>> <     "selected_object_info":
>>>>> "2:a53c12e8:::ROBJ6:head(dirty|omap|data_digest|omap_digest s 7 uv 
>>>>> 18 dd
>>>>> 2ddbf8f5 od 689ee887 alloc_hint [0 0 0])",
>>>>> ---
>>>>>>      "selected_object_info":
>>>>> "2:a53c12e8:::ROBJ6:head(dirty|omap|data_digest s 7 uv 18 dd 2ddbf8f5
>>>>> alloc_hint [0 0 0])",
>>>>> 401,403c393
>>>>> <         "errors": [
>>>>> <           "omap_digest_mismatch_oi"
>>>>> <         ],
>>>>> ---
>>>>>>          "errors": [],
>>>>> 409,411c399
>>>>> <     "union_shard_errors": [
>>>>> <       "omap_digest_mismatch_oi"
>>>>> <     ]
>>>>> ---
>>>>>>      "union_shard_errors": []
>>>>> 424c412
>>>>> <     "selected_object_info":
>>>>> "2:8b55fa4b:::ROBJ7:head(dirty|omap|data_digest|omap_digest s 7 uv 
>>>>> 21 dd
>>>>> 2ddbf8f5 od efced57a alloc_hint [0 0 0])",
>>>>> ---
>>>>>>      "selected_object_info":
>>>>> "2:8b55fa4b:::ROBJ7:head(dirty|omap|data_digest s 7 uv 21 dd 2ddbf8f5
>>>>> alloc_hint [0 0 0])",
>>>>> 435,437c423
>>>>> <         "errors": [
>>>>> <           "omap_digest_mismatch_oi"
>>>>> <         ],
>>>>> ---
>>>>>>          "errors": [],
>>>>> 443,445c429
>>>>> <     "union_shard_errors": [
>>>>> <       "omap_digest_mismatch_oi"
>>>>> <     ]
>>>>> ---
>>>>>>      "union_shard_errors": []
>>>>> 459c443
>>>>> <     "selected_object_info":
>>>>> "2:86586531:::ROBJ8:head(dirty|omap|data_digest|omap_digest s 7 uv 
>>>>> 26 dd
>>>>> 2ddbf8f5 od d6be81dc alloc_hint [0 0 0])",
>>>>> ---
>>>>>>      "selected_object_info":
>>>>> "2:86586531:::ROBJ8:head(dirty|omap|data_digest s 7 uv 26 dd 2ddbf8f5
>>>>> alloc_hint [0 0 0])",
>>>>> 532c516
>>>>> <       "version": 56
>>>>> ---
>>>>>>        "version": 50
>>>>> 534c518
>>>>> <     "selected_object_info":
>>>>> "2:ffdb2004:::ROBJ9:head(dirty|omap|data_digest|omap_digest s 3 uv 
>>>>> 56 dd
>>>>> 1f26fb26 od 2eecc539 alloc_hint [0 0 0])",
>>>>> ---
>>>>>>      "selected_object_info":
>>>>> "2:ffdb2004:::ROBJ9:head(dirty|omap|data_digest s 3 uv 50 dd 1f26fb26
>>>>> alloc_hint [0 0 0])",
>>>>> 571c555
>>>>> <         "object_info":
>>>>> "2:ffdb2004:::ROBJ9:head(dirty|omap|data_digest|omap_digest s 3 uv 
>>>>> 56 dd
>>>>> 1f26fb26 od 2eecc539 alloc_hint [0 0 0])",
>>>>> ---
>>>>>>          "object_info": 
>>>>>> "2:ffdb2004:::ROBJ9:head(dirty|omap|data_digest
>>>>> s 3 uv 50 dd 1f26fb26 alloc_hint [0 0 0])",
>>>>> /home/jenkins/workspace/ceph-master/src/test/osd/osd-scrub-repair.sh:1569: 
>>>>>
>>>>> TEST_corrupt_scrub_replicated:  test no = yes
>>>>> /home/jenkins/workspace/ceph-master/src/test/osd/osd-scrub-repair.sh:1569: 
>>>>>
>>>>> -- 
>>>>> To unsubscribe from this list: send the line "unsubscribe 
>>>>> ceph-devel" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe 
>>> ceph-devel" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at http://vger.kernel.org/majordomo-info.html
>>
>

