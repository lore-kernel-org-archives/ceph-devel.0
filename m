From: John Spray <jspray@redhat.com>
Subject: Re: Are we ready for 10.2.8 - cephfs
Date: Tue, 27 Jun 2017 12:51:27 +0100
Message-ID: <CALe9h7d0jAV1_2Z+ok4wHvPmGAUepfmgjOxoZ6s5QUC=5=pHtA@mail.gmail.com>
References: <be949951-5e1c-9471-23f6-2c595baec10a@suse.cz> <CABZ+qq=p_=8PHCwBoo=aQ1V5CeRk4QdNiK7t=ooeisFHB9etyg@mail.gmail.com>
 <CALe9h7dUCBXKnyxGVi3utN_ArkZixO-SZ+xH60L23R11FELMzw@mail.gmail.com> <cd9be044-1b2f-c698-4207-e6fbaaa854c7@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:32864 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752828AbdF0Lvu (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 27 Jun 2017 07:51:50 -0400
Received: by mail-wm0-f50.google.com with SMTP id z75so5167063wmc.0
        for <ceph-devel@vger.kernel.org>; Tue, 27 Jun 2017 04:51:49 -0700 (PDT)
In-Reply-To: <cd9be044-1b2f-c698-4207-e6fbaaa854c7@suse.cz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Nathan Cutler <ncutler@suse.cz>
Cc: Dan van der Ster <dan@vanderster.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Tue, Jun 27, 2017 at 12:41 PM, Nathan Cutler <ncutler@suse.cz> wrote:
> Hi John:
>
> I believe we have all the requested CephFS fixes in, now. Do you think
> 10.2.8 is ready for QE, as far as CephFS is concerned?

Yes, I think we're good.

John

>
> Nathan
>
>
> On 06/14/2017 04:25 PM, John Spray wrote:
>>
>> On Tue, Jun 13, 2017 at 7:49 AM, Dan van der Ster <dan@vanderster.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> Would it be possible to get these into 10.2.8?
>>>
>>>      http://tracker.ceph.com/issues/19677
>>>      http://tracker.ceph.com/issues/19762
>>>      http://tracker.ceph.com/issues/20027
>>
>>
>> I've been a bit behind on reviewing backports lately, sorry about that.
>>
>> I've merged the first two of those.  The third one had a PR that
>> didn't have the cephfs label so it got missed.
>>
>> Nathan, if we have time to do another pre-merge test run for jewel
>> backports, then there are a few with label:cephfs and my review on,
>> that would just need to go through a fs suite.
>>
>> Cheers,
>> John
