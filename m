From: Willem Jan Withagen <wjw@digiware.nl>
Subject: Re: trying to get osd-scrub-repair to work on my jenkins builder
Date: Wed, 9 Nov 2016 00:21:02 +0100
Message-ID: <93f4ceb7-eaf2-bb9e-d0e8-599130054bd6@digiware.nl>
References: <b09099ce-7419-f802-c84b-a425d1c445ff@digiware.nl>
 <8b02c406-1413-5678-2d42-cda6111e8230@digiware.nl>
 <68bcf424-6ec6-329e-a245-a30942f501c9@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.digiware.nl ([176.74.240.9]:52512 "EHLO smtp.digiware.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753294AbcKHXVH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Nov 2016 18:21:07 -0500
In-Reply-To: <68bcf424-6ec6-329e-a245-a30942f501c9@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: David Zafman <dzafman@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 9-11-2016 00:01, David Zafman wrote:
> 
> Willem,
> 
> At first I thought the fields were missing but I checked the xml output
> right there in get_is_making_recovery_progress() and the "xml sel" did
> see those fields while recovery was in progress.

Oke, ...

That leaves a challenge, and I'll have to review the output on FreeBSD
again, and see where, what, how it then works.

--WjW

> 
> David
> 
> 
> On 11/7/16 4:40 AM, Willem Jan Withagen wrote:
>> On 4-11-2016 18:09, Willem Jan Withagen wrote:
>>> Hi,
>>>
>>> On my workstation if have this tst completing just fine. But on my
>>> Jenkins-builder it keeps running into this state where it does not make
>>> any progress.
>>> Any particulars I should look for? I can let this run for an hour, but
>>> pg 2.0 stays active+degrades, and the script requires it to be clean.
>>> and the pgmap version is steadily incrementing.
>> And as a side-track to this, it is not where things go wrong. But it is
>> nog right either...
>>
>> ceph -c ./build/src/test/osd/testdir/osd-scrub-repair/ceph.conf --format
>> xml status 2>/dev/null | \
>>          xml sel \
>>          -t -m "//pgmap/recovering_keys_per_sec" -v . -o ' ' \
>>          -t -m "//pgmap/recovering_bytes_per_sec" -v . -o ' ' \
>>          -t -m "//pgmap/recovering_objects_per_sec" -v .)
>>      test -n "$progress"
>>
>> Does not seem to work because the output does not contain any of the xml
>> fields...
>> Now I've been beating myself over the head, but I cannot find the
>> request that does have these fields.
>>
>> So a suggestion is welcom, and I'll submit a patch.
>>
>> thanx,
>> --WjW
>>
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

