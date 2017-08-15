From: Jos Collin <jcollin@redhat.com>
Subject: Re: warnings in rgw_crypt.cc
Date: Tue, 15 Aug 2017 07:18:04 +0530
Message-ID: <74847d74-ed64-163d-eceb-2284d603c077@redhat.com>
References: <CALe9h7cCO+ZLHysdHr8AueyfkHLMvj1Wsy7CO0763cD3ydcJ3w@mail.gmail.com>
 <CAJ4mKGYODRagB-a6-QRMm1Npj28QdpmPq9jdfo7DygfPvS0qjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pg0-f47.google.com ([74.125.83.47]:34364 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753707AbdHOBsJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 14 Aug 2017 21:48:09 -0400
Received: by mail-pg0-f47.google.com with SMTP id u185so57971429pgb.1
        for <ceph-devel@vger.kernel.org>; Mon, 14 Aug 2017 18:48:09 -0700 (PDT)
In-Reply-To: <CAJ4mKGYODRagB-a6-QRMm1Npj28QdpmPq9jdfo7DygfPvS0qjg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>, John Spray <jspray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

Hi,

@Greg:
No, your PR is not merged it seems.
Please see:
https://github.com/ceph/ceph/blob/master/src/rgw/rgw_crypt.cc#L38
https://github.com/ceph/ceph/blob/master/src/rgw/rgw_crypt.cc#L247

I have created the following tracker the moment I saw this warning:
http://tracker.ceph.com/issues/19851

and

This PR https://github.com/ceph/ceph/pull/14498, implements this 
requirement.

But the progress of this PR seems to be very slow. As this warning is 
annoying and appears in every PR tests and builds, I have created a PR 
yesterday for removing it sooner:
https://github.com/ceph/ceph/pull/17012

Please review.

Thanks,
Jos Collin

On Monday 14 August 2017 10:11 PM, Gregory Farnum wrote:
> On Mon, Aug 14, 2017 at 9:38 AM, John Spray <jspray@redhat.com> wrote:
>> Hi all,
>>
>> These have been in master for quite a while now:
>>
>> /home/jenkins-build/build/workspace/ceph-pull-requests/src/rgw/rgw_crypt.cc:38:2:
>> warning: #warning "TODO: move this code to auth/Crypto for others to
>> reuse." [-Wcpp]
>>  #warning "TODO: move this code to auth/Crypto for others to reuse."
>>   ^
>> /home/jenkins-build/build/workspace/ceph-pull-requests/src/rgw/rgw_crypt.cc:247:2:
>> warning: #warning "TODO: use auth/Crypto instead of reimplementing."
>> [-Wcpp]
>>  #warning "TODO: use auth/Crypto instead of reimplementing."
>>   ^
>>
>> Is anyone working in this area?  Otherwise we should probably just
>> create tracker tickets instead of using preprocessor macros as
>> reminders.
>
> Yes. A few key people have had fantasies that this was going to be the
> next thing on X person's list, but that's clearly not happening. I'd
> merge a PR changing that. :)
> -Greg
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
