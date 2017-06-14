From: John Spray <jspray@redhat.com>
Subject: Re: Are we ready for 10.2.8 - cephfs
Date: Wed, 14 Jun 2017 10:25:28 -0400
Message-ID: <CALe9h7dUCBXKnyxGVi3utN_ArkZixO-SZ+xH60L23R11FELMzw@mail.gmail.com>
References: <be949951-5e1c-9471-23f6-2c595baec10a@suse.cz> <CABZ+qq=p_=8PHCwBoo=aQ1V5CeRk4QdNiK7t=ooeisFHB9etyg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wr0-f177.google.com ([209.85.128.177]:33210 "EHLO
        mail-wr0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdFNOZu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jun 2017 10:25:50 -0400
Received: by mail-wr0-f177.google.com with SMTP id r103so742812wrb.0
        for <ceph-devel@vger.kernel.org>; Wed, 14 Jun 2017 07:25:50 -0700 (PDT)
In-Reply-To: <CABZ+qq=p_=8PHCwBoo=aQ1V5CeRk4QdNiK7t=ooeisFHB9etyg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan van der Ster <dan@vanderster.com>
Cc: Nathan Cutler <ncutler@suse.cz>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 13, 2017 at 7:49 AM, Dan van der Ster <dan@vanderster.com> wrote:
> Hi,
>
> Would it be possible to get these into 10.2.8?
>
>     http://tracker.ceph.com/issues/19677
>     http://tracker.ceph.com/issues/19762
>     http://tracker.ceph.com/issues/20027

I've been a bit behind on reviewing backports lately, sorry about that.

I've merged the first two of those.  The third one had a PR that
didn't have the cephfs label so it got missed.

Nathan, if we have time to do another pre-merge test run for jewel
backports, then there are a few with label:cephfs and my review on,
that would just need to go through a fs suite.

Cheers,
John

> Thanks!
>
> Dan
>
>
> On Fri, Jun 9, 2017 at 6:13 PM, Nathan Cutler <ncutler@suse.cz> wrote:
>> Hi John:
>>
>> The following cephfs backports have been merged into the jewel branch in
>> preparation for the 10.2.8 release.
>>
>> http://tracker.ceph.com/projects/cephfs/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%3D&v%5Bstatus_id%5D%5B%5D=3&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=9&f%5B%5D=fixed_version_id&op%5Bfixed_version_id%5D=%3D&v%5Bfixed_version_id%5D%5B%5D=537&f%5B%5D=&c%5B%5D=project&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=category&c%5B%5D=fixed_version&c%5B%5D=cf_3&group_by=&t%5B%5D=
>>
>> (I thought there were more than two, but apparently not?)
>>
>> Do you think it's time for QE to do its testing?
>>
>> Nathan
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
