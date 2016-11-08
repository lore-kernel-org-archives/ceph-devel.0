From: David Zafman <dzafman@redhat.com>
Subject: Re: trying to get osd-scrub-repair to work on my jenkins builder
Date: Tue, 8 Nov 2016 15:01:58 -0800
Message-ID: <68bcf424-6ec6-329e-a245-a30942f501c9@redhat.com>
References: <b09099ce-7419-f802-c84b-a425d1c445ff@digiware.nl>
 <8b02c406-1413-5678-2d42-cda6111e8230@digiware.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56884 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752475AbcKHXCA (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 8 Nov 2016 18:02:00 -0500
In-Reply-To: <8b02c406-1413-5678-2d42-cda6111e8230@digiware.nl>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Willem Jan Withagen <wjw@digiware.nl>, Ceph Development <ceph-devel@vger.kernel.org>


Willem,

At first I thought the fields were missing but I checked the xml output 
right there in get_is_making_recovery_progress() and the "xml sel" did 
see those fields while recovery was in progress.

David


On 11/7/16 4:40 AM, Willem Jan Withagen wrote:
> On 4-11-2016 18:09, Willem Jan Withagen wrote:
>> Hi,
>>
>> On my workstation if have this tst completing just fine. But on my
>> Jenkins-builder it keeps running into this state where it does not make
>> any progress.
>> Any particulars I should look for? I can let this run for an hour, but
>> pg 2.0 stays active+degrades, and the script requires it to be clean.
>> and the pgmap version is steadily incrementing.
> And as a side-track to this, it is not where things go wrong. But it is
> nog right either...
>
> ceph -c ./build/src/test/osd/testdir/osd-scrub-repair/ceph.conf --format
> xml status 2>/dev/null | \
>          xml sel \
>          -t -m "//pgmap/recovering_keys_per_sec" -v . -o ' ' \
>          -t -m "//pgmap/recovering_bytes_per_sec" -v . -o ' ' \
>          -t -m "//pgmap/recovering_objects_per_sec" -v .)
>      test -n "$progress"
>
> Does not seem to work because the output does not contain any of the xml
> fields...
> Now I've been beating myself over the head, but I cannot find the
> request that does have these fields.
>
> So a suggestion is welcom, and I'll submit a patch.
>
> thanx,
> --WjW
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

